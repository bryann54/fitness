// lib/features/community/data/repositories/community_repository_impl.dart
import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:fitness/core/errors/exceptions.dart';
import 'package:fitness/core/errors/failures.dart';
import 'package:fitness/features/community/data/datasources/community_remote_datasource.dart';
import 'package:fitness/features/community/data/models/community_group_model.dart';
import 'package:fitness/features/community/data/models/community_post_model.dart';
import 'package:fitness/features/community/data/models/user_connection_model.dart';
import 'package:fitness/features/community/domain/repositories/community_repository.dart';
import 'package:fitness/features/onboarding/data/models/fitness_profile_model.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: CommunityRepository)
class CommunityRepositoryImpl implements CommunityRepository {
  final CommunityRemoteDatasource _remote;

  CommunityRepositoryImpl(this._remote);

  @override
  Future<Either<Failure, void>> createPost(CommunityPostModel post) async {
    try {
      await _remote.createPost(post);
      return const Right(null);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message ?? 'Failed to create post'));
    } catch (e) {
      return Left(GeneralFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<CommunityPostModel>>> getFeedPosts({
    FitnessProfileModel? userProfile,
    int limit = 20,
  }) async {
    try {
      final result = await _remote.getFeedPosts(
        userProfile: userProfile,
        limit: limit,
      );
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message ?? 'Failed to fetch posts'));
    } catch (e) {
      return Left(GeneralFailure(message: e.toString()));
    }
  }

  // @override
  // Future<Either<Failure, void>> followUser(
  //     String userId, String userName, String? photoUrl) async {
  //   try {
  //     await _remote.followUser(userId, userName, photoUrl);
  //     return const Right(null);
  //   } on ServerException catch (e) {
  //     return Left(ServerFailure(message: e.message ?? 'Failed to follow user'));
  //   } catch (e) {
  //     return Left(GeneralFailure(message: e.toString()));
  //   }
  // }

  @override
  Future<Either<Failure, void>> joinGroup(String groupId) async {
    try {
      await _remote.joinGroup(groupId);
      return const Right(null);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message ?? 'Failed to join group'));
    } catch (e) {
      return Left(GeneralFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> likePost(String postId) async {
    try {
      await _remote.likePost(postId);
      return const Right(null);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message ?? 'Failed to like post'));
    } catch (e) {
      return Left(GeneralFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<CommunityGroupModel>>> getRecommendedGroups(
    FitnessProfileModel profile,
  ) async {
    try {
      final result = await _remote.getRecommendedGroups(profile);
      return Right(result);
    } on ServerException catch (e) {
      return Left(
          ServerFailure(message: e.message ?? 'Failed to fetch groups'));
    } catch (e) {
      return Left(GeneralFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<FitnessProfileModel>>> findWorkoutBuddies(
    FitnessProfileModel profile,
  ) async {
    try {
      final result = await _remote.findWorkoutBuddies(profile);
      return Right(result);
    } on ServerException catch (e) {
      return Left(
          ServerFailure(message: e.message ?? 'Failed to find buddies'));
    } catch (e) {
      return Left(GeneralFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> followUser(
    String targetUserId,
    String targetUserName,
    String? photoUrl,
  ) async {
    try {
      await _remote.followUser(targetUserId, targetUserName, photoUrl);
      return const Right(null);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message ?? 'Failed to follow user'));
    } catch (e) {
      return Left(GeneralFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> unfollowUser(String targetUserId) async {
    try {
      await _remote.unfollowUser(targetUserId);
      return const Right(null);
    } on ServerException catch (e) {
      return Left(
          ServerFailure(message: e.message ?? 'Failed to unfollow user'));
    } catch (e) {
      return Left(GeneralFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<UserConnectionModel>>> getConnections() async {
    try {
      final result = await _remote.getConnections(ConnectionType.following);
      return Right(result);
    } on ServerException catch (e) {
      return Left(
          ServerFailure(message: e.message ?? 'Failed to get connections'));
    } catch (e) {
      return Left(GeneralFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, bool>> isFollowing(String targetUserId) async {
    try {
      final result = await _remote.isFollowing(targetUserId);
      return Right(result);
    } on ServerException catch (e) {
      return Left(
          ServerFailure(message: e.message ?? 'Failed to check follow status'));
    } catch (e) {
      return Left(GeneralFailure(message: e.toString()));
    }
  }
}
