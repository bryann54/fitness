// lib/features/workouts/presentation/bloc/workouts_bloc.dart
import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fitness/features/workouts/data/models/workout_model.dart';
import 'package:fitness/features/workouts/domain/usecases/get_workouts_usecase.dart';
import 'package:fitness/features/workouts/domain/usecases/get_workout_by_day_usecase.dart';
import 'package:injectable/injectable.dart';

part 'workouts_event.dart';
part 'workouts_state.dart';

@injectable
class WorkoutsBloc extends Bloc<WorkoutsEvent, WorkoutsState> {
  final GetWorkoutsUsecase _getWorkoutsUsecase;
  final GetWorkoutByDayUsecase _getWorkoutByDayUsecase;

  WorkoutsBloc(
    this._getWorkoutsUsecase,
    this._getWorkoutByDayUsecase,
  ) : super(WorkoutsInitial()) {
    on<FetchWorkoutsEvent>(_onFetchWorkouts);
    on<FetchWorkoutByDayEvent>(_onFetchWorkoutByDay);
  }

  FutureOr<void> _onFetchWorkouts(
    FetchWorkoutsEvent event,
    Emitter<WorkoutsState> emit,
  ) async {
    emit(WorkoutsLoading());

    final params = GetWorkoutsParams(
      gender: event.gender,
      location: event.location,
    );

    final result = await _getWorkoutsUsecase(params);

    emit(
      result.fold(
        (failure) => WorkoutsError(message: failure.toString()),
        (workouts) => WorkoutsLoaded(workouts: workouts),
      ),
    );
  }

  FutureOr<void> _onFetchWorkoutByDay(
    FetchWorkoutByDayEvent event,
    Emitter<WorkoutsState> emit,
  ) async {
    emit(WorkoutsLoading());

    final params = GetWorkoutByDayParams(
      gender: event.gender,
      day: event.day,
      location: event.location,
    );

    final result = await _getWorkoutByDayUsecase(params);

    emit(
      result.fold(
        (failure) => WorkoutsError(message: failure.toString()),
        (workout) {
          if (workout != null) {
            return WorkoutDetailLoaded(workout: workout);
          } else {
            return const WorkoutsError(message: 'Workout not found');
          }
        },
      ),
    );
  }
}
