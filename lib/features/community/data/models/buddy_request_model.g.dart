// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'buddy_request_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BuddyRequestModel _$BuddyRequestModelFromJson(Map<String, dynamic> json) =>
    BuddyRequestModel(
      id: json['id'] as String,
      fromUserId: json['fromUserId'] as String,
      fromUserName: json['fromUserName'] as String,
      fromUserPhotoUrl: json['fromUserPhotoUrl'] as String?,
      toUserId: json['toUserId'] as String,
      message: json['message'] as String,
      compatibilityScore: (json['compatibilityScore'] as num).toInt(),
      sharedGoals: (json['sharedGoals'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      status:
          $enumDecodeNullable(_$BuddyRequestStatusEnumMap, json['status']) ??
              BuddyRequestStatus.pending,
      createdAt: BuddyRequestModel._timestampFromJson(json['createdAt']),
    );

Map<String, dynamic> _$BuddyRequestModelToJson(BuddyRequestModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'fromUserId': instance.fromUserId,
      'fromUserName': instance.fromUserName,
      'fromUserPhotoUrl': instance.fromUserPhotoUrl,
      'toUserId': instance.toUserId,
      'message': instance.message,
      'compatibilityScore': instance.compatibilityScore,
      'sharedGoals': instance.sharedGoals,
      'status': _$BuddyRequestStatusEnumMap[instance.status]!,
      'createdAt': BuddyRequestModel._timestampToJson(instance.createdAt),
    };

const _$BuddyRequestStatusEnumMap = {
  BuddyRequestStatus.pending: 'pending',
  BuddyRequestStatus.accepted: 'accepted',
  BuddyRequestStatus.declined: 'declined',
};
