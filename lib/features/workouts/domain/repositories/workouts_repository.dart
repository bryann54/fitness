// lib/features/workouts/domain/repositories/workouts_repository.dart
import 'package:dartz/dartz.dart';
import 'package:fitness/core/errors/failures.dart';
import 'package:fitness/features/workouts/data/models/workout_model.dart';

abstract class WorkoutsRepository {
  Future<Either<Failure, List<WorkoutModel>>> getWorkouts({
    required String gender,
    String? location,
  });

  Future<Either<Failure, WorkoutModel?>> getWorkoutByDay({
    required String gender,
    required String day,
    required String location,
  });

  Future<Either<Failure, List<String>>> getAvailableDays({
    required String gender,
    String? location,
  });

  Future<Either<Failure, List<WorkoutModel>>> getWorkoutsByMuscleGroup({
    required String gender,
    required String muscleCategory,
    String? location,
  });
}
