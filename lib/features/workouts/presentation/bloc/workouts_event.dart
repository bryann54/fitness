// lib/features/workouts/presentation/bloc/workouts_event.dart
part of 'workouts_bloc.dart';

abstract class WorkoutsEvent extends Equatable {
  const WorkoutsEvent();

  @override
  List<Object?> get props => [];
}

class FetchWorkoutsEvent extends WorkoutsEvent {
  final String gender;
  final String? location;

  const FetchWorkoutsEvent({
    required this.gender,
    this.location,
  });

  @override
  List<Object?> get props => [gender, location];
}

class FetchWorkoutByDayEvent extends WorkoutsEvent {
  final String gender;
  final String day;
  final String location;

  const FetchWorkoutByDayEvent({
    required this.gender,
    required this.day,
    required this.location,
  });

  @override
  List<Object?> get props => [gender, day, location];
}
