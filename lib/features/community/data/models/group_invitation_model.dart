// lib/features/community/data/models/group_invitation_model.dart
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
part 'group_invitation_model.g.dart';

@JsonSerializable(explicitToJson: true)
class GroupInvitationModel extends Equatable {
  final String id;
  final String groupId;
  final String groupName;
  final String fromUserId;
  final String fromUserName;
  final String toUserId;
  final InvitationStatus status;

  @JsonKey(fromJson: _timestampFromJson, toJson: _timestampToJson)
  final DateTime createdAt;

  const GroupInvitationModel({
    required this.id,
    required this.groupId,
    required this.groupName,
    required this.fromUserId,
    required this.fromUserName,
    required this.toUserId,
    this.status = InvitationStatus.pending,
    required this.createdAt,
  });

  static DateTime _timestampFromJson(dynamic timestamp) {
    if (timestamp is Timestamp) {
      return timestamp.toDate();
    }
    return DateTime.parse(timestamp as String);
  }

  static dynamic _timestampToJson(DateTime date) => date.toIso8601String();

  factory GroupInvitationModel.fromJson(Map<String, dynamic> json) =>
      _$GroupInvitationModelFromJson(json);

  Map<String, dynamic> toJson() => _$GroupInvitationModelToJson(this);

  @override
  List<Object?> get props => [id, groupId, toUserId, status];
}

enum InvitationStatus { pending, accepted, declined }
