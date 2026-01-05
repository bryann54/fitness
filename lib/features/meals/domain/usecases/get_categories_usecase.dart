// lib/features/meals/domain/usecases/get_categories_usecase.dart
import 'package:dartz/dartz.dart';
import 'package:fitness/common/helpers/base_usecase.dart';
import 'package:fitness/core/errors/failures.dart';
import 'package:fitness/features/meals/domain/repositories/meals_repository.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class GetCategoriesUsecase implements UseCase<List<String>, NoParams> {
  final MealsRepository _repo;

  GetCategoriesUsecase(this._repo);

  @override
  Future<Either<Failure, List<String>>> call(NoParams params) async {
    return await _repo.getCategories();
  }
}
