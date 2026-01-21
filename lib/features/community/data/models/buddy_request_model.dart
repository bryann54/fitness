// lib/features/community/data/models/buddy_request_model.dart
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
part 'buddy_request_model.g.dart';

@JsonSerializable(explicitToJson: true)
class BuddyRequestModel extends Equatable {
  final String id;
  final String fromUserId;
  final String fromUserName;
  final String? fromUserPhotoUrl;
  final String toUserId;
  final String message;
  final int compatibilityScore;
  final List<String> sharedGoals;
  final BuddyRequestStatus status;

  @JsonKey(fromJson: _timestampFromJson, toJson: _timestampToJson)
  final DateTime createdAt;

  const BuddyRequestModel({
    required this.id,
    required this.fromUserId,
    required this.fromUserName,
    this.fromUserPhotoUrl,
    required this.toUserId,
    required this.message,
    required this.compatibilityScore,
    this.sharedGoals = const [],
    this.status = BuddyRequestStatus.pending,
    required this.createdAt,
  });

  static DateTime _timestampFromJson(dynamic timestamp) {
    if (timestamp is Timestamp) {
      return timestamp.toDate();
    }
    return DateTime.parse(timestamp as String);
  }

  static dynamic _timestampToJson(DateTime date) => date.toIso8601String();

  factory BuddyRequestModel.fromJson(Map<String, dynamic> json) =>
      _$BuddyRequestModelFromJson(json);

  Map<String, dynamic> toJson() => _$BuddyRequestModelToJson(this);

  @override
  List<Object?> get props => [id, fromUserId, toUserId, status];
}

enum BuddyRequestStatus { pending, accepted, declined }
