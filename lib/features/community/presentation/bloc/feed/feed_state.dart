// lib/features/community/presentation/bloc/feed/feed_state.dart
import 'package:equatable/equatable.dart';

import 'package:fitness/features/community/data/models/community_post_model.dart';
import 'package:fitness/features/onboarding/data/models/fitness_profile_model.dart';

abstract class FeedState extends Equatable {
  const FeedState();

  @override
  List<Object?> get props => [];
}

class FeedInitial extends FeedState {}

class FeedLoading extends FeedState {}

class FeedLoaded extends FeedState {
  final List<CommunityPostModel> posts;
  final List<CommunityPostModel> allPosts;
  final FitnessProfileModel? userProfile;
  final String? selectedGoal;

  const FeedLoaded({
    required this.posts,
    required this.allPosts,
    this.userProfile,
    this.selectedGoal,
  });

  FeedLoaded copyWith({
    List<CommunityPostModel>? posts,
    List<CommunityPostModel>? allPosts,
    String? selectedGoal,
  }) {
    return FeedLoaded(
      posts: posts ?? this.posts,
      allPosts: allPosts ?? this.allPosts,
      userProfile: userProfile,
      selectedGoal: selectedGoal ?? this.selectedGoal,
    );
  }

  @override
  List<Object?> get props => [posts, allPosts, selectedGoal];
}

class FeedError extends FeedState {
  final String message;

  const FeedError({required this.message});

  @override
  List<Object?> get props => [message];
}
