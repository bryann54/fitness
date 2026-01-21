// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'community_group_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CommunityGroupModel _$CommunityGroupModelFromJson(Map<String, dynamic> json) =>
    CommunityGroupModel(
      id: json['id'] as String,
      name: json['name'] as String,
      description: json['description'] as String,
      imageUrl: json['imageUrl'] as String,
      groupType: $enumDecode(_$GroupTypeEnumMap, json['groupType']),
      memberCount: (json['memberCount'] as num?)?.toInt() ?? 0,
      members: (json['members'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      createdBy: json['createdBy'] as String,
      fitnessGoal: json['fitnessGoal'] as String?,
      workoutPreference: json['workoutPreference'] as String?,
      experienceLevel: json['experienceLevel'] as String?,
      gender: json['gender'] as String?,
      createdAt: CommunityGroupModel._timestampFromJson(json['createdAt']),
    );

Map<String, dynamic> _$CommunityGroupModelToJson(
        CommunityGroupModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'imageUrl': instance.imageUrl,
      'groupType': _$GroupTypeEnumMap[instance.groupType]!,
      'memberCount': instance.memberCount,
      'members': instance.members,
      'createdBy': instance.createdBy,
      'fitnessGoal': instance.fitnessGoal,
      'workoutPreference': instance.workoutPreference,
      'experienceLevel': instance.experienceLevel,
      'gender': instance.gender,
      'createdAt': CommunityGroupModel._timestampToJson(instance.createdAt),
    };

const _$GroupTypeEnumMap = {
  GroupType.goal: 'goal',
  GroupType.workout: 'workout',
  GroupType.experience: 'experience',
  GroupType.general: 'general',
};
