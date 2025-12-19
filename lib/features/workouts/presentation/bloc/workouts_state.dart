// lib/features/workouts/presentation/bloc/workouts_state.dart
part of 'workouts_bloc.dart';

abstract class WorkoutsState extends Equatable {
  const WorkoutsState();

  @override
  List<Object?> get props => [];
}

class WorkoutsInitial extends WorkoutsState {}

class WorkoutsLoading extends WorkoutsState {}

class WorkoutsLoaded extends WorkoutsState {
  final List<WorkoutModel> workouts;

  const WorkoutsLoaded({required this.workouts});

  @override
  List<Object?> get props => [workouts];
}

class WorkoutDetailLoaded extends WorkoutsState {
  final WorkoutModel workout;

  const WorkoutDetailLoaded({required this.workout});

  @override
  List<Object?> get props => [workout];
}

class WorkoutsError extends WorkoutsState {
  final String message;

  const WorkoutsError({required this.message});

  @override
  List<Object?> get props => [message];
}
