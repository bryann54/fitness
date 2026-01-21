// lib/features/community/data/models/achievement_model.dart
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
part 'achievement_model.g.dart';

enum AchievementType {
  firstWorkout,
  weekStreak,
  monthStreak,
  weightMilestone,
  strengthGain,
  cardioMilestone,
  consistencyKing,
  earlyBird,
  nightOwl,
  socialButterfly,
}

@JsonSerializable(explicitToJson: true)
class AchievementModel extends Equatable {
  final String id;
  final String userId;
  final AchievementType type;
  final String title;
  final String description;
  final String badgeUrl;
  final int points;
  final bool isUnlocked;

  @JsonKey(fromJson: _timestampFromJson, toJson: _timestampToJson)
  final DateTime? unlockedAt;

  const AchievementModel({
    required this.id,
    required this.userId,
    required this.type,
    required this.title,
    required this.description,
    required this.badgeUrl,
    required this.points,
    this.isUnlocked = false,
    this.unlockedAt,
  });

  static DateTime? _timestampFromJson(dynamic timestamp) {
    if (timestamp == null) return null;
    if (timestamp is Timestamp) {
      return timestamp.toDate();
    }
    return DateTime.parse(timestamp as String);
  }

  static dynamic _timestampToJson(DateTime? date) => date?.toIso8601String();

  factory AchievementModel.fromJson(Map<String, dynamic> json) =>
      _$AchievementModelFromJson(json);

  Map<String, dynamic> toJson() => _$AchievementModelToJson(this);

  @override
  List<Object?> get props => [id, userId, type, isUnlocked];
}
