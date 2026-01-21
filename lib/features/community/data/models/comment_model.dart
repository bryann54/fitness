import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'comment_model.g.dart';

@JsonSerializable(explicitToJson: true)
class CommentModel extends Equatable {
  final String id;
  final String postId;
  final String userId;
  final String userName;
  final String? userPhotoUrl;
  final String content;
  final int likes;
  final List<String> likedBy;

  @JsonKey(fromJson: _timestampFromJson, toJson: _timestampToJson)
  final DateTime createdAt;

  const CommentModel({
    required this.id,
    required this.postId,
    required this.userId,
    required this.userName,
    this.userPhotoUrl,
    required this.content,
    this.likes = 0,
    this.likedBy = const [],
    required this.createdAt,
  });

  static DateTime _timestampFromJson(dynamic timestamp) {
    if (timestamp is Timestamp) {
      return timestamp.toDate();
    }
    return DateTime.parse(timestamp as String);
  }

  static dynamic _timestampToJson(DateTime date) => date.toIso8601String();

  factory CommentModel.fromJson(Map<String, dynamic> json) =>
      _$CommentModelFromJson(json);

  Map<String, dynamic> toJson() => _$CommentModelToJson(this);

  @override
  List<Object?> get props => [id, postId, userId, content, createdAt];
}
