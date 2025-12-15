// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'exercise_category_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ExerciseCategoryModel _$ExerciseCategoryModelFromJson(
        Map<String, dynamic> json) =>
    ExerciseCategoryModel(
      id: (json['id'] as num).toInt(),
      name: json['name'] as String,
    );

Map<String, dynamic> _$ExerciseCategoryModelToJson(
        ExerciseCategoryModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
    };

ExerciseCategoryResponse _$ExerciseCategoryResponseFromJson(
        Map<String, dynamic> json) =>
    ExerciseCategoryResponse(
      count: (json['count'] as num).toInt(),
      next: json['next'] as String?,
      previous: json['previous'] as String?,
      results: (json['results'] as List<dynamic>)
          .map((e) => ExerciseCategoryModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ExerciseCategoryResponseToJson(
        ExerciseCategoryResponse instance) =>
    <String, dynamic>{
      'count': instance.count,
      'next': instance.next,
      'previous': instance.previous,
      'results': instance.results,
    };
