import 'package:fitness/core/errors/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:fitness/features/meals/data/models/meal_model.dart';

abstract class FavouritesRepository {
  Future<Either<Failure, List<MealModel>>> loadFavourites();
  Future<Either<Failure, List<MealModel>>> addFavourite(MealModel model);
  Future<Either<Failure, List<MealModel>>> deleteFavourite(MealModel model);
  Future<Either<Failure, bool>> checkIfFav(MealModel model);
}
