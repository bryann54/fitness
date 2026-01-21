// lib/features/community/domain/usecases/get_feed_posts_usecase.dart
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:fitness/common/helpers/base_usecase.dart';
import 'package:fitness/core/errors/failures.dart';
import 'package:fitness/features/community/data/models/community_post_model.dart';
import 'package:fitness/features/community/domain/repositories/community_repository.dart';
import 'package:fitness/features/onboarding/data/models/fitness_profile_model.dart';
import 'package:injectable/injectable.dart';

class GetFeedPostsParams extends Equatable {
  final FitnessProfileModel? userProfile;
  final int limit;

  const GetFeedPostsParams({
    this.userProfile,
    this.limit = 20,
  });

  @override
  List<Object?> get props => [userProfile, limit];
}

@lazySingleton
class GetFeedPostsUsecase
    implements UseCase<List<CommunityPostModel>, GetFeedPostsParams> {
  final CommunityRepository _repo;

  GetFeedPostsUsecase(this._repo);

  @override
  Future<Either<Failure, List<CommunityPostModel>>> call(
    GetFeedPostsParams params,
  ) async {
    return await _repo.getFeedPosts(
      userProfile: params.userProfile,
      limit: params.limit,
    );
  }
}
