// lib/features/community/data/datasources/community_remote_datasource.dart
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fitness/core/errors/exceptions.dart';
import 'package:fitness/features/community/data/models/community_post_model.dart';
import 'package:fitness/features/community/data/models/community_group_model.dart';
import 'package:fitness/features/community/data/models/user_connection_model.dart';
import 'package:fitness/features/community/data/models/comment_model.dart';
import 'package:fitness/features/community/data/models/notification_model.dart';
import 'package:fitness/features/onboarding/data/models/fitness_profile_model.dart';
import 'package:injectable/injectable.dart';

@LazySingleton()
class CommunityRemoteDatasource {
  final FirebaseFirestore _firestore;
  final FirebaseAuth _auth;

  CommunityRemoteDatasource(this._firestore, this._auth);

  static const String _postsCollection = 'communityPosts';
  static const String _groupsCollection = 'communityGroups';
  static const String _connectionsCollection = 'userConnections';
  static const String _commentsCollection = 'comments';
  static const String _notificationsCollection = 'notifications';
  static const String _profilesCollection = 'userProfiles';

  String get _currentUid => _auth.currentUser!.uid;

  // ========== POSTS ==========

  /// Create a new post
  Future<void> createPost(CommunityPostModel post) async {
    try {
      final batch = _firestore.batch();

      // Create post
      final postRef = _firestore.collection(_postsCollection).doc(post.id);
      batch.set(postRef, post.toJson());

      // Update user's post count
      final profileRef =
          _firestore.collection(_profilesCollection).doc(_currentUid);
      batch.update(profileRef, {
        'postsCount': FieldValue.increment(1),
        'lastActive': FieldValue.serverTimestamp(),
      });

      await batch.commit();
    } on FirebaseException catch (e) {
      throw ServerException(message: 'Firestore error: ${e.message}');
    }
  }

  /// Get feed posts with smart filtering
  Future<List<CommunityPostModel>> getFeedPosts({
    FitnessProfileModel? userProfile,
    int limit = 20,
    DocumentSnapshot? lastDocument,
  }) async {
    try {
      Query query = _firestore
          .collection(_postsCollection)
          .orderBy('createdAt', descending: true)
          .limit(limit);

      if (lastDocument != null) {
        query = query.startAfterDocument(lastDocument);
      }

      // Smart filtering based on user profile
      if (userProfile != null) {
        // Get posts from users with similar goals
        query = query.where('userFitnessGoal',
            isEqualTo: userProfile.primaryGoal.toString());
      }

      final snapshot = await query.get();
      return snapshot.docs
          .map((doc) =>
              CommunityPostModel.fromJson(doc.data() as Map<String, dynamic>))
          .toList();
    } on FirebaseException catch (e) {
      throw ServerException(message: 'Firestore error: ${e.message}');
    }
  }

  /// Get posts by user
  Future<List<CommunityPostModel>> getUserPosts(String userId) async {
    try {
      final snapshot = await _firestore
          .collection(_postsCollection)
          .where('userId', isEqualTo: userId)
          .orderBy('createdAt', descending: true)
          .get();

      return snapshot.docs
          .map((doc) => CommunityPostModel.fromJson(doc.data()))
          .toList();
    } on FirebaseException catch (e) {
      throw ServerException(message: 'Firestore error: ${e.message}');
    }
  }

  /// Like a post
  Future<void> likePost(String postId) async {
    try {
      final postRef = _firestore.collection(_postsCollection).doc(postId);

      await _firestore.runTransaction((transaction) async {
        final snapshot = await transaction.get(postRef);

        if (!snapshot.exists) {
          throw ServerException(message: 'Post not found');
        }

        final data = snapshot.data()!;
        final likedBy = List<String>.from(data['likedBy'] ?? []);
        final postOwnerId = data['userId'] as String;

        if (likedBy.contains(_currentUid)) {
          // Unlike
          likedBy.remove(_currentUid);
          transaction.update(postRef, {
            'likes': FieldValue.increment(-1),
            'likedBy': likedBy,
          });
        } else {
          // Like
          likedBy.add(_currentUid);
          transaction.update(postRef, {
            'likes': FieldValue.increment(1),
            'likedBy': likedBy,
          });

          // Create notification for post owner
          if (postOwnerId != _currentUid) {
            await _createNotification(
              userId: postOwnerId,
              type: NotificationType.like,
              content: 'liked your post',
              referenceId: postId,
            );
          }
        }
      });
    } on FirebaseException catch (e) {
      throw ServerException(message: 'Firestore error: ${e.message}');
    }
  }

  /// Delete a post
  Future<void> deletePost(String postId) async {
    try {
      final batch = _firestore.batch();

      // Delete post
      final postRef = _firestore.collection(_postsCollection).doc(postId);
      batch.delete(postRef);

      // Update user's post count
      final profileRef =
          _firestore.collection(_profilesCollection).doc(_currentUid);
      batch.update(profileRef, {
        'postsCount': FieldValue.increment(-1),
      });

      // Delete all comments
      final commentsSnapshot = await _firestore
          .collection(_postsCollection)
          .doc(postId)
          .collection(_commentsCollection)
          .get();

      for (var doc in commentsSnapshot.docs) {
        batch.delete(doc.reference);
      }

      await batch.commit();
    } on FirebaseException catch (e) {
      throw ServerException(message: 'Firestore error: ${e.message}');
    }
  }

  // ========== COMMENTS ==========

  /// Get comments for a post
  Future<List<CommentModel>> getComments(String postId) async {
    try {
      final snapshot = await _firestore
          .collection(_postsCollection)
          .doc(postId)
          .collection(_commentsCollection)
          .orderBy('createdAt', descending: true)
          .get();

      return snapshot.docs
          .map((doc) => CommentModel.fromJson(doc.data()))
          .toList();
    } on FirebaseException catch (e) {
      throw ServerException(message: 'Firestore error: ${e.message}');
    }
  }

  /// Add a comment
  Future<void> addComment(CommentModel comment) async {
    try {
      final batch = _firestore.batch();

      // Add comment
      final commentRef = _firestore
          .collection(_postsCollection)
          .doc(comment.postId)
          .collection(_commentsCollection)
          .doc(comment.id);
      batch.set(commentRef, comment.toJson());

      // Update post comment count
      final postRef =
          _firestore.collection(_postsCollection).doc(comment.postId);
      batch.update(postRef, {
        'comments': FieldValue.increment(1),
      });

      await batch.commit();

      // Get post owner to send notification
      final postDoc = await postRef.get();
      final postOwnerId = postDoc.data()?['userId'] as String?;

      if (postOwnerId != null && postOwnerId != _currentUid) {
        await _createNotification(
          userId: postOwnerId,
          type: NotificationType.comment,
          content: 'commented on your post',
          referenceId: comment.postId,
        );
      }
    } on FirebaseException catch (e) {
      throw ServerException(message: 'Firestore error: ${e.message}');
    }
  }

  /// Delete a comment
  Future<void> deleteComment(String postId, String commentId) async {
    try {
      final batch = _firestore.batch();

      // Delete comment
      final commentRef = _firestore
          .collection(_postsCollection)
          .doc(postId)
          .collection(_commentsCollection)
          .doc(commentId);
      batch.delete(commentRef);

      // Update post comment count
      final postRef = _firestore.collection(_postsCollection).doc(postId);
      batch.update(postRef, {
        'comments': FieldValue.increment(-1),
      });

      await batch.commit();
    } on FirebaseException catch (e) {
      throw ServerException(message: 'Firestore error: ${e.message}');
    }
  }

  // ========== GROUPS ==========

  /// Get all groups
  Future<List<CommunityGroupModel>> getAllGroups() async {
    try {
      final snapshot = await _firestore
          .collection(_groupsCollection)
          .orderBy('memberCount', descending: true)
          .get();

      return snapshot.docs
          .map((doc) => CommunityGroupModel.fromJson(doc.data()))
          .toList();
    } on FirebaseException catch (e) {
      throw ServerException(message: 'Firestore error: ${e.message}');
    }
  }

  /// Get recommended groups based on user profile
  Future<List<CommunityGroupModel>> getRecommendedGroups(
    FitnessProfileModel profile,
  ) async {
    try {
      final allGroups = <CommunityGroupModel>[];

      // Get groups matching user's fitness goal
      final goalGroups = await _firestore
          .collection(_groupsCollection)
          .where('fitnessGoal', isEqualTo: profile.primaryGoal.toString())
          .limit(5)
          .get();

      allGroups.addAll(
        goalGroups.docs.map((doc) => CommunityGroupModel.fromJson(doc.data())),
      );

      // Get groups matching workout preferences
      for (var pref in profile.workoutPreferences) {
        final snapshot = await _firestore
            .collection(_groupsCollection)
            .where('workoutPreference', isEqualTo: pref)
            .limit(3)
            .get();

        allGroups.addAll(
          snapshot.docs.map((doc) => CommunityGroupModel.fromJson(doc.data())),
        );
      }

      // Remove duplicates
      final uniqueGroups = <String, CommunityGroupModel>{};
      for (var group in allGroups) {
        uniqueGroups[group.id] = group;
      }

      return uniqueGroups.values.toList();
    } on FirebaseException catch (e) {
      throw ServerException(message: 'Firestore error: ${e.message}');
    }
  }

  /// Get user's joined groups
  Future<List<CommunityGroupModel>> getUserGroups() async {
    try {
      final snapshot = await _firestore
          .collection(_groupsCollection)
          .where('members', arrayContains: _currentUid)
          .get();

      return snapshot.docs
          .map((doc) => CommunityGroupModel.fromJson(doc.data()))
          .toList();
    } on FirebaseException catch (e) {
      throw ServerException(message: 'Firestore error: ${e.message}');
    }
  }

  /// Join a group
  Future<void> joinGroup(String groupId) async {
    try {
      final groupRef = _firestore.collection(_groupsCollection).doc(groupId);

      await _firestore.runTransaction((transaction) async {
        final snapshot = await transaction.get(groupRef);

        if (!snapshot.exists) {
          throw ServerException(message: 'Group not found');
        }

        final members = List<String>.from(snapshot.data()?['members'] ?? []);

        if (!members.contains(_currentUid)) {
          members.add(_currentUid);
          transaction.update(groupRef, {
            'memberCount': FieldValue.increment(1),
            'members': members,
          });
        }
      });
    } on FirebaseException catch (e) {
      throw ServerException(message: 'Firestore error: ${e.message}');
    }
  }

  /// Leave a group
  Future<void> leaveGroup(String groupId) async {
    try {
      final groupRef = _firestore.collection(_groupsCollection).doc(groupId);

      await _firestore.runTransaction((transaction) async {
        final snapshot = await transaction.get(groupRef);

        if (!snapshot.exists) {
          throw ServerException(message: 'Group not found');
        }

        final members = List<String>.from(snapshot.data()?['members'] ?? []);

        if (members.contains(_currentUid)) {
          members.remove(_currentUid);
          transaction.update(groupRef, {
            'memberCount': FieldValue.increment(-1),
            'members': members,
          });
        }
      });
    } on FirebaseException catch (e) {
      throw ServerException(message: 'Firestore error: ${e.message}');
    }
  }

  // ========== CONNECTIONS ==========

  /// Find workout buddies with similar profiles
  Future<List<FitnessProfileModel>> findWorkoutBuddies(
    FitnessProfileModel userProfile,
  ) async {
    try {
      final buddies = <FitnessProfileModel>[];

      // Find users with same goal and gender
      final goalMatches = await _firestore
          .collection(_profilesCollection)
          .where('primaryGoal', isEqualTo: userProfile.primaryGoal.toString())
          .where('gender', isEqualTo: userProfile.gender)
          .limit(20)
          .get();

      for (var doc in goalMatches.docs) {
        if (doc.id != _currentUid) {
          buddies.add(FitnessProfileModel.fromJson(doc.data()));
        }
      }

      return buddies;
    } on FirebaseException catch (e) {
      throw ServerException(message: 'Firestore error: ${e.message}');
    }
  }

  /// Follow a user
  Future<void> followUser(
      String targetUserId, String targetUserName, String? photoUrl) async {
    try {
      final batch = _firestore.batch();

      final connectionId = '${_currentUid}_$targetUserId';
      final connectionRef =
          _firestore.collection(_connectionsCollection).doc(connectionId);

      // Get current user info

      batch.set(connectionRef, {
        'userId': _currentUid,
        'connectedUserId': targetUserId,
        'connectedUserName': targetUserName,
        'connectedUserPhotoUrl': photoUrl,
        'connectionType': ConnectionType.following.toString(),
        'compatibilityScore': 0,
        'sharedInterests': [],
        'connectedAt': FieldValue.serverTimestamp(),
      });

      // Update follower/following counts
      final currentUserRef =
          _firestore.collection(_profilesCollection).doc(_currentUid);
      batch.update(currentUserRef, {
        'followingCount': FieldValue.increment(1),
      });

      final targetUserRef =
          _firestore.collection(_profilesCollection).doc(targetUserId);
      batch.update(targetUserRef, {
        'followersCount': FieldValue.increment(1),
      });

      await batch.commit();

      // Send notification
      await _createNotification(
        userId: targetUserId,
        type: NotificationType.follow,
        content: 'started following you',
        referenceId: _currentUid,
      );
    } on FirebaseException catch (e) {
      throw ServerException(message: 'Firestore error: ${e.message}');
    }
  }

  /// Unfollow a user
  Future<void> unfollowUser(String targetUserId) async {
    try {
      final batch = _firestore.batch();

      final connectionId = '${_currentUid}_$targetUserId';
      final connectionRef =
          _firestore.collection(_connectionsCollection).doc(connectionId);
      batch.delete(connectionRef);

      // Update follower/following counts
      final currentUserRef =
          _firestore.collection(_profilesCollection).doc(_currentUid);
      batch.update(currentUserRef, {
        'followingCount': FieldValue.increment(-1),
      });

      final targetUserRef =
          _firestore.collection(_profilesCollection).doc(targetUserId);
      batch.update(targetUserRef, {
        'followersCount': FieldValue.increment(-1),
      });

      await batch.commit();
    } on FirebaseException catch (e) {
      throw ServerException(message: 'Firestore error: ${e.message}');
    }
  }

  /// Get user's connections
  Future<List<UserConnectionModel>> getConnections(ConnectionType type) async {
    try {
      final snapshot = await _firestore
          .collection(_connectionsCollection)
          .where('userId', isEqualTo: _currentUid)
          .where('connectionType', isEqualTo: type.toString())
          .get();

      return snapshot.docs
          .map((doc) => UserConnectionModel.fromJson(doc.data()))
          .toList();
    } on FirebaseException catch (e) {
      throw ServerException(message: 'Firestore error: ${e.message}');
    }
  }

  /// Check if following a user
  Future<bool> isFollowing(String targetUserId) async {
    try {
      final connectionId = '${_currentUid}_$targetUserId';
      final doc = await _firestore
          .collection(_connectionsCollection)
          .doc(connectionId)
          .get();

      return doc.exists;
    } on FirebaseException catch (e) {
      throw ServerException(message: 'Firestore error: ${e.message}');
    }
  }

  /// Get user notifications
  Future<List<NotificationModel>> getNotifications() async {
    try {
      final snapshot = await _firestore
          .collection(_notificationsCollection)
          .where('userId', isEqualTo: _currentUid)
          .orderBy('createdAt', descending: true)
          .limit(50)
          .get();

      return snapshot.docs
          .map((doc) => NotificationModel.fromJson(doc.data()))
          .toList();
    } on FirebaseException catch (e) {
      throw ServerException(message: 'Firestore error: ${e.message}');
    }
  }

  /// Mark notification as read
  Future<void> markNotificationAsRead(String notificationId) async {
    try {
      await _firestore
          .collection(_notificationsCollection)
          .doc(notificationId)
          .update({'isRead': true});
    } on FirebaseException catch (e) {
      throw ServerException(message: 'Firestore error: ${e.message}');
    }
  }

  /// Mark all notifications as read
  Future<void> markAllNotificationsAsRead() async {
    try {
      final snapshot = await _firestore
          .collection(_notificationsCollection)
          .where('userId', isEqualTo: _currentUid)
          .where('isRead', isEqualTo: false)
          .get();

      final batch = _firestore.batch();
      for (var doc in snapshot.docs) {
        batch.update(doc.reference, {'isRead': true});
      }
      await batch.commit();
    } on FirebaseException catch (e) {
      throw ServerException(message: 'Firestore error: ${e.message}');
    }
  }

  /// Create a notification (helper method)
  Future<void> _createNotification({
    required String userId,
    required NotificationType type,
    required String content,
    String? referenceId,
  }) async {
    try {
      final currentUserDoc = await _firestore
          .collection(_profilesCollection)
          .doc(_currentUid)
          .get();

      final userName = currentUserDoc.data()?['displayName'] ?? 'Someone';
      final photoUrl = currentUserDoc.data()?['photoUrl'] as String?;

      final notificationId =
          _firestore.collection(_notificationsCollection).doc().id;

      await _firestore
          .collection(_notificationsCollection)
          .doc(notificationId)
          .set({
        'id': notificationId,
        'userId': userId,
        'type': type.toString(),
        'fromUserId': _currentUid,
        'fromUserName': userName,
        'fromUserPhotoUrl': photoUrl,
        'content': content,
        'referenceId': referenceId,
        'isRead': false,
        'createdAt': FieldValue.serverTimestamp(),
      });
    } catch (e) {
      // Don't throw error if notification fails - it's not critical
    }
  }
}
