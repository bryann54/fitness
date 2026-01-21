// lib/features/community/domain/usecases/find_workout_buddies_usecase.dart
import 'package:dartz/dartz.dart';
import 'package:fitness/common/helpers/base_usecase.dart';
import 'package:fitness/core/errors/failures.dart';
import 'package:fitness/features/community/domain/repositories/community_repository.dart';
import 'package:fitness/features/onboarding/data/models/fitness_profile_model.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class FindWorkoutBuddiesUsecase
    implements UseCase<List<FitnessProfileModel>, FitnessProfileModel> {
  final CommunityRepository _repo;

  FindWorkoutBuddiesUsecase(this._repo);

  @override
  Future<Either<Failure, List<FitnessProfileModel>>> call(
    FitnessProfileModel profile,
  ) async {
    return await _repo.findWorkoutBuddies(profile);
  }
}
