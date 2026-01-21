// lib/features/community/data/models/leaderboard_entry_model.dart
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
part 'leaderboard_entry_model.g.dart';

@JsonSerializable(explicitToJson: true)
class LeaderboardEntryModel extends Equatable {
  final String userId;
  final String userName;
  final String? userPhotoUrl;
  final int rank;
  final int points;
  final int workoutsCompleted;
  final int streak;
  final String category; // 'weekly', 'monthly', 'allTime'

  const LeaderboardEntryModel({
    required this.userId,
    required this.userName,
    this.userPhotoUrl,
    required this.rank,
    required this.points,
    required this.workoutsCompleted,
    required this.streak,
    required this.category,
  });

  factory LeaderboardEntryModel.fromJson(Map<String, dynamic> json) =>
      _$LeaderboardEntryModelFromJson(json);

  Map<String, dynamic> toJson() => _$LeaderboardEntryModelToJson(this);

  @override
  List<Object?> get props => [userId, category, rank];
}
