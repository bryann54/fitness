// lib/features/onboarding/data/models/fitness_profile_model.dart

import 'package:cloud_firestore/cloud_firestore.dart'; // Required for Timestamp
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'fitness_profile_model.g.dart';

enum WorkoutExperience { never, beginner, intermediate, advanced }

enum FitnessGoal { loseWeight, gainMuscle, improveEndurance, maintenance }

enum SleepQuality { poor, fair, good, excellent }

@JsonSerializable(explicitToJson: true)
class FitnessProfileModel extends Equatable {
  final String uid;

  // Biometrics & Demographics
  final String gender;
  final int age;
  final double currentWeightKg;
  final int heightCm;

  // Social Metrics
  final int followersCount;
  final int followingCount;
  final int postsCount;

  @JsonKey(fromJson: _timestampFromJson, toJson: _timestampToJson)
  final DateTime? lastActive;

  // Fitness Metrics
  final WorkoutExperience experience;
  final FitnessGoal primaryGoal;
  final String fitnessLevel;
  final String? physicalLimitations;
  final int workoutsPerWeek;
  final bool isTakingSupplements;
  final List<String> supplementsTaken;

  // Calorie Fields
  final int calorieGoal;
  final String calorieUnit;

  // Preferences
  final String dietPreference;
  final List<String> workoutPreferences;
  final SleepQuality sleepQuality;

  const FitnessProfileModel({
    required this.uid,
    required this.gender,
    required this.age,
    required this.currentWeightKg,
    required this.heightCm,
    required this.experience,
    required this.primaryGoal,
    required this.fitnessLevel,
    this.physicalLimitations,
    required this.workoutsPerWeek,
    required this.isTakingSupplements,
    required this.dietPreference,
    required this.workoutPreferences,
    required this.sleepQuality,
    required this.calorieGoal,
    required this.calorieUnit,
    this.followersCount = 0,
    this.followingCount = 0,
    this.postsCount = 0,
    this.lastActive,
    this.supplementsTaken = const [],
  });

  FitnessProfileModel copyWith({
    String? uid,
    String? gender,
    int? age,
    double? currentWeightKg,
    int? heightCm,
    int? followersCount,
    int? followingCount,
    int? postsCount,
    DateTime? lastActive,
    WorkoutExperience? experience,
    FitnessGoal? primaryGoal,
    String? fitnessLevel,
    String? physicalLimitations,
    int? workoutsPerWeek,
    bool? isTakingSupplements,
    List<String>? supplementsTaken,
    int? calorieGoal,
    String? calorieUnit,
    String? dietPreference,
    List<String>? workoutPreferences,
    SleepQuality? sleepQuality,
  }) {
    return FitnessProfileModel(
      uid: uid ?? this.uid,
      gender: gender ?? this.gender,
      age: age ?? this.age,
      currentWeightKg: currentWeightKg ?? this.currentWeightKg,
      heightCm: heightCm ?? this.heightCm,
      followersCount: followersCount ?? this.followersCount,
      followingCount: followingCount ?? this.followingCount,
      postsCount: postsCount ?? this.postsCount,
      lastActive: lastActive ?? this.lastActive,
      experience: experience ?? this.experience,
      primaryGoal: primaryGoal ?? this.primaryGoal,
      fitnessLevel: fitnessLevel ?? this.fitnessLevel,
      physicalLimitations: physicalLimitations ?? this.physicalLimitations,
      workoutsPerWeek: workoutsPerWeek ?? this.workoutsPerWeek,
      isTakingSupplements: isTakingSupplements ?? this.isTakingSupplements,
      supplementsTaken: supplementsTaken ?? this.supplementsTaken,
      calorieGoal: calorieGoal ?? this.calorieGoal,
      calorieUnit: calorieUnit ?? this.calorieUnit,
      dietPreference: dietPreference ?? this.dietPreference,
      workoutPreferences: workoutPreferences ?? this.workoutPreferences,
      sleepQuality: sleepQuality ?? this.sleepQuality,
    );
  }

  factory FitnessProfileModel.fromJson(Map<String, dynamic> json) =>
      _$FitnessProfileModelFromJson(json);

  Map<String, dynamic> toJson() => _$FitnessProfileModelToJson(this);

  @override
  List<Object?> get props => [
        uid,
        gender,
        age,
        currentWeightKg,
        heightCm,
        followersCount,
        followingCount,
        postsCount,
        lastActive,
        experience,
        primaryGoal,
        fitnessLevel,
        physicalLimitations,
        workoutsPerWeek,
        isTakingSupplements,
        supplementsTaken,
        calorieGoal,
        calorieUnit,
        dietPreference,
        workoutPreferences,
        sleepQuality,
      ];

  // Helper methods moved inside the class body
  static DateTime? _timestampFromJson(dynamic timestamp) {
    if (timestamp == null) return null;
    if (timestamp is Timestamp) {
      return timestamp.toDate();
    }
    if (timestamp is String) {
      return DateTime.parse(timestamp);
    }
    return null;
  }

  static dynamic _timestampToJson(DateTime? date) => date?.toIso8601String();
}
