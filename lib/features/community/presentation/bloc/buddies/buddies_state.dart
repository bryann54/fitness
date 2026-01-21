// lib/features/community/presentation/bloc/buddies/buddies_state.dart
import 'package:equatable/equatable.dart';
import 'package:fitness/features/community/data/models/user_connection_model.dart';
import 'package:fitness/features/onboarding/data/models/fitness_profile_model.dart';

abstract class BuddiesState extends Equatable {
  const BuddiesState();

  @override
  List<Object?> get props => [];
}

class BuddiesInitial extends BuddiesState {}

class BuddiesLoading extends BuddiesState {}

class SuggestedBuddiesLoaded extends BuddiesState {
  final List<FitnessProfileModel> buddies;

  const SuggestedBuddiesLoaded({required this.buddies});

  SuggestedBuddiesLoaded copyWith({List<FitnessProfileModel>? buddies}) {
    return SuggestedBuddiesLoaded(
      buddies: buddies ?? this.buddies,
    );
  }

  @override
  List<Object?> get props => [buddies];
}

class MyBuddiesLoaded extends BuddiesState {
  final List<UserConnectionModel> connections;

  const MyBuddiesLoaded({required this.connections});

  @override
  List<Object?> get props => [connections];
}

class BuddiesError extends BuddiesState {
  final String message;

  const BuddiesError({required this.message});

  @override
  List<Object?> get props => [message];
}
