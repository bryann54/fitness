// lib/features/workouts/presentation/bloc/workouts_bloc.dart

import 'dart:async';
import 'package:fitness/common/helpers/base_usecase.dart';
import 'package:fitness/features/workouts/data/models/exercise_category_model.dart';
import 'package:fitness/features/workouts/domain/usecases/get_exercise_categories_usecase.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

part 'workouts_event.dart';
part 'workouts_state.dart';

@injectable
class WorkoutsBloc extends Bloc<WorkoutsEvent, WorkoutsState> {
  final GetExerciseCategoriesUsecase _getExerciseCategoriesUsecase;
  List<ExerciseCategoryModel> categories = [];

  WorkoutsBloc(this._getExerciseCategoriesUsecase) : super(WorkoutsInitial()) {
    on<GetCategoriesEvent>(_getCategories);
  }

  FutureOr<void> _getCategories(
      GetCategoriesEvent event, Emitter<WorkoutsState> emit) async {
    emit(CategoriesLoading());
    final response = await _getExerciseCategoriesUsecase.call(NoParams());

    emit(response.fold(
      (error) => CategoriesError(error: error.toString()),
      (data) {
        categories = data.results;
        return CategoriesSuccess(categories: categories);
      },
    ));
  }
}
