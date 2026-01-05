// lib/features/meals/presentation/bloc/meals_bloc.dart
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fitness/common/helpers/base_usecase.dart';
import 'package:fitness/features/meals/data/models/meal_model.dart';
import 'package:fitness/features/meals/domain/usecases/get_all_meals_usecase.dart';
import 'package:injectable/injectable.dart';

part 'meals_event.dart';
part 'meals_state.dart';

@injectable
class MealsBloc extends Bloc<MealsEvent, MealsState> {
  final GetAllMealsUsecase _getAllMealsUsecase;
  // final GetMealsByCategoryUsecase _getMealsByCategoryUsecase;
  // final GetCategoriesUsecase _getCategoriesUsecase;

  MealsBloc(
    this._getAllMealsUsecase,
    // this._getMealsByCategoryUsecase,
    // this._getCategoriesUsecase,
  ) : super(MealsInitial()) {
    on<FetchMealsEvent>(_onFetchMeals);
    on<FilterByCategoryEvent>(_onFilterByCategory);
    on<FilterByDietTagEvent>(_onFilterByDietTag);
    on<SearchMealsEvent>(_onSearchMeals);
  }

  Future<void> _onFetchMeals(
      FetchMealsEvent event, Emitter<MealsState> emit) async {
    emit(MealsLoading());

    final result = await _getAllMealsUsecase(const NoParams());

    result.fold(
      (failure) => emit(MealsError(failure.toString())),
      (meals) {
        // Extract unique categories from meals
        final categories = <String>{'All'};
        for (var meal in meals) {
          categories.add(meal.category);
        }

        emit(MealsLoaded(
          allMeals: meals,
          filteredMeals: meals,
          categories: categories.toList(),
          selectedCategory: 'All',
        ));
      },
    );
  }

  void _onFilterByCategory(
      FilterByCategoryEvent event, Emitter<MealsState> emit) {
    if (state is MealsLoaded) {
      final currentState = state as MealsLoaded;

      final filtered = event.category == 'All'
          ? currentState.allMeals
          : currentState.allMeals
              .where((meal) => meal.category == event.category)
              .toList();

      emit(currentState.copyWith(
        filteredMeals: filtered,
        selectedCategory: event.category,
      ));
    }
  }

  void _onFilterByDietTag(
      FilterByDietTagEvent event, Emitter<MealsState> emit) {
    if (state is MealsLoaded) {
      final currentState = state as MealsLoaded;

      List<MealModel> filtered;

      switch (event.dietTag.toLowerCase()) {
        case 'vegan':
          filtered = currentState.allMeals.where((m) => m.isVegan).toList();
          break;
        case 'keto':
          filtered = currentState.allMeals.where((m) => m.isKeto).toList();
          break;
        case 'traditional':
          filtered =
              currentState.allMeals.where((m) => m.isTraditional).toList();
          break;
        default:
          filtered = currentState.allMeals;
      }

      emit(currentState.copyWith(
        filteredMeals: filtered,
        selectedDietTag: event.dietTag,
      ));
    }
  }

  void _onSearchMeals(SearchMealsEvent event, Emitter<MealsState> emit) {
    if (state is MealsLoaded) {
      final currentState = state as MealsLoaded;

      if (event.query.isEmpty) {
        emit(currentState.copyWith(filteredMeals: currentState.allMeals));
        return;
      }

      final query = event.query.toLowerCase();
      final filtered = currentState.allMeals.where((meal) {
        return meal.uiTitle.toLowerCase().contains(query) ||
            meal.category.toLowerCase().contains(query) ||
            meal.dietTag.toLowerCase().contains(query);
      }).toList();

      emit(currentState.copyWith(filteredMeals: filtered));
    }
  }
}
