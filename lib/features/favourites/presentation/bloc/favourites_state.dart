// lib/features/favourites/presentation/bloc/favourites_state.dart
part of 'favourites_bloc.dart';

abstract class FavouritesState extends Equatable {
  const FavouritesState();

  @override
  List<Object?> get props => [];
}

class FavouritesInitial extends FavouritesState {}

class FavouritesLoading extends FavouritesState {}

class FavouritesLoaded extends FavouritesState {
  final List<MealModel> favourites;

  const FavouritesLoaded({required this.favourites});

  @override
  List<Object> get props => [favourites];
}

class FavouritesError extends FavouritesState {
  final String message;

  const FavouritesError({required this.message});

  @override
  List<Object> get props => [message];
}

class FavouriteChecked extends FavouritesState {
  final MealModel meal;
  final bool isFavourite;

  const FavouriteChecked({
    required this.meal,
    required this.isFavourite,
  });

  @override
  List<Object> get props => [meal, isFavourite];
}

class FavouriteToggled extends FavouritesState {
  final MealModel meal;
  final bool isFavourite;

  const FavouriteToggled({
    required this.meal,
    required this.isFavourite,
  });

  @override
  List<Object> get props => [meal, isFavourite];
}
