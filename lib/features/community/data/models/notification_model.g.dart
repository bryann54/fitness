// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notification_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NotificationModel _$NotificationModelFromJson(Map<String, dynamic> json) =>
    NotificationModel(
      id: json['id'] as String,
      userId: json['userId'] as String,
      type: $enumDecode(_$NotificationTypeEnumMap, json['type']),
      fromUserId: json['fromUserId'] as String,
      fromUserName: json['fromUserName'] as String,
      fromUserPhotoUrl: json['fromUserPhotoUrl'] as String?,
      content: json['content'] as String,
      referenceId: json['referenceId'] as String?,
      isRead: json['isRead'] as bool? ?? false,
      createdAt: NotificationModel._timestampFromJson(json['createdAt']),
    );

Map<String, dynamic> _$NotificationModelToJson(NotificationModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'userId': instance.userId,
      'type': _$NotificationTypeEnumMap[instance.type]!,
      'fromUserId': instance.fromUserId,
      'fromUserName': instance.fromUserName,
      'fromUserPhotoUrl': instance.fromUserPhotoUrl,
      'content': instance.content,
      'referenceId': instance.referenceId,
      'isRead': instance.isRead,
      'createdAt': NotificationModel._timestampToJson(instance.createdAt),
    };

const _$NotificationTypeEnumMap = {
  NotificationType.like: 'like',
  NotificationType.comment: 'comment',
  NotificationType.follow: 'follow',
  NotificationType.achievement: 'achievement',
  NotificationType.groupInvite: 'groupInvite',
  NotificationType.workoutBuddy: 'workoutBuddy',
};
