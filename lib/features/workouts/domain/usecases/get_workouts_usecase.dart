// lib/features/workouts/domain/usecases/get_workouts_usecase.dart
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:fitness/common/helpers/base_usecase.dart';
import 'package:fitness/core/errors/failures.dart';
import 'package:fitness/features/workouts/data/models/workout_model.dart';
import 'package:fitness/features/workouts/domain/repositories/workouts_repository.dart';
import 'package:injectable/injectable.dart';

class GetWorkoutsParams extends Equatable {
  final String gender;
  final String? location;

  const GetWorkoutsParams({
    required this.gender,
    this.location,
  });

  @override
  List<Object?> get props => [gender, location];
}

@lazySingleton
class GetWorkoutsUsecase
    implements UseCase<List<WorkoutModel>, GetWorkoutsParams> {
  final WorkoutsRepository _repo;

  GetWorkoutsUsecase(this._repo);

  @override
  Future<Either<Failure, List<WorkoutModel>>> call(
      GetWorkoutsParams params) async {
    return await _repo.getWorkouts(
      gender: params.gender,
      location: params.location,
    );
  }
}
