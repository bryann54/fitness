// lib/features/meals/data/repositories/meals_repository_impl.dart
import 'package:dartz/dartz.dart';
import 'package:fitness/core/errors/exceptions.dart';
import 'package:fitness/core/errors/failures.dart';
import 'package:fitness/features/meals/data/datasources/meals_remote_datasource.dart';
import 'package:fitness/features/meals/data/models/meal_model.dart';
import 'package:fitness/features/meals/domain/repositories/meals_repository.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: MealsRepository)
class MealsRepositoryImpl implements MealsRepository {
  final MealsRemoteDatasource _remote;

  MealsRepositoryImpl(this._remote);

  @override
  Future<Either<Failure, List<MealModel>>> getAllMeals() async {
    try {
      final result = await _remote.getAllMeals();
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message ?? 'Failed to fetch meals'));
    } catch (e) {
      return Left(GeneralFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<MealModel>>> getMealsByCategory(
      String category) async {
    try {
      final result = await _remote.getMealsByCategory(category);
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(
          message: e.message ?? 'Failed to fetch meals by category'));
    } catch (e) {
      return Left(GeneralFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<MealModel>>> getMealsByDietTag(
      String dietTag) async {
    try {
      final result = await _remote.getMealsByDietTag(dietTag);
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(
          message: e.message ?? 'Failed to fetch meals by diet tag'));
    } catch (e) {
      return Left(GeneralFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<String>>> getCategories() async {
    try {
      final result = await _remote.getCategories();
      return Right(result);
    } on ServerException catch (e) {
      return Left(
          ServerFailure(message: e.message ?? 'Failed to fetch categories'));
    } catch (e) {
      return Left(GeneralFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, MealModel?>> getMealById(String mealId) async {
    try {
      final result = await _remote.getMealById(mealId);
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message ?? 'Failed to fetch meal'));
    } catch (e) {
      return Left(GeneralFailure(message: e.toString()));
    }
  }
}
