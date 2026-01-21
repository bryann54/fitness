// lib/features/community/presentation/bloc/groups/groups_event.dart
part of 'groups_bloc.dart';

abstract class GroupsEvent extends Equatable {
  const GroupsEvent();

  @override
  List<Object?> get props => [];
}

class LoadRecommendedGroupsEvent extends GroupsEvent {
  final FitnessProfileModel userProfile;

  const LoadRecommendedGroupsEvent(this.userProfile);

  @override
  List<Object?> get props => [userProfile];
}

class JoinGroupEvent extends GroupsEvent {
  final String groupId;

  const JoinGroupEvent(this.groupId);

  @override
  List<Object?> get props => [groupId];
}
