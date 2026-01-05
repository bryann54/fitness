// lib/features/meals/domain/usecases/get_all_meals_usecase.dart
import 'package:dartz/dartz.dart';
import 'package:fitness/common/helpers/base_usecase.dart';
import 'package:fitness/core/errors/failures.dart';
import 'package:fitness/features/meals/data/models/meal_model.dart';
import 'package:fitness/features/meals/domain/repositories/meals_repository.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class GetAllMealsUsecase implements UseCase<List<MealModel>, NoParams> {
  final MealsRepository _repo;

  GetAllMealsUsecase(this._repo);

  @override
  Future<Either<Failure, List<MealModel>>> call(NoParams params) async {
    return await _repo.getAllMeals();
  }
}
