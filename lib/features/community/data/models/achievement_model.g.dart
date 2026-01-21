// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'achievement_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AchievementModel _$AchievementModelFromJson(Map<String, dynamic> json) =>
    AchievementModel(
      id: json['id'] as String,
      userId: json['userId'] as String,
      type: $enumDecode(_$AchievementTypeEnumMap, json['type']),
      title: json['title'] as String,
      description: json['description'] as String,
      badgeUrl: json['badgeUrl'] as String,
      points: (json['points'] as num).toInt(),
      isUnlocked: json['isUnlocked'] as bool? ?? false,
      unlockedAt: AchievementModel._timestampFromJson(json['unlockedAt']),
    );

Map<String, dynamic> _$AchievementModelToJson(AchievementModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'userId': instance.userId,
      'type': _$AchievementTypeEnumMap[instance.type]!,
      'title': instance.title,
      'description': instance.description,
      'badgeUrl': instance.badgeUrl,
      'points': instance.points,
      'isUnlocked': instance.isUnlocked,
      'unlockedAt': AchievementModel._timestampToJson(instance.unlockedAt),
    };

const _$AchievementTypeEnumMap = {
  AchievementType.firstWorkout: 'firstWorkout',
  AchievementType.weekStreak: 'weekStreak',
  AchievementType.monthStreak: 'monthStreak',
  AchievementType.weightMilestone: 'weightMilestone',
  AchievementType.strengthGain: 'strengthGain',
  AchievementType.cardioMilestone: 'cardioMilestone',
  AchievementType.consistencyKing: 'consistencyKing',
  AchievementType.earlyBird: 'earlyBird',
  AchievementType.nightOwl: 'nightOwl',
  AchievementType.socialButterfly: 'socialButterfly',
};
