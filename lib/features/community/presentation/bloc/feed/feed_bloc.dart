// lib/features/community/presentation/bloc/feed/feed_bloc.dart
import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fitness/features/community/data/models/community_post_model.dart';
import 'package:fitness/features/community/domain/usecases/get_feed_posts_usecase.dart';
import 'package:fitness/features/community/domain/usecases/like_post_usecase.dart';
import 'package:fitness/features/community/domain/usecases/create_post_usecase.dart';
import 'package:fitness/features/onboarding/data/models/fitness_profile_model.dart';
import 'package:injectable/injectable.dart';

import 'feed_state.dart';

part 'feed_event.dart';

@injectable
class FeedBloc extends Bloc<FeedEvent, FeedState> {
  final GetFeedPostsUsecase _getFeedPostsUsecase;
  final LikePostUsecase _likePostUsecase;
  final CreatePostUsecase _createPostUsecase;

  FeedBloc(
    this._getFeedPostsUsecase,
    this._likePostUsecase,
    this._createPostUsecase,
  ) : super(FeedInitial()) {
    on<LoadFeedEvent>(_onLoadFeed);
    on<RefreshFeedEvent>(_onRefreshFeed);
    on<LikePostEvent>(_onLikePost);
    on<CreatePostEvent>(_onCreatePost);
    on<FilterFeedByGoalEvent>(_onFilterByGoal);
  }

  FutureOr<void> _onLoadFeed(
    LoadFeedEvent event,
    Emitter<FeedState> emit,
  ) async {
    emit(FeedLoading());

    final params = GetFeedPostsParams(
      userProfile: event.userProfile,
      limit: 20,
    );

    final result = await _getFeedPostsUsecase(params);

    emit(
      result.fold(
        (failure) => FeedError(message: failure.toString()),
        (posts) => FeedLoaded(
          posts: posts,
          allPosts: posts,
          userProfile: event.userProfile,
        ),
      ),
    );
  }

  FutureOr<void> _onRefreshFeed(
    RefreshFeedEvent event,
    Emitter<FeedState> emit,
  ) async {
    if (state is FeedLoaded) {
      final currentState = state as FeedLoaded;

      final params = GetFeedPostsParams(
        userProfile: currentState.userProfile,
        limit: 20,
      );

      final result = await _getFeedPostsUsecase(params);

      emit(
        result.fold(
          (failure) => currentState,
          (posts) => currentState.copyWith(
            posts: posts,
            allPosts: posts,
          ),
        ),
      );
    }
  }

  FutureOr<void> _onLikePost(
    LikePostEvent event,
    Emitter<FeedState> emit,
  ) async {
    if (state is FeedLoaded) {
      final currentState = state as FeedLoaded;

      // Optimistically update UI
      final updatedPosts = currentState.posts.map((post) {
        if (post.id == event.postId) {
          final isLiked = post.likedBy.contains(event.userId);
          final newLikedBy = List<String>.from(post.likedBy);

          if (isLiked) {
            newLikedBy.remove(event.userId);
          } else {
            newLikedBy.add(event.userId);
          }

          return CommunityPostModel(
            id: post.id,
            userId: post.userId,
            userName: post.userName,
            userPhotoUrl: post.userPhotoUrl,
            postType: post.postType,
            content: post.content,
            mediaUrls: post.mediaUrls,
            likes: isLiked ? post.likes - 1 : post.likes + 1,
            comments: post.comments,
            likedBy: newLikedBy,
            createdAt: post.createdAt,
            workoutId: post.workoutId,
            workoutName: post.workoutName,
            duration: post.duration,
            userGender: post.userGender,
            userFitnessGoal: post.userFitnessGoal,
            userExperience: post.userExperience,
          );
        }
        return post;
      }).toList();

      emit(currentState.copyWith(posts: updatedPosts));

      // Make API call
      await _likePostUsecase(event.postId);
    }
  }

  FutureOr<void> _onCreatePost(
    CreatePostEvent event,
    Emitter<FeedState> emit,
  ) async {
    final result = await _createPostUsecase(event.post);

    result.fold(
      (failure) => emit(FeedError(message: failure.toString())),
      (_) {
        // Refresh feed after creating post
        add(RefreshFeedEvent());
      },
    );
  }

  FutureOr<void> _onFilterByGoal(
    FilterFeedByGoalEvent event,
    Emitter<FeedState> emit,
  ) async {
    if (state is FeedLoaded) {
      final currentState = state as FeedLoaded;

      if (event.goal == null || event.goal == 'All') {
        emit(currentState.copyWith(
          posts: currentState.allPosts,
          selectedGoal: null,
        ));
      } else {
        final filtered = currentState.allPosts
            .where((post) => post.userFitnessGoal == event.goal)
            .toList();

        emit(currentState.copyWith(
          posts: filtered,
          selectedGoal: event.goal,
        ));
      }
    }
  }
}
