// lib/features/workouts/presentation/bloc/workouts_state.dart

part of 'workouts_bloc.dart';

abstract class WorkoutsState extends Equatable {
  const WorkoutsState();

  @override
  List<Object> get props => [];
}

class WorkoutsInitial extends WorkoutsState {}

// --- Category States ---
class CategoriesLoading extends WorkoutsState {}

class CategoriesSuccess extends WorkoutsState {
  final List<ExerciseCategoryModel> categories;

  const CategoriesSuccess({required this.categories});

  @override
  List<Object> get props => [categories];
}

class CategoriesError extends WorkoutsState {
  final String error;

  const CategoriesError({required this.error});

  @override
  List<Object> get props => [error];
}

// --- Exercise States (for later) ---
// class ExercisesLoading extends WorkoutsState {}
// class ExercisesSuccess extends WorkoutsState {
//   // ...
// }
// class ExercisesError extends WorkoutsState {
//   // ...
// }
