// lib/features/community/domain/usecases/follow_user_usecase.dart
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:fitness/common/helpers/base_usecase.dart';
import 'package:fitness/core/errors/failures.dart';
import 'package:fitness/features/community/domain/repositories/community_repository.dart';
import 'package:injectable/injectable.dart';

class FollowUserParams extends Equatable {
  final String targetUserId;
  final String targetUserName;
  final String? photoUrl;

  const FollowUserParams({
    required this.targetUserId,
    required this.targetUserName,
    this.photoUrl,
  });

  @override
  List<Object?> get props => [targetUserId, targetUserName, photoUrl];
}

@lazySingleton
class FollowUserUsecase implements UseCase<void, FollowUserParams> {
  final CommunityRepository _repo;

  FollowUserUsecase(this._repo);

  @override
  Future<Either<Failure, void>> call(FollowUserParams params) async {
    return await _repo.followUser(
      params.targetUserId,
      params.targetUserName,
      params.photoUrl,
    );
  }
}
