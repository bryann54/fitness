// lib/features/meals/presentation/bloc/meals_state.dart
part of 'meals_bloc.dart';

abstract class MealsState extends Equatable {
  const MealsState();
  @override
  List<Object?> get props => [];
}

class MealsInitial extends MealsState {}

class MealsLoading extends MealsState {}

class MealsLoaded extends MealsState {
  final List<MealModel> allMeals;
  final List<MealModel> filteredMeals;
  final List<String> categories;
  final String selectedCategory;
  final String? selectedDietTag;

  const MealsLoaded({
    required this.allMeals,
    required this.filteredMeals,
    required this.categories,
    this.selectedCategory = 'All',
    this.selectedDietTag,
  });

  MealsLoaded copyWith({
    List<MealModel>? filteredMeals,
    String? selectedCategory,
    String? selectedDietTag,
  }) {
    return MealsLoaded(
      allMeals: allMeals,
      filteredMeals: filteredMeals ?? this.filteredMeals,
      categories: categories,
      selectedCategory: selectedCategory ?? this.selectedCategory,
      selectedDietTag: selectedDietTag ?? this.selectedDietTag,
    );
  }

  @override
  List<Object?> get props => [
        allMeals,
        filteredMeals,
        categories,
        selectedCategory,
        selectedDietTag,
      ];
}

class MealsError extends MealsState {
  final String message;
  const MealsError(this.message);
  @override
  List<Object?> get props => [message];
}
