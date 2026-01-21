// lib/features/community/presentation/bloc/feed/feed_event.dart
part of 'feed_bloc.dart';

abstract class FeedEvent extends Equatable {
  const FeedEvent();

  @override
  List<Object?> get props => [];
}

class LoadFeedEvent extends FeedEvent {
  final FitnessProfileModel? userProfile;

  const LoadFeedEvent({this.userProfile});

  @override
  List<Object?> get props => [userProfile];
}

class RefreshFeedEvent extends FeedEvent {}

class LikePostEvent extends FeedEvent {
  final String postId;
  final String userId;

  const LikePostEvent({
    required this.postId,
    required this.userId,
  });

  @override
  List<Object?> get props => [postId, userId];
}

class CreatePostEvent extends FeedEvent {
  final CommunityPostModel post;

  const CreatePostEvent(this.post);

  @override
  List<Object?> get props => [post];
}

class FilterFeedByGoalEvent extends FeedEvent {
  final String? goal;

  const FilterFeedByGoalEvent(this.goal);

  @override
  List<Object?> get props => [goal];
}
