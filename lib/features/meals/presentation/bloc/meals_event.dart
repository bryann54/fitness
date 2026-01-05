// lib/features/meals/presentation/bloc/meals_event.dart
part of 'meals_bloc.dart';

abstract class MealsEvent extends Equatable {
  const MealsEvent();
  @override
  List<Object?> get props => [];
}

class FetchMealsEvent extends MealsEvent {}

class FilterByCategoryEvent extends MealsEvent {
  final String category;
  const FilterByCategoryEvent(this.category);
  @override
  List<Object?> get props => [category];
}

class FilterByDietTagEvent extends MealsEvent {
  final String dietTag;
  const FilterByDietTagEvent(this.dietTag);
  @override
  List<Object?> get props => [dietTag];
}

class SearchMealsEvent extends MealsEvent {
  final String query;
  const SearchMealsEvent(this.query);
  @override
  List<Object?> get props => [query];
}
