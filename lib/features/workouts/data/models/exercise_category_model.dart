// lib/features/workouts/data/models/exercise_category_model.dart

import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'exercise_category_model.g.dart';

@JsonSerializable()
class ExerciseCategoryModel extends Equatable {
  final int id;
  final String name;

  const ExerciseCategoryModel({
    required this.id,
    required this.name,
  });

  factory ExerciseCategoryModel.fromJson(Map<String, dynamic> json) =>
      _$ExerciseCategoryModelFromJson(json);

  Map<String, dynamic> toJson() => _$ExerciseCategoryModelToJson(this);

  @override
  List<Object> get props => [id, name];
}

// Model for the Paged Response structure from the API
@JsonSerializable()
class ExerciseCategoryResponse extends Equatable {
  final int count;
  final String? next;
  final String? previous;
  final List<ExerciseCategoryModel> results;

  const ExerciseCategoryResponse({
    required this.count,
    this.next,
    this.previous,
    required this.results,
  });

  factory ExerciseCategoryResponse.fromJson(Map<String, dynamic> json) =>
      _$ExerciseCategoryResponseFromJson(json);

  @override
  List<Object?> get props => [count, next, previous, results];
}
