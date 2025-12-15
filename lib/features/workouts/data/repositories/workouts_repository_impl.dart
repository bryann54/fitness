// lib/features/workouts/data/repositories/workouts_repository_impl.dart

import 'package:dartz/dartz.dart';
import 'package:fitness/core/api_client/models/server_error.dart';
import 'package:fitness/core/errors/exceptions.dart';
import 'package:fitness/core/errors/failures.dart';
import 'package:fitness/features/workouts/data/datasources/workouts_remote_datasource.dart';
import 'package:fitness/features/workouts/data/models/exercise_category_model.dart';
import 'package:fitness/features/workouts/domain/repositories/workouts_repository.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: WorkoutsRepository)
class WorkoutsRepositoryImpl implements WorkoutsRepository {
  final WorkoutsRemoteDatasource _remoteDatasource;

  WorkoutsRepositoryImpl(this._remoteDatasource);

  @override
  Future<Either<Failure, ExerciseCategoryResponse>>
      getExerciseCategories() async {
    try {
      final result = await _remoteDatasource.getExerciseCategories();

      if (result is ServerError) {
        // --- CORRECTED MAPPING ---
        // ServerFailure only accepts 'message' and 'statusCode'.
        return Left(ServerFailure(
          message: result.getErrorMessage(),
          statusCode: result.statusCode,
        ));
        // -------------------------
      }
      return Right(ExerciseCategoryResponse.fromJson(result));
    } on ServerException catch (e) {
      // If a ServerException is thrown, you can pass its message.
      return Left(
          ServerFailure(message: e.message ?? 'Server error occurred.'));
    } on Exception catch (e) {
      // Catch any other unexpected exceptions and return a GeneralFailure.
      return Left(GeneralFailure(message: e.toString()));
    }
  }
}
