// lib/features/community/data/models/community_post_model.dart
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'community_post_model.g.dart';

enum PostType { workout, progress, achievement, motivation, question }

@JsonSerializable(explicitToJson: true)
class CommunityPostModel extends Equatable {
  final String id;
  final String userId;
  final String userName;
  final String? userPhotoUrl;
  final PostType postType;
  final String content;
  final List<String> mediaUrls;
  final int likes;
  final int comments;
  final List<String> likedBy;

  // Workout-specific data
  final String? workoutId;
  final String? workoutName;
  final int? duration; // in minutes

  // Progress-specific data
  final double? weightChange;
  final String? progressPhotoUrl;

  // Achievement data
  final String? achievementType;
  final String? achievementBadge;

  @JsonKey(fromJson: _timestampFromJson, toJson: _timestampToJson)
  final DateTime createdAt;

  // User fitness profile data for matching
  final String? userGender;
  final String? userFitnessGoal;
  final String? userExperience;
  final List<String>? userWorkoutPreferences;

  const CommunityPostModel({
    required this.id,
    required this.userId,
    required this.userName,
    this.userPhotoUrl,
    required this.postType,
    required this.content,
    this.mediaUrls = const [],
    this.likes = 0,
    this.comments = 0,
    this.likedBy = const [],
    this.workoutId,
    this.workoutName,
    this.duration,
    this.weightChange,
    this.progressPhotoUrl,
    this.achievementType,
    this.achievementBadge,
    required this.createdAt,
    this.userGender,
    this.userFitnessGoal,
    this.userExperience,
    this.userWorkoutPreferences,
  });

  static DateTime _timestampFromJson(dynamic timestamp) {
    if (timestamp is Timestamp) {
      return timestamp.toDate();
    }
    return DateTime.parse(timestamp as String);
  }

  static dynamic _timestampToJson(DateTime date) => date.toIso8601String();

  factory CommunityPostModel.fromJson(Map<String, dynamic> json) =>
      _$CommunityPostModelFromJson(json);

  Map<String, dynamic> toJson() => _$CommunityPostModelToJson(this);

  @override
  List<Object?> get props => [id, userId, content, createdAt];
}
