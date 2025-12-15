// lib/features/onboarding/domain/repositories/onboarding_repository.dart

import 'package:dartz/dartz.dart';
import 'package:fitness/core/errors/failures.dart';
import 'package:fitness/features/onboarding/data/models/fitness_profile_model.dart';

abstract class OnboardingRepository {
  Future<Either<Failure, void>> saveProfile(FitnessProfileModel profile);
  Future<Either<Failure, FitnessProfileModel?>> getProfile();
}
