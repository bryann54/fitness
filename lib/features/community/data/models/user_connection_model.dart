// lib/features/community/data/models/user_connection_model.dart
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
part 'user_connection_model.g.dart';

@JsonSerializable(explicitToJson: true)
class UserConnectionModel extends Equatable {
  final String userId;
  final String connectedUserId;
  final String connectedUserName;
  final String? connectedUserPhotoUrl;
  final ConnectionType connectionType;
  final int compatibilityScore; // 0-100
  final List<String> sharedInterests;

  @JsonKey(fromJson: _timestampFromJson, toJson: _timestampToJson)
  final DateTime connectedAt;

  const UserConnectionModel({
    required this.userId,
    required this.connectedUserId,
    required this.connectedUserName,
    this.connectedUserPhotoUrl,
    required this.connectionType,
    required this.compatibilityScore,
    this.sharedInterests = const [],
    required this.connectedAt,
  });

  static DateTime _timestampFromJson(dynamic timestamp) {
    if (timestamp is Timestamp) return timestamp.toDate();
    return DateTime.parse(timestamp as String);
  }

  static dynamic _timestampToJson(DateTime date) => date.toIso8601String();

  factory UserConnectionModel.fromJson(Map<String, dynamic> json) =>
      _$UserConnectionModelFromJson(json);

  Map<String, dynamic> toJson() => _$UserConnectionModelToJson(this);

  @override
  List<Object?> get props => [userId, connectedUserId];
}

enum ConnectionType { following, follower, buddy, mutual }
