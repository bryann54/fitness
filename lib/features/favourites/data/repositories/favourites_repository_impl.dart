// lib/features/favourites/data/repositories/favourites_repository_impl.dart
import 'package:fitness/core/errors/failures.dart';
import 'package:fitness/features/favourites/data/datasources/favourites_local_datasource.dart';
import 'package:fitness/features/favourites/domain/repositories/favourites_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:fitness/features/meals/data/models/meal_model.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: FavouritesRepository)
class FavouritesRepositoryImpl implements FavouritesRepository {
  final FavouritesLocalDatasource _localDatasource;

  FavouritesRepositoryImpl(this._localDatasource);

  @override
  Future<Either<Failure, List<MealModel>>> loadFavourites() async {
    try {
      final response = await _localDatasource.listFavourites();
      return Right(response);
    } catch (e) {
      return Left(GeneralFailure(message: 'Failed to load favourites: $e'));
    }
  }

  @override
  Future<Either<Failure, List<MealModel>>> addFavourite(MealModel meal) async {
    try {
      final favs = await _localDatasource.addFavourite(meal);
      if (favs != null) {
        return Right(favs);
      }
      return Left(GeneralFailure(message: 'Meal is already in favourites'));
    } catch (e) {
      return Left(GeneralFailure(message: 'Failed to add favourite: $e'));
    }
  }

  @override
  Future<Either<Failure, List<MealModel>>> deleteFavourite(
      MealModel meal) async {
    try {
      final favs = await _localDatasource.deleteFavourite(meal);
      return Right(favs);
    } catch (e) {
      return Left(GeneralFailure(message: 'Failed to delete favourite: $e'));
    }
  }

  @override
  Future<Either<Failure, bool>> checkIfFav(MealModel meal) async {
    try {
      final isFav = await _localDatasource.checkIfFav(meal);
      return Right(isFav);
    } catch (e) {
      return Left(GeneralFailure(message: 'Failed to check favourite: $e'));
    }
  }
}
