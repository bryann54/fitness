// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'leaderboard_entry_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LeaderboardEntryModel _$LeaderboardEntryModelFromJson(
        Map<String, dynamic> json) =>
    LeaderboardEntryModel(
      userId: json['userId'] as String,
      userName: json['userName'] as String,
      userPhotoUrl: json['userPhotoUrl'] as String?,
      rank: (json['rank'] as num).toInt(),
      points: (json['points'] as num).toInt(),
      workoutsCompleted: (json['workoutsCompleted'] as num).toInt(),
      streak: (json['streak'] as num).toInt(),
      category: json['category'] as String,
    );

Map<String, dynamic> _$LeaderboardEntryModelToJson(
        LeaderboardEntryModel instance) =>
    <String, dynamic>{
      'userId': instance.userId,
      'userName': instance.userName,
      'userPhotoUrl': instance.userPhotoUrl,
      'rank': instance.rank,
      'points': instance.points,
      'workoutsCompleted': instance.workoutsCompleted,
      'streak': instance.streak,
      'category': instance.category,
    };
