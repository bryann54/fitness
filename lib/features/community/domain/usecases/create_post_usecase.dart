// lib/features/community/domain/usecases/create_post_usecase.dart
import 'package:dartz/dartz.dart';
import 'package:fitness/common/helpers/base_usecase.dart';
import 'package:fitness/core/errors/failures.dart';
import 'package:fitness/features/community/data/models/community_post_model.dart';
import 'package:fitness/features/community/domain/repositories/community_repository.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class CreatePostUsecase implements UseCase<void, CommunityPostModel> {
  final CommunityRepository _repo;

  CreatePostUsecase(this._repo);

  @override
  Future<Either<Failure, void>> call(CommunityPostModel params) async {
    return await _repo.createPost(params);
  }
}
