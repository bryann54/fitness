// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'group_invitation_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GroupInvitationModel _$GroupInvitationModelFromJson(
        Map<String, dynamic> json) =>
    GroupInvitationModel(
      id: json['id'] as String,
      groupId: json['groupId'] as String,
      groupName: json['groupName'] as String,
      fromUserId: json['fromUserId'] as String,
      fromUserName: json['fromUserName'] as String,
      toUserId: json['toUserId'] as String,
      status: $enumDecodeNullable(_$InvitationStatusEnumMap, json['status']) ??
          InvitationStatus.pending,
      createdAt: GroupInvitationModel._timestampFromJson(json['createdAt']),
    );

Map<String, dynamic> _$GroupInvitationModelToJson(
        GroupInvitationModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'groupId': instance.groupId,
      'groupName': instance.groupName,
      'fromUserId': instance.fromUserId,
      'fromUserName': instance.fromUserName,
      'toUserId': instance.toUserId,
      'status': _$InvitationStatusEnumMap[instance.status]!,
      'createdAt': GroupInvitationModel._timestampToJson(instance.createdAt),
    };

const _$InvitationStatusEnumMap = {
  InvitationStatus.pending: 'pending',
  InvitationStatus.accepted: 'accepted',
  InvitationStatus.declined: 'declined',
};
