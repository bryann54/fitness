// lib/features/meals/domain/usecases/get_meals_by_category_usecase.dart
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:fitness/common/helpers/base_usecase.dart';
import 'package:fitness/core/errors/failures.dart';
import 'package:fitness/features/meals/data/models/meal_model.dart';
import 'package:fitness/features/meals/domain/repositories/meals_repository.dart';
import 'package:injectable/injectable.dart';

class GetMealsByCategoryParams extends Equatable {
  final String category;

  const GetMealsByCategoryParams(this.category);

  @override
  List<Object?> get props => [category];
}

@lazySingleton
class GetMealsByCategoryUsecase
    implements UseCase<List<MealModel>, GetMealsByCategoryParams> {
  final MealsRepository _repo;

  GetMealsByCategoryUsecase(this._repo);

  @override
  Future<Either<Failure, List<MealModel>>> call(
      GetMealsByCategoryParams params) async {
    return await _repo.getMealsByCategory(params.category);
  }
}
