// lib/features/community/presentation/bloc/buddies/buddies_bloc.dart
import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fitness/common/helpers/base_usecase.dart';
import 'package:fitness/features/community/domain/usecases/find_workout_buddies_usecase.dart';
import 'package:fitness/features/community/domain/usecases/follow_user_usecase.dart';
import 'package:fitness/features/community/domain/usecases/get_connections_usecase.dart';
import 'package:fitness/features/community/presentation/bloc/buddies/buddies_state.dart';
import 'package:fitness/features/onboarding/data/models/fitness_profile_model.dart';
import 'package:injectable/injectable.dart';

part 'buddies_event.dart';

@injectable
class BuddiesBloc extends Bloc<BuddiesEvent, BuddiesState> {
  final FindWorkoutBuddiesUsecase _findWorkoutBuddiesUsecase;
  final FollowUserUsecase _followUserUsecase;
  final GetConnectionsUsecase _getConnectionsUsecase;

  BuddiesBloc(
    this._findWorkoutBuddiesUsecase,
    this._followUserUsecase,
    this._getConnectionsUsecase,
  ) : super(BuddiesInitial()) {
    on<LoadSuggestedBuddiesEvent>(_onLoadSuggestedBuddies);
    on<LoadMyBuddiesEvent>(_onLoadMyBuddies);
    on<ConnectWithBuddyEvent>(_onConnectWithBuddy);
    on<DisconnectBuddyEvent>(_onDisconnectBuddy);
  }

  FutureOr<void> _onLoadSuggestedBuddies(
    LoadSuggestedBuddiesEvent event,
    Emitter<BuddiesState> emit,
  ) async {
    emit(BuddiesLoading());

    final result = await _findWorkoutBuddiesUsecase(event.userProfile);

    emit(
      result.fold(
        (failure) => BuddiesError(message: failure.toString()),
        (buddies) => SuggestedBuddiesLoaded(buddies: buddies),
      ),
    );
  }

  FutureOr<void> _onLoadMyBuddies(
    LoadMyBuddiesEvent event,
    Emitter<BuddiesState> emit,
  ) async {
    emit(BuddiesLoading());

    final result = await _getConnectionsUsecase(const NoParams());

    emit(
      result.fold(
        (failure) => BuddiesError(message: failure.toString()),
        (connections) => MyBuddiesLoaded(connections: connections),
      ),
    );
  }

  FutureOr<void> _onConnectWithBuddy(
    ConnectWithBuddyEvent event,
    Emitter<BuddiesState> emit,
  ) async {
    if (state is SuggestedBuddiesLoaded) {
      final currentState = state as SuggestedBuddiesLoaded;

      final params = FollowUserParams(
        targetUserId: event.userId,
        targetUserName: event.userName,
        photoUrl: event.photoUrl,
      );

      final result = await _followUserUsecase(params);

      result.fold(
        (failure) {
          // Show error but keep state
        },
        (_) {
          // Remove from suggested list
          final updatedBuddies = currentState.buddies
              .where((buddy) => buddy.uid != event.userId)
              .toList();
          emit(currentState.copyWith(buddies: updatedBuddies));
        },
      );
    }
  }

  FutureOr<void> _onDisconnectBuddy(
    DisconnectBuddyEvent event,
    Emitter<BuddiesState> emit,
  ) async {
    // TODO: Implement unfollow
  }
}
