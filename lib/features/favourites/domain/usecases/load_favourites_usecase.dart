import 'package:fitness/common/helpers/base_usecase.dart';
import 'package:fitness/core/errors/failures.dart';
import 'package:fitness/features/favourites/domain/repositories/favourites_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:fitness/features/meals/data/models/meal_model.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class LoadFavouritesUsecase implements UseCase<List<MealModel>, NoParams> {
  final FavouritesRepository _repo;

  LoadFavouritesUsecase(this._repo);

  @override
  Future<Either<Failure, List<MealModel>>> call(NoParams params) async {
    return await _repo.loadFavourites();
  }
}
