// lib/features/workouts/data/repositories/workouts_repository_impl.dart
import 'package:dartz/dartz.dart';
import 'package:fitness/core/errors/exceptions.dart';
import 'package:fitness/core/errors/failures.dart';
import 'package:fitness/features/workouts/data/models/workout_model.dart';
import 'package:fitness/features/workouts/domain/repositories/workouts_repository.dart';
import 'package:injectable/injectable.dart';

import '../datasources/workouts_remote_datasource copy.dart';

@LazySingleton(as: WorkoutsRepository)
class WorkoutsRepositoryImpl implements WorkoutsRepository {
  final WorkoutsRemoteDatasource _remoteDatasource;

  WorkoutsRepositoryImpl(this._remoteDatasource);

  @override
  Future<Either<Failure, List<WorkoutModel>>> getWorkouts({
    required String gender,
    String? location,
  }) async {
    try {
      final result = await _remoteDatasource.getWorkouts(
        gender: gender,
        location: location,
      );
      return Right(result);
    } on ServerException catch (e) {
      return Left(
          ServerFailure(message: e.message ?? 'Failed to fetch workouts.'));
    } catch (e) {
      return Left(GeneralFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, WorkoutModel?>> getWorkoutByDay({
    required String gender,
    required String day,
    required String location,
  }) async {
    try {
      final result = await _remoteDatasource.getWorkoutByDay(
        gender: gender,
        day: day,
        location: location,
      );
      return Right(result);
    } on ServerException catch (e) {
      return Left(
          ServerFailure(message: e.message ?? 'Failed to fetch workout.'));
    } catch (e) {
      return Left(GeneralFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<String>>> getAvailableDays({
    required String gender,
    String? location,
  }) async {
    try {
      final result = await _remoteDatasource.getAvailableDays(
        gender: gender,
        location: location,
      );
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(
          message: e.message ?? 'Failed to fetch available days.'));
    } catch (e) {
      return Left(GeneralFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<WorkoutModel>>> getWorkoutsByMuscleGroup({
    required String gender,
    required String muscleCategory,
    String? location,
  }) async {
    try {
      final result = await _remoteDatasource.getWorkoutsByMuscleGroup(
        gender: gender,
        muscleCategory: muscleCategory,
        location: location,
      );
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(
          message: e.message ?? 'Failed to fetch workouts by muscle group.'));
    } catch (e) {
      return Left(GeneralFailure(message: e.toString()));
    }
  }
}
