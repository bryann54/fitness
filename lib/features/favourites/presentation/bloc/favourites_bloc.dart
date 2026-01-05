// lib/features/favourites/presentation/bloc/favourites_bloc.dart
import 'dart:async';
import 'package:fitness/common/helpers/base_usecase.dart';
import 'package:fitness/features/favourites/domain/usecases/add_to_favourites_usecase.dart';
import 'package:fitness/features/favourites/domain/usecases/check_if_fav_usecase.dart';
import 'package:fitness/features/favourites/domain/usecases/delete_favourite_usecase.dart';
import 'package:fitness/features/favourites/domain/usecases/load_favourites_usecase.dart';
import 'package:equatable/equatable.dart';
import 'package:fitness/features/meals/data/models/meal_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

part 'favourites_event.dart';
part 'favourites_state.dart';

@injectable
class FavouritesBloc extends Bloc<FavouritesEvent, FavouritesState> {
  final LoadFavouritesUsecase _loadFavouritesUsecase;
  final AddToFavouritesUsecase _addToFavouritesUsecase;
  final DeleteFavouriteUsecase _deleteFavouriteUsecase;
  final CheckIfFavUsecase _checkIfFavUsecase;

  FavouritesBloc(
    this._loadFavouritesUsecase,
    this._addToFavouritesUsecase,
    this._deleteFavouriteUsecase,
    this._checkIfFavUsecase,
  ) : super(FavouritesInitial()) {
    on<LoadFavouritesEvent>(_onLoadFavourites);
    on<AddFavouriteEvent>(_onAddFavourite);
    on<DeleteFavouriteEvent>(_onDeleteFavourite);
    on<CheckIfFavEvent>(_onCheckIfFav);
    on<ToggleFavouriteEvent>(_onToggleFavourite);
  }

  Future<void> _onLoadFavourites(
    LoadFavouritesEvent event,
    Emitter<FavouritesState> emit,
  ) async {
    emit(FavouritesLoading());

    final result = await _loadFavouritesUsecase(const NoParams());

    result.fold(
      (failure) => emit(FavouritesError(message: failure.toString())),
      (meals) => emit(FavouritesLoaded(favourites: meals)),
    );
  }

  Future<void> _onAddFavourite(
    AddFavouriteEvent event,
    Emitter<FavouritesState> emit,
  ) async {
    final result = await _addToFavouritesUsecase(event.meal);

    result.fold(
      (failure) => emit(FavouritesError(message: failure.toString())),
      (meals) {
        emit(FavouritesLoaded(favourites: meals));
        emit(FavouriteToggled(meal: event.meal, isFavourite: true));
      },
    );
  }

  Future<void> _onDeleteFavourite(
    DeleteFavouriteEvent event,
    Emitter<FavouritesState> emit,
  ) async {
    final result = await _deleteFavouriteUsecase(event.meal);

    result.fold(
      (failure) => emit(FavouritesError(message: failure.toString())),
      (meals) {
        emit(FavouritesLoaded(favourites: meals));
        emit(FavouriteToggled(meal: event.meal, isFavourite: false));
      },
    );
  }

  Future<void> _onCheckIfFav(
    CheckIfFavEvent event,
    Emitter<FavouritesState> emit,
  ) async {
    final result = await _checkIfFavUsecase(event.meal);

    result.fold(
      (failure) => emit(FavouritesError(message: failure.toString())),
      (isFav) => emit(FavouriteChecked(meal: event.meal, isFavourite: isFav)),
    );
  }

  Future<void> _onToggleFavourite(
    ToggleFavouriteEvent event,
    Emitter<FavouritesState> emit,
  ) async {
    // First check if it's already a favourite
    final checkResult = await _checkIfFavUsecase(event.meal);

    await checkResult.fold(
      (failure) async => emit(FavouritesError(message: failure.toString())),
      (isFav) async {
        if (isFav) {
          // Remove from favourites
          add(DeleteFavouriteEvent(meal: event.meal));
        } else {
          // Add to favourites
          add(AddFavouriteEvent(meal: event.meal));
        }
      },
    );
  }
}
