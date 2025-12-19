// lib/features/workouts/domain/usecases/get_workout_by_day_usecase.dart
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:fitness/common/helpers/base_usecase.dart';
import 'package:fitness/core/errors/failures.dart';
import 'package:fitness/features/workouts/data/models/workout_model.dart';
import 'package:fitness/features/workouts/domain/repositories/workouts_repository.dart';
import 'package:injectable/injectable.dart';

class GetWorkoutByDayParams extends Equatable {
  final String gender;
  final String day;
  final String location;

  const GetWorkoutByDayParams({
    required this.gender,
    required this.day,
    required this.location,
  });

  @override
  List<Object?> get props => [gender, day, location];
}

@lazySingleton
class GetWorkoutByDayUsecase
    implements UseCase<WorkoutModel?, GetWorkoutByDayParams> {
  final WorkoutsRepository _repo;

  GetWorkoutByDayUsecase(this._repo);

  @override
  Future<Either<Failure, WorkoutModel?>> call(
      GetWorkoutByDayParams params) async {
    return await _repo.getWorkoutByDay(
      gender: params.gender,
      day: params.day,
      location: params.location,
    );
  }
}
