// lib/features/onboarding/data/repositories/onboarding_repository_impl.dart

import 'package:dartz/dartz.dart';
import 'package:fitness/core/errors/exceptions.dart';
import 'package:fitness/core/errors/failures.dart';
import 'package:fitness/features/onboarding/data/datasources/onboarding_remote_datasource.dart';
import 'package:fitness/features/onboarding/data/models/fitness_profile_model.dart';
import 'package:fitness/features/onboarding/domain/repositories/onboarding_repository.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: OnboardingRepository)
class OnboardingRepositoryImpl implements OnboardingRepository {
  final OnboardingRemoteDatasource _remoteDatasource;

  OnboardingRepositoryImpl(this._remoteDatasource);

  @override
  Future<Either<Failure, void>> saveProfile(FitnessProfileModel profile) async {
    try {
      await _remoteDatasource.saveProfile(profile);
      return const Right(null);
    } on ServerException catch (e) {
      return Left(
          ServerFailure(message: e.message ?? 'Failed to save profile.'));
    } catch (e) {
      return Left(GeneralFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, FitnessProfileModel?>> getProfile() async {
    try {
      final result = await _remoteDatasource.getProfile();
      return Right(result);
    } on ServerException catch (e) {
      return Left(
          ServerFailure(message: e.message ?? 'Failed to retrieve profile.'));
    } catch (e) {
      return Left(GeneralFailure(message: e.toString()));
    }
  }
}
