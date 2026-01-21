// lib/features/community/presentation/bloc/groups/groups_bloc.dart
import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fitness/features/community/data/models/community_group_model.dart';
import 'package:fitness/features/community/domain/usecases/get_recommended_groups_usecase.dart';
import 'package:fitness/features/onboarding/data/models/fitness_profile_model.dart';
import 'package:injectable/injectable.dart';

part 'groups_event.dart';
part 'groups_state.dart';

@injectable
class GroupsBloc extends Bloc<GroupsEvent, GroupsState> {
  final GetRecommendedGroupsUsecase _getRecommendedGroupsUsecase;

  GroupsBloc(this._getRecommendedGroupsUsecase) : super(GroupsInitial()) {
    on<LoadRecommendedGroupsEvent>(_onLoadRecommendedGroups);
    on<JoinGroupEvent>(_onJoinGroup);
  }

  FutureOr<void> _onLoadRecommendedGroups(
    LoadRecommendedGroupsEvent event,
    Emitter<GroupsState> emit,
  ) async {
    emit(GroupsLoading());

    final result = await _getRecommendedGroupsUsecase(event.userProfile);

    emit(
      result.fold(
        (failure) => GroupsError(message: failure.toString()),
        (groups) => GroupsLoaded(groups: groups),
      ),
    );
  }

  FutureOr<void> _onJoinGroup(
    JoinGroupEvent event,
    Emitter<GroupsState> emit,
  ) async {
    // Handle join group logic
  }
}
