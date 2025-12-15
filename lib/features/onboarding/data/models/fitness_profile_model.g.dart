// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'fitness_profile_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FitnessProfileModel _$FitnessProfileModelFromJson(Map<String, dynamic> json) =>
    FitnessProfileModel(
      uid: json['uid'] as String,
      gender: json['gender'] as String,
      age: (json['age'] as num).toInt(),
      currentWeightKg: (json['currentWeightKg'] as num).toDouble(),
      heightCm: (json['heightCm'] as num).toInt(),
      experience: $enumDecode(_$WorkoutExperienceEnumMap, json['experience']),
      primaryGoal: $enumDecode(_$FitnessGoalEnumMap, json['primaryGoal']),
      fitnessLevel: json['fitnessLevel'] as String,
      physicalLimitations: json['physicalLimitations'] as String?,
      workoutsPerWeek: (json['workoutsPerWeek'] as num).toInt(),
      isTakingSupplements: json['isTakingSupplements'] as bool,
      dietPreference: json['dietPreference'] as String,
      workoutPreferences: (json['workoutPreferences'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      sleepQuality: $enumDecode(_$SleepQualityEnumMap, json['sleepQuality']),
      supplementsTaken: (json['supplementsTaken'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      calorieGoal: (json['calorieGoal'] as num).toInt(),
      calorieUnit: json['calorieUnit'] as String,
    );

Map<String, dynamic> _$FitnessProfileModelToJson(
        FitnessProfileModel instance) =>
    <String, dynamic>{
      'uid': instance.uid,
      'gender': instance.gender,
      'age': instance.age,
      'currentWeightKg': instance.currentWeightKg,
      'heightCm': instance.heightCm,
      'experience': _$WorkoutExperienceEnumMap[instance.experience]!,
      'primaryGoal': _$FitnessGoalEnumMap[instance.primaryGoal]!,
      'fitnessLevel': instance.fitnessLevel,
      'physicalLimitations': instance.physicalLimitations,
      'workoutsPerWeek': instance.workoutsPerWeek,
      'isTakingSupplements': instance.isTakingSupplements,
      'supplementsTaken': instance.supplementsTaken,
      'calorieGoal': instance.calorieGoal,
      'calorieUnit': instance.calorieUnit,
      'dietPreference': instance.dietPreference,
      'workoutPreferences': instance.workoutPreferences,
      'sleepQuality': _$SleepQualityEnumMap[instance.sleepQuality]!,
    };

const _$WorkoutExperienceEnumMap = {
  WorkoutExperience.never: 'never',
  WorkoutExperience.beginner: 'beginner',
  WorkoutExperience.intermediate: 'intermediate',
  WorkoutExperience.advanced: 'advanced',
};

const _$FitnessGoalEnumMap = {
  FitnessGoal.loseWeight: 'loseWeight',
  FitnessGoal.gainMuscle: 'gainMuscle',
  FitnessGoal.improveEndurance: 'improveEndurance',
  FitnessGoal.maintenance: 'maintenance',
};

const _$SleepQualityEnumMap = {
  SleepQuality.poor: 'poor',
  SleepQuality.fair: 'fair',
  SleepQuality.good: 'good',
  SleepQuality.excellent: 'excellent',
};
