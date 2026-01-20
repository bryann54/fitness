// lib/features/onboarding/presentation/pages/experience_screen.dart

import 'package:auto_route/auto_route.dart';
import 'package:fitness/common/res/colors.dart';
import 'package:fitness/features/onboarding/presentation/widgets/onboarding_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
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

  Widget _buildActionButton({
    required String label,
    required Color color,
    required VoidCallback onPressed,
    required bool isNegative,
  }) {
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
                  color: AppColors.cardLight,
                ),
              ),
              const SizedBox(width: 8),
              Icon(
                isNegative ? Icons.close : Icons.check,
                color: AppColors.cardLight,
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
      backgroundColor: AppColors.cardDark,
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

              // Animated title
              Text(
                "Do you have previous fitness experience?",
                style: theme.textTheme.headlineMedium?.copyWith(
                  color: AppColors.cardLight,
                  fontWeight: FontWeight.w800,
                ),
              )
                  .animate()
                  .fadeIn(duration: 600.ms, curve: Curves.easeOut)
                  .slideX(
                      begin: -0.2,
                      end: 0,
                      duration: 600.ms,
                      curve: Curves.easeOut),

              const SizedBox(height: 30),

              // Animated image section
              Expanded(
                child: Center(
                  child: Image.asset(
                    'assets/equip1.png',
                    height: 300,
                    width: double.infinity,
                    fit: BoxFit.contain,
                    errorBuilder: (context, error, stackTrace) => Container(
                      height: 300,
                      color: darkButtonColor,
                      alignment: Alignment.center,
                      child: const Text(
                        'Gym Machine Image',
                        style: TextStyle(color: AppColors.cardLight),
                      ),
                    ),
                  )
                      .animate()
                      .scale(
                        begin: const Offset(0.2, 0.8),
                        end: const Offset(1.0, 1.0),
                        duration: 1800.ms,
                        curve: Curves.easeOutBack,
                      )
                      .fadeIn(duration: 600.ms, delay: 200.ms),
                ),
              ),

              const SizedBox(height: 40),

              // Animated action buttons
              Row(
                children: [
                  _buildActionButton(
                    label: 'No',
                    color: darkButtonColor,
                    isNegative: true,
                    onPressed: () =>
                        _navigateToNextScreen(WorkoutExperience.never),
                  ).animate().fadeIn(duration: 600.ms, delay: 400.ms).slideX(
                        begin: -0.3,
                        end: 0,
                        duration: 600.ms,
                        delay: 400.ms,
                        curve: Curves.easeOut,
                      ),
                  _buildActionButton(
                    label: 'Yes',
                    color: primaryColor,
                    isNegative: false,
                    onPressed: () =>
                        _navigateToNextScreen(WorkoutExperience.beginner),
                  ).animate().fadeIn(duration: 600.ms, delay: 500.ms).slideX(
                        begin: 0.3,
                        end: 0,
                        duration: 600.ms,
                        delay: 500.ms,
                        curve: Curves.easeOut,
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
