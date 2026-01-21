// lib/features/community/presentation/bloc/buddies/buddies_event.dart
part of 'buddies_bloc.dart';

abstract class BuddiesEvent extends Equatable {
  const BuddiesEvent();

  @override
  List<Object?> get props => [];
}

class LoadSuggestedBuddiesEvent extends BuddiesEvent {
  final FitnessProfileModel userProfile;

  const LoadSuggestedBuddiesEvent(this.userProfile);

  @override
  List<Object?> get props => [userProfile];
}

class LoadMyBuddiesEvent extends BuddiesEvent {}

class ConnectWithBuddyEvent extends BuddiesEvent {
  final String userId;
  final String userName;
  final String? photoUrl;

  const ConnectWithBuddyEvent({
    required this.userId,
    required this.userName,
    this.photoUrl,
  });

  @override
  List<Object?> get props => [userId, userName, photoUrl];
}

class DisconnectBuddyEvent extends BuddiesEvent {
  final String userId;

  const DisconnectBuddyEvent(this.userId);

  @override
  List<Object?> get props => [userId];
}
