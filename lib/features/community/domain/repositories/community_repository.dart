// lib/features/community/domain/repositories/community_repository.dart
import 'package:dartz/dartz.dart';
import 'package:fitness/core/errors/failures.dart';
import 'package:fitness/features/community/data/models/community_post_model.dart';
import 'package:fitness/features/community/data/models/community_group_model.dart';
import 'package:fitness/features/community/data/models/user_connection_model.dart';
import 'package:fitness/features/onboarding/data/models/fitness_profile_model.dart';

abstract class CommunityRepository {
  Future<Either<Failure, void>> createPost(CommunityPostModel post);
  Future<Either<Failure, List<CommunityPostModel>>> getFeedPosts({
    FitnessProfileModel? userProfile,
    int limit,
  });
  Future<Either<Failure, void>> likePost(String postId);
  Future<Either<Failure, List<CommunityGroupModel>>> getRecommendedGroups(
    FitnessProfileModel profile,
  );
  Future<Either<Failure, List<FitnessProfileModel>>> findWorkoutBuddies(
    FitnessProfileModel profile,
  );
  // Future<Either<Failure, void>> followUser(
  //     String userId, String userName, String? photoUrl);
  Future<Either<Failure, void>> joinGroup(String groupId);
  Future<Either<Failure, void>> followUser(
    String targetUserId,
    String targetUserName,
    String? photoUrl,
  );

  Future<Either<Failure, void>> unfollowUser(String targetUserId);

  Future<Either<Failure, List<UserConnectionModel>>> getConnections();

  Future<Either<Failure, bool>> isFollowing(String targetUserId);
}
