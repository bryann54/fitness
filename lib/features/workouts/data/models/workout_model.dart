// lib/features/workouts/data/models/workout_model.dart
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'workout_model.g.dart';

@JsonSerializable(explicitToJson: true)
class WorkoutModel extends Equatable {
  final String day;
  final String focus;
  final String duration;
  final String location; // 'gym', 'home', 'both'
  final String muscleCategory;
  final int totalExercises;
  final List<ExerciseModel> exercises;
  final DateTime? lastUpdated;

  const WorkoutModel({
    required this.day,
    required this.focus,
    required this.duration,
    required this.location,
    required this.muscleCategory,
    required this.totalExercises,
    required this.exercises,
    this.lastUpdated,
  });

  factory WorkoutModel.fromJson(Map<String, dynamic> json) =>
      _$WorkoutModelFromJson(json);

  Map<String, dynamic> toJson() => _$WorkoutModelToJson(this);

  @override
  List<Object?> get props => [
        day,
        focus,
        duration,
        location,
        muscleCategory,
        totalExercises,
        exercises,
        lastUpdated,
      ];
}

@JsonSerializable(explicitToJson: true)
class ExerciseModel extends Equatable {
  final String day;
  final String focus;
  final String duration;
  final String exercise;
  final String sets;
  final String reps;
  final String rpe;
  final String notes;
  final String imageUrl;
  final String location;
  final String muscleCategory;
  final bool isAbExercise;

  const ExerciseModel({
    required this.day,
    required this.focus,
    required this.duration,
    required this.exercise,
    required this.sets,
    required this.reps,
    required this.rpe,
    required this.notes,
    required this.imageUrl,
    required this.location,
    required this.muscleCategory,
    required this.isAbExercise,
  });

  factory ExerciseModel.fromJson(Map<String, dynamic> json) =>
      _$ExerciseModelFromJson(json);

  Map<String, dynamic> toJson() => _$ExerciseModelToJson(this);

  @override
  List<Object?> get props => [
        day,
        focus,
        duration,
        exercise,
        sets,
        reps,
        rpe,
        notes,
        imageUrl,
        location,
        muscleCategory,
        isAbExercise,
      ];
}
