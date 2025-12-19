// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'workout_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WorkoutModel _$WorkoutModelFromJson(Map<String, dynamic> json) => WorkoutModel(
      day: json['day'] as String,
      focus: json['focus'] as String,
      duration: json['duration'] as String,
      location: json['location'] as String,
      muscleCategory: json['muscleCategory'] as String,
      totalExercises: (json['totalExercises'] as num).toInt(),
      exercises: (json['exercises'] as List<dynamic>)
          .map((e) => ExerciseModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      lastUpdated: json['lastUpdated'] == null
          ? null
          : DateTime.parse(json['lastUpdated'] as String),
    );

Map<String, dynamic> _$WorkoutModelToJson(WorkoutModel instance) =>
    <String, dynamic>{
      'day': instance.day,
      'focus': instance.focus,
      'duration': instance.duration,
      'location': instance.location,
      'muscleCategory': instance.muscleCategory,
      'totalExercises': instance.totalExercises,
      'exercises': instance.exercises.map((e) => e.toJson()).toList(),
      'lastUpdated': instance.lastUpdated?.toIso8601String(),
    };

ExerciseModel _$ExerciseModelFromJson(Map<String, dynamic> json) =>
    ExerciseModel(
      day: json['day'] as String,
      focus: json['focus'] as String,
      duration: json['duration'] as String,
      exercise: json['exercise'] as String,
      sets: json['sets'] as String,
      reps: json['reps'] as String,
      rpe: json['rpe'] as String,
      notes: json['notes'] as String,
      imageUrl: json['imageUrl'] as String,
      location: json['location'] as String,
      muscleCategory: json['muscleCategory'] as String,
      isAbExercise: json['isAbExercise'] as bool,
    );

Map<String, dynamic> _$ExerciseModelToJson(ExerciseModel instance) =>
    <String, dynamic>{
      'day': instance.day,
      'focus': instance.focus,
      'duration': instance.duration,
      'exercise': instance.exercise,
      'sets': instance.sets,
      'reps': instance.reps,
      'rpe': instance.rpe,
      'notes': instance.notes,
      'imageUrl': instance.imageUrl,
      'location': instance.location,
      'muscleCategory': instance.muscleCategory,
      'isAbExercise': instance.isAbExercise,
    };
