// lib/features/onboarding/presentation/pages/experience_screen.dart

import 'package:auto_route/auto_route.dart';
import 'package:fitness/features/onboarding/presentation/widgets/onboarding_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:fitness/common/helpers/app_router.gr.dart';
import 'package:fitness/features/onboarding/data/models/fitness_profile_model.dart';

@RoutePage()
class ExperienceScreen extends StatefulWidget {
  final FitnessProfileModel profile;

  const ExperienceScreen({super.key, required this.profile});

  @override
  State<ExperienceScreen> createState() => _ExperienceScreenState();
}

class _ExperienceScreenState extends State<ExperienceScreen> {
  static const Color primaryColor = Colors.teal;
  static const Color darkButtonColor = Color.fromARGB(255, 50, 50, 50);

  Widget _buildActionButton(
      {required String label,
      required Color color,
      required VoidCallback onPressed,
      required bool isNegative}) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: ElevatedButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
            backgroundColor: color,
            padding: const EdgeInsets.symmetric(vertical: 18),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.0),
            ),
            elevation: 0,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                label,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(width: 8),
              Icon(
                isNegative ? Icons.close : Icons.check,
                color: Colors.white,
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _navigateToNextScreen(WorkoutExperience experience) {
    final updatedProfile = FitnessProfileModel(
      uid: widget.profile.uid,
      primaryGoal: widget.profile.primaryGoal,
      gender: widget.profile.gender,
      currentWeightKg: widget.profile.currentWeightKg,
      age: widget.profile.age,
      experience: experience,
      heightCm: widget.profile.heightCm,
      fitnessLevel: widget.profile.fitnessLevel,
      workoutsPerWeek: widget.profile.workoutsPerWeek,
      isTakingSupplements: widget.profile.isTakingSupplements,
      dietPreference: widget.profile.dietPreference,
      workoutPreferences: widget.profile.workoutPreferences,
      sleepQuality: widget.profile.sleepQuality,
      physicalLimitations: widget.profile.physicalLimitations,
      calorieGoal: 0,
      calorieUnit: 'Kcal',
    );

    context.router.push(FitnessLevelRoute(profile: updatedProfile));
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: const OnboardingAppBar(
        currentStep: 5,
        totalSteps: 17,
        isInitial: false,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 10),
              Text(
                "Do you have previous fitness experience?",
                style: theme.textTheme.headlineMedium?.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.w800,
                ),
              ),
              const SizedBox(height: 30),

              // Image section
              Expanded(
                child: Center(
                  child: Image.asset(
                    'assets/equip1.png', // Placeholder for the gym machine image
                    height: 300,
                    width: double.infinity,
                    fit: BoxFit.contain,
                    // Fallback container if the asset is missing
                    errorBuilder: (context, error, stackTrace) => Container(
                      height: 300,
                      color: darkButtonColor,
                      alignment: Alignment.center,
                      child: const Text('Gym Machine Image',
                          style: TextStyle(color: Colors.white70)),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 40),

              // Action Buttons (Yes / No)
              Row(
                children: [
                  _buildActionButton(
                    label: 'No',
                    color: darkButtonColor,
                    isNegative: true,
                    onPressed: () =>
                        _navigateToNextScreen(WorkoutExperience.never),
                  ),
                  _buildActionButton(
                    label: 'Yes',
                    color: primaryColor,
                    isNegative: false,
                    onPressed: () =>
                        _navigateToNextScreen(WorkoutExperience.beginner),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
