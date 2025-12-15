// lib/features/workouts/presentation/bloc/workouts_event.dart

part of 'workouts_bloc.dart';

abstract class WorkoutsEvent extends Equatable {
  const WorkoutsEvent();

  @override
  List<Object> get props => [];
}

class GetCategoriesEvent extends WorkoutsEvent {}
// class GetExercisesEvent extends WorkoutsEvent {
//   final int categoryId;
//   const GetExercisesEvent(this.categoryId);
//   @override
//   List<Object> get props => [categoryId];
// }
