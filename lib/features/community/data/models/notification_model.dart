// lib/features/community/data/models/notification_model.dart
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
part 'notification_model.g.dart';

enum NotificationType {
  like,
  comment,
  follow,
  achievement,
  groupInvite,
  workoutBuddy
}

@JsonSerializable(explicitToJson: true)
class NotificationModel extends Equatable {
  final String id;
  final String userId;
  final NotificationType type;
  final String fromUserId;
  final String fromUserName;
  final String? fromUserPhotoUrl;
  final String content;
  final String? referenceId;
  final bool isRead;

  @JsonKey(fromJson: _timestampFromJson, toJson: _timestampToJson)
  final DateTime createdAt;

  const NotificationModel({
    required this.id,
    required this.userId,
    required this.type,
    required this.fromUserId,
    required this.fromUserName,
    this.fromUserPhotoUrl,
    required this.content,
    this.referenceId,
    this.isRead = false,
    required this.createdAt,
  });

  static DateTime _timestampFromJson(dynamic timestamp) {
    if (timestamp is Timestamp) {
      return timestamp.toDate();
    }
    return DateTime.parse(timestamp as String);
  }

  static dynamic _timestampToJson(DateTime date) => date.toIso8601String();

  factory NotificationModel.fromJson(Map<String, dynamic> json) =>
      _$NotificationModelFromJson(json);

  Map<String, dynamic> toJson() => _$NotificationModelToJson(this);

  NotificationModel copyWith({bool? isRead}) {
    return NotificationModel(
      id: id,
      userId: userId,
      type: type,
      fromUserId: fromUserId,
      fromUserName: fromUserName,
      fromUserPhotoUrl: fromUserPhotoUrl,
      content: content,
      referenceId: referenceId,
      isRead: isRead ?? this.isRead,
      createdAt: createdAt,
    );
  }

  @override
  List<Object?> get props => [id, userId, type, createdAt, isRead];
}
