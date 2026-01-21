// lib/features/community/presentation/bloc/groups/groups_state.dart
part of 'groups_bloc.dart';

abstract class GroupsState extends Equatable {
  const GroupsState();

  @override
  List<Object?> get props => [];
}

class GroupsInitial extends GroupsState {}

class GroupsLoading extends GroupsState {}

class GroupsLoaded extends GroupsState {
  final List<CommunityGroupModel> groups;

  const GroupsLoaded({required this.groups});

  @override
  List<Object?> get props => [groups];
}

class GroupsError extends GroupsState {
  final String message;

  const GroupsError({required this.message});

  @override
  List<Object?> get props => [message];
}
