// lib/features/meals/domain/repositories/meals_repository.dart
import 'package:dartz/dartz.dart';
import 'package:fitness/core/errors/failures.dart';
import 'package:fitness/features/meals/data/models/meal_model.dart';

abstract class MealsRepository {
  Future<Either<Failure, List<MealModel>>> getAllMeals();
  Future<Either<Failure, List<MealModel>>> getMealsByCategory(String category);
  Future<Either<Failure, List<MealModel>>> getMealsByDietTag(String dietTag);
  Future<Either<Failure, List<String>>> getCategories();
  Future<Either<Failure, MealModel?>> getMealById(String mealId);
}
