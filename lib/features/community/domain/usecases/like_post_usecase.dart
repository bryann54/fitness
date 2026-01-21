// lib/features/community/domain/usecases/like_post_usecase.dart

import 'package:dartz/dartz.dart';
import 'package:fitness/common/helpers/base_usecase.dart';
import 'package:fitness/core/errors/failures.dart';
import 'package:fitness/features/community/domain/repositories/community_repository.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class LikePostUsecase implements UseCase<void, String> {
  final CommunityRepository _repo;

  LikePostUsecase(this._repo);

  @override
  Future<Either<Failure, void>> call(String postId) async {
    return await _repo.likePost(postId);
  }
}
