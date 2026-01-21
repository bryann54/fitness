// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'comment_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CommentModel _$CommentModelFromJson(Map<String, dynamic> json) => CommentModel(
      id: json['id'] as String,
      postId: json['postId'] as String,
      userId: json['userId'] as String,
      userName: json['userName'] as String,
      userPhotoUrl: json['userPhotoUrl'] as String?,
      content: json['content'] as String,
      likes: (json['likes'] as num?)?.toInt() ?? 0,
      likedBy: (json['likedBy'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      createdAt: CommentModel._timestampFromJson(json['createdAt']),
    );

Map<String, dynamic> _$CommentModelToJson(CommentModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'postId': instance.postId,
      'userId': instance.userId,
      'userName': instance.userName,
      'userPhotoUrl': instance.userPhotoUrl,
      'content': instance.content,
      'likes': instance.likes,
      'likedBy': instance.likedBy,
      'createdAt': CommentModel._timestampToJson(instance.createdAt),
    };
