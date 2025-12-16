// lib/features/auth/domain/usecases/get_user_fitness_profile_usecase.dart

import 'package:dartz/dartz.dart';
import 'package:fitness/common/helpers/base_usecase.dart';
import 'package:fitness/core/errors/failures.dart';
import 'package:fitness/features/onboarding/data/models/fitness_profile_model.dart';
import 'package:fitness/features/onboarding/domain/repositories/onboarding_repository.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class GetUserFitnessProfileUseCase
    implements UseCase<FitnessProfileModel?, NoParams> {
  final OnboardingRepository _onboardingRepo;

  GetUserFitnessProfileUseCase(this._onboardingRepo);

  @override
  Future<Either<Failure, FitnessProfileModel?>> call(NoParams params) async {
    return await _onboardingRepo.getProfile();
  }
}
