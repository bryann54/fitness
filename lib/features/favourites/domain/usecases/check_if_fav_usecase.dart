import 'package:fitness/common/helpers/base_usecase.dart';
import 'package:fitness/core/errors/failures.dart';
import 'package:fitness/features/favourites/domain/repositories/favourites_repository.dart';

import 'package:dartz/dartz.dart';
import 'package:fitness/features/meals/data/models/meal_model.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class CheckIfFavUsecase implements UseCase<bool, MealModel> {
  final FavouritesRepository _repo;

  CheckIfFavUsecase(this._repo);

  @override
  Future<Either<Failure, bool>> call(MealModel params) async {
    return await _repo.checkIfFav(params);
  }
}
