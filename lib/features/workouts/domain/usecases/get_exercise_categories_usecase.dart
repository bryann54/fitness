// lib/features/workouts/domain/usecases/get_exercise_categories_usecase.dart

import 'package:dartz/dartz.dart';
import 'package:fitness/common/helpers/base_usecase.dart';
import 'package:fitness/core/errors/failures.dart';
import 'package:fitness/features/workouts/data/models/exercise_category_model.dart';
import 'package:fitness/features/workouts/domain/repositories/workouts_repository.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class GetExerciseCategoriesUsecase
    implements UseCase<ExerciseCategoryResponse, NoParams> {
  final WorkoutsRepository _repo;

  GetExerciseCategoriesUsecase(this._repo);

  @override
  Future<Either<Failure, ExerciseCategoryResponse>> call(
      NoParams params) async {
    return await _repo.getExerciseCategories();
  }
}
