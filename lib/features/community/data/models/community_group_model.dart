// lib/features/community/data/models/community_group_model.dart
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
part 'community_group_model.g.dart';

@JsonSerializable(explicitToJson: true)
class CommunityGroupModel extends Equatable {
  final String id;
  final String name;
  final String description;
  final String imageUrl;
  final GroupType groupType;
  final int memberCount;
  final List<String> members;
  final String createdBy;

  // Group criteria for smart matching
  final String? fitnessGoal;
  final String? workoutPreference;
  final String? experienceLevel;
  final String? gender;

  @JsonKey(fromJson: _timestampFromJson, toJson: _timestampToJson)
  final DateTime createdAt;

  const CommunityGroupModel({
    required this.id,
    required this.name,
    required this.description,
    required this.imageUrl,
    required this.groupType,
    this.memberCount = 0,
    this.members = const [],
    required this.createdBy,
    this.fitnessGoal,
    this.workoutPreference,
    this.experienceLevel,
    this.gender,
    required this.createdAt,
  });

  static DateTime _timestampFromJson(dynamic timestamp) {
    if (timestamp is Timestamp) return timestamp.toDate();
    return DateTime.parse(timestamp as String);
  }

  static dynamic _timestampToJson(DateTime date) => date.toIso8601String();

  factory CommunityGroupModel.fromJson(Map<String, dynamic> json) =>
      _$CommunityGroupModelFromJson(json);

  Map<String, dynamic> toJson() => _$CommunityGroupModelToJson(this);

  @override
  List<Object?> get props => [id, name, groupType];
}

enum GroupType { goal, workout, experience, general }
