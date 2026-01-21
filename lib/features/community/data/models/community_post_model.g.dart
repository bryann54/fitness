// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'community_post_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CommunityPostModel _$CommunityPostModelFromJson(Map<String, dynamic> json) =>
    CommunityPostModel(
      id: json['id'] as String,
      userId: json['userId'] as String,
      userName: json['userName'] as String,
      userPhotoUrl: json['userPhotoUrl'] as String?,
      postType: $enumDecode(_$PostTypeEnumMap, json['postType']),
      content: json['content'] as String,
      mediaUrls: (json['mediaUrls'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      likes: (json['likes'] as num?)?.toInt() ?? 0,
      comments: (json['comments'] as num?)?.toInt() ?? 0,
      likedBy: (json['likedBy'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      workoutId: json['workoutId'] as String?,
      workoutName: json['workoutName'] as String?,
      duration: (json['duration'] as num?)?.toInt(),
      weightChange: (json['weightChange'] as num?)?.toDouble(),
      progressPhotoUrl: json['progressPhotoUrl'] as String?,
      achievementType: json['achievementType'] as String?,
      achievementBadge: json['achievementBadge'] as String?,
      createdAt: CommunityPostModel._timestampFromJson(json['createdAt']),
      userGender: json['userGender'] as String?,
      userFitnessGoal: json['userFitnessGoal'] as String?,
      userExperience: json['userExperience'] as String?,
      userWorkoutPreferences: (json['userWorkoutPreferences'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
    );

Map<String, dynamic> _$CommunityPostModelToJson(CommunityPostModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'userId': instance.userId,
      'userName': instance.userName,
      'userPhotoUrl': instance.userPhotoUrl,
      'postType': _$PostTypeEnumMap[instance.postType]!,
      'content': instance.content,
      'mediaUrls': instance.mediaUrls,
      'likes': instance.likes,
      'comments': instance.comments,
      'likedBy': instance.likedBy,
      'workoutId': instance.workoutId,
      'workoutName': instance.workoutName,
      'duration': instance.duration,
      'weightChange': instance.weightChange,
      'progressPhotoUrl': instance.progressPhotoUrl,
      'achievementType': instance.achievementType,
      'achievementBadge': instance.achievementBadge,
      'createdAt': CommunityPostModel._timestampToJson(instance.createdAt),
      'userGender': instance.userGender,
      'userFitnessGoal': instance.userFitnessGoal,
      'userExperience': instance.userExperience,
      'userWorkoutPreferences': instance.userWorkoutPreferences,
    };

const _$PostTypeEnumMap = {
  PostType.workout: 'workout',
  PostType.progress: 'progress',
  PostType.achievement: 'achievement',
  PostType.motivation: 'motivation',
  PostType.question: 'question',
};
