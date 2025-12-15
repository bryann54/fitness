// lib/features/workouts/domain/repositories/workouts_repository.dart

import 'package:dartz/dartz.dart';
import 'package:fitness/core/errors/failures.dart';
import 'package:fitness/features/workouts/data/models/exercise_category_model.dart';

abstract class WorkoutsRepository {
  Future<Either<Failure, ExerciseCategoryResponse>> getExerciseCategories();
}
