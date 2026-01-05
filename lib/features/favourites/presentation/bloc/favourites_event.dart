// lib/features/favourites/presentation/bloc/favourites_event.dart
part of 'favourites_bloc.dart';

abstract class FavouritesEvent extends Equatable {
  const FavouritesEvent();

  @override
  List<Object> get props => [];
}

class LoadFavouritesEvent extends FavouritesEvent {}

class AddFavouriteEvent extends FavouritesEvent {
  final MealModel meal;

  const AddFavouriteEvent({required this.meal});

  @override
  List<Object> get props => [meal];
}

class DeleteFavouriteEvent extends FavouritesEvent {
  final MealModel meal;

  const DeleteFavouriteEvent({required this.meal});

  @override
  List<Object> get props => [meal];
}

class CheckIfFavEvent extends FavouritesEvent {
  final MealModel meal;

  const CheckIfFavEvent({required this.meal});

  @override
  List<Object> get props => [meal];
}

class ToggleFavouriteEvent extends FavouritesEvent {
  final MealModel meal;

  const ToggleFavouriteEvent({required this.meal});

  @override
  List<Object> get props => [meal];
}
