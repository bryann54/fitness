// lib/features/onboarding/presentation/pages/exercise_pref_screen.dart

import 'package:auto_route/auto_route.dart';
import 'package:fitness/features/onboarding/presentation/widgets/onboarding_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:fitness/common/helpers/app_router.gr.dart';
import 'package:fitness/features/onboarding/data/models/fitness_profile_model.dart';
import 'package:fitness/features/onboarding/presentation/widgets/continue_button.dart';

// Data structure for the exercise options
class ExerciseOption {
  final String title;
  final IconData icon;

  ExerciseOption(this.title, this.icon);
}

@RoutePage()
class ExercisePrefScreen extends StatefulWidget {
  // CRITICAL: Profile model must be carried forward
  final FitnessProfileModel profile;
  const ExercisePrefScreen({super.key, required this.profile});

  @override
  State<ExercisePrefScreen> createState() => _ExercisePrefScreenState();
}

class _ExercisePrefScreenState extends State<ExercisePrefScreen> {
  static const Color primaryColor = Color(0xFFFF9800);
  static const Color tileColor = Color(0xFF2C2C2C);
  static const Color unselectedIconColor = Colors.white60;

  // List of exercise options matching the 3x3 grid in the screenshot
  final List<ExerciseOption> exerciseOptions = [
    ExerciseOption("Jogging", Icons.directions_run),
    ExerciseOption("Walking", Icons.directions_walk),
    ExerciseOption("Hiking", Icons.hiking),
    ExerciseOption("Skating", Icons.ice_skating),
    ExerciseOption("Biking", Icons.directions_bike),
    ExerciseOption("Weightlift", Icons.fitness_center),
    ExerciseOption("Cardio", Icons.monitor_heart),
    ExerciseOption("Yoga", Icons.self_improvement),
    ExerciseOption("Other", Icons.settings),
  ];

  // List to hold the titles of selected options
  final List<String> _selectedPreferences = [];

  // --- Logic to toggle selection ---
  void _toggleSelection(String title) {
    setState(() {
      if (_selectedPreferences.contains(title)) {
        _selectedPreferences.remove(title);
      } else {
        _selectedPreferences.add(title);
      }
    });
  }

  // --- Grid Item Builder ---
  Widget _buildGridTile(ExerciseOption option) {
    final bool isSelected = _selectedPreferences.contains(option.title);

    return InkWell(
      onTap: () => _toggleSelection(option.title),
      child: Container(
        decoration: BoxDecoration(
          color: isSelected ? primaryColor.withValues(alpha: 0.2) : tileColor,
          borderRadius: BorderRadius.circular(16.0),
          border: Border.all(
            color: isSelected ? primaryColor : Colors.transparent,
            width: 2.0,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              option.icon,
              size: 40,
              color: isSelected ? primaryColor : unselectedIconColor,
            ),
            const SizedBox(height: 8),
            Text(
              option.title,
              style: TextStyle(
                color: isSelected ? primaryColor : Colors.white,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                fontSize: 14,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final bool isButtonEnabled = _selectedPreferences.isNotEmpty;

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: const OnboardingAppBar(
        currentStep: 10,
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
                "Do you have a specific Exercise Preference?",
                style: theme.textTheme.headlineMedium?.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.w800,
                ),
              ),
              const SizedBox(height: 30),

              // Exercise Selection Grid (3x3 layout)
              Expanded(
                child: GridView.builder(
                  shrinkWrap: true,
                  physics:
                      const NeverScrollableScrollPhysics(), // Grid fits, no need to scroll
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    crossAxisSpacing: 10.0,
                    mainAxisSpacing: 10.0,
                    childAspectRatio: 1.0, // Square tiles
                  ),
                  itemCount: exerciseOptions.length,
                  itemBuilder: (context, index) {
                    return _buildGridTile(exerciseOptions[index]);
                  },
                ),
              ),

              const SizedBox(height: 20),

              // Continue Button
              ContinueButton(
                onPressed: isButtonEnabled
                    ? () {
                        final updatedProfile = FitnessProfileModel(
                          uid: widget.profile.uid,
                          primaryGoal: widget.profile.primaryGoal,
                          gender: widget.profile.gender,
                          currentWeightKg: widget.profile.currentWeightKg,
                          age: widget.profile.age,
                          experience: widget.profile.experience,
                          fitnessLevel: widget.profile.fitnessLevel,
                          physicalLimitations:
                              widget.profile.physicalLimitations,
                          dietPreference: widget.profile.dietPreference,
                          workoutsPerWeek: widget.profile.workoutsPerWeek,
                          workoutPreferences: _selectedPreferences,
                          heightCm: widget.profile.heightCm,
                          isTakingSupplements:
                              widget.profile.isTakingSupplements,
                          sleepQuality: widget.profile.sleepQuality,
                          calorieGoal: 0,
                          calorieUnit: 'Kcal',
                        );

                        context.router
                            .push(SupplementsRoute(profile: updatedProfile));
                      }
                    : null,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
