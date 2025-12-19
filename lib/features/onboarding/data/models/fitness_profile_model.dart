// lib/features/onboarding/data/models/fitness_profile_model.dart

import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'fitness_profile_model.g.dart';

// Enums for strongly typed, controlled data entry
enum WorkoutExperience { never, beginner, intermediate, advanced }

enum FitnessGoal { loseWeight, gainMuscle, improveEndurance, maintenance }

enum SleepQuality { poor, fair, good, excellent }

@JsonSerializable(
    explicitToJson: true) // explicitly use toJson for nested objects/enums
class FitnessProfileModel extends Equatable {
  final String uid;

  // Biometrics & Demographics
  final String gender;
  final int age;
  final double currentWeightKg;
  final int heightCm;

  // Fitness Metrics
  final WorkoutExperience experience;
  final FitnessGoal primaryGoal;
  final String fitnessLevel; // e.g., Beginner-Intermediate
  final String? physicalLimitations; // e.g., 'Knee injury'
  final int workoutsPerWeek;
  final bool isTakingSupplements;
  final List<String> supplementsTaken;

  // --- NEW CALORIE FIELDS ---
  final int calorieGoal;
  final String calorieUnit;
  // --------------------------

  // Preferences
  final String dietPreference; // e.g., 'Vegetarian', 'Keto'
  final List<String> workoutPreferences; // e.g., ['Gym', 'Home', 'Cardio']
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
    // Provide default value for list fields
    this.supplementsTaken = const [],
    // --- NEW FIELDS MUST BE REQUIRED OR HAVE DEFAULTS ---
    required this.calorieGoal,
    required this.calorieUnit,
  });
  FitnessProfileModel copyWith({
    String? uid,
    String? gender,
    int? age,
    double? currentWeightKg,
    int? heightCm,
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
        experience,
        primaryGoal,
        fitnessLevel,
        physicalLimitations,
        workoutsPerWeek,
        isTakingSupplements,
        supplementsTaken,
        calorieGoal, // <--- ADDED
        calorieUnit, // <--- ADDED
        dietPreference,
        workoutPreferences,
        sleepQuality,
      ];
}
