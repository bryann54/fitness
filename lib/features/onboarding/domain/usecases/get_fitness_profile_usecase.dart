// lib/features/onboarding/domain/usecases/get_fitness_profile_usecase.dart

import 'package:dartz/dartz.dart';
import 'package:fitness/common/helpers/base_usecase.dart';
import 'package:fitness/core/errors/failures.dart';
import 'package:fitness/features/onboarding/data/models/fitness_profile_model.dart';
import 'package:fitness/features/onboarding/domain/repositories/onboarding_repository.dart'; // <--- CORRECTED IMPORT
import 'package:injectable/injectable.dart';

@lazySingleton
class GetFitnessProfileUsecase
    implements UseCase<FitnessProfileModel?, NoParams> {
  final OnboardingRepository _repo;

  GetFitnessProfileUsecase(this._repo);

  @override
  Future<Either<Failure, FitnessProfileModel?>> call(NoParams params) async {
    return await _repo.getProfile();
  }
}
