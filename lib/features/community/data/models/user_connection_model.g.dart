// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_connection_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserConnectionModel _$UserConnectionModelFromJson(Map<String, dynamic> json) =>
    UserConnectionModel(
      userId: json['userId'] as String,
      connectedUserId: json['connectedUserId'] as String,
      connectedUserName: json['connectedUserName'] as String,
      connectedUserPhotoUrl: json['connectedUserPhotoUrl'] as String?,
      connectionType:
          $enumDecode(_$ConnectionTypeEnumMap, json['connectionType']),
      compatibilityScore: (json['compatibilityScore'] as num).toInt(),
      sharedInterests: (json['sharedInterests'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      connectedAt: UserConnectionModel._timestampFromJson(json['connectedAt']),
    );

Map<String, dynamic> _$UserConnectionModelToJson(
        UserConnectionModel instance) =>
    <String, dynamic>{
      'userId': instance.userId,
      'connectedUserId': instance.connectedUserId,
      'connectedUserName': instance.connectedUserName,
      'connectedUserPhotoUrl': instance.connectedUserPhotoUrl,
      'connectionType': _$ConnectionTypeEnumMap[instance.connectionType]!,
      'compatibilityScore': instance.compatibilityScore,
      'sharedInterests': instance.sharedInterests,
      'connectedAt': UserConnectionModel._timestampToJson(instance.connectedAt),
    };

const _$ConnectionTypeEnumMap = {
  ConnectionType.following: 'following',
  ConnectionType.follower: 'follower',
  ConnectionType.buddy: 'buddy',
  ConnectionType.mutual: 'mutual',
};
