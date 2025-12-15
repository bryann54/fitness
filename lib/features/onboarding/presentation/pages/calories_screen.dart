// lib/features/onboarding/presentation/pages/calories_screen.dart

import 'package:auto_route/auto_route.dart';
import 'package:fitness/features/onboarding/presentation/widgets/onboarding_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:fitness/common/helpers/app_router.gr.dart';
import 'package:fitness/features/onboarding/data/models/fitness_profile_model.dart';
import 'package:fitness/features/onboarding/presentation/widgets/continue_button.dart';
import 'package:fitness/common/res/colors.dart'; // <--- NEW IMPORT

@RoutePage()
class CaloriesScreen extends StatefulWidget {
  // CRITICAL: Profile model must be carried forward
  final FitnessProfileModel profile;
  const CaloriesScreen({super.key, required this.profile});

  @override
  State<CaloriesScreen> createState() => _CaloriesScreenState();
}

class _CaloriesScreenState extends State<CaloriesScreen> {
  // State for calorie tracking
  late int _calorieGoal;
  late String _unit;
  final int _step = 50; // Increment/decrement step

  @override
  void initState() {
    super.initState();
    // Initialize state from existing profile data if available
    _calorieGoal =
        widget.profile.calorieGoal > 0 ? widget.profile.calorieGoal : 1550;
    _unit = widget.profile.calorieUnit.isNotEmpty
        ? widget.profile.calorieUnit
        : 'Kcal';
  }

  // --- Logic for Increment/Decrement ---
  void _changeGoal(int change) {
    setState(() {
      _calorieGoal =
          (_calorieGoal + change).clamp(1000, 5000); // Set reasonable limits
    });
  }

  // --- Segmented Unit Control (Refactored Colors) ---
  Widget _buildUnitToggle() {
    return Container(
      width: 250,
      decoration: BoxDecoration(
        color: AppColors.cardDark, // Refactored
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: ['Kcal', 'Joule\'s'].map((unit) {
          final isSelected = _unit == unit;
          return Expanded(
            child: InkWell(
              onTap: () {
                setState(() {
                  _unit = unit;
                });
              },
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 10.0),
                decoration: BoxDecoration(
                  color: isSelected
                      ? AppColors.textPrimary
                      : Colors.transparent, // Refactored (White when selected)
                  borderRadius: BorderRadius.circular(12.0),
                ),
                child: Center(
                  child: Text(
                    unit,
                    style: TextStyle(
                      color: isSelected
                          ? AppColors.textAccent
                          : AppColors.textSecondary, // Refactored
                      fontWeight:
                          isSelected ? FontWeight.bold : FontWeight.normal,
                    ),
                  ),
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  // --- Plus/Minus Button (Refactored Colors) ---
  Widget _buildControlButton(
      {required IconData icon,
      required VoidCallback onPressed,
      required bool isPrimary}) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: ElevatedButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
            backgroundColor: isPrimary
                ? AppColors.primary
                : AppColors.cardDark, // Refactored
            padding: const EdgeInsets.symmetric(vertical: 20.0),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16.0),
            ),
            elevation: 0,
          ),
          child: Icon(
            icon,
            size: 32,
            color: isPrimary
                ? AppColors.textAccent
                : AppColors.textOnPrimary, // Refactored
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: AppColors.backgroundDark, // Refactored
      appBar: const OnboardingAppBar(
        currentStep: 13,
        totalSteps: 17,
        isInitial: false,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 10),
              // Question Text (Left Aligned)
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "What's Your Calorie Goal per Day?",
                  style: theme.textTheme.headlineMedium?.copyWith(
                    color: AppColors.textPrimary, // Refactored
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),

              const Spacer(),

              // Unit Toggle
              _buildUnitToggle(),

              const Spacer(),

              // Large Numeric Display
              Text(
                _calorieGoal.toString(),
                style: const TextStyle(
                  color: AppColors.textPrimary, // Refactored
                  fontSize: 100,
                  fontWeight: FontWeight.w900,
                  height: 1.0,
                ),
              ),
              Text(
                'calories daily',
                style: theme.textTheme.titleMedium?.copyWith(
                  color: AppColors.textSecondary, // Refactored
                ),
              ),

              const Spacer(),
              const Spacer(),

              // Plus/Minus Buttons
              Row(
                children: [
                  _buildControlButton(
                    icon: Icons.remove,
                    onPressed: () => _changeGoal(-_step),
                    isPrimary: false,
                  ),
                  _buildControlButton(
                    icon: Icons.add,
                    onPressed: () => _changeGoal(_step),
                    isPrimary: true,
                  ),
                ],
              ),

              const SizedBox(height: 30),

              // Continue Button
              ContinueButton(
                onPressed: () {
                  final updatedProfile = FitnessProfileModel(
                    // Preserve existing fields
                    uid: widget.profile.uid,
                    primaryGoal: widget.profile.primaryGoal,
                    gender: widget.profile.gender,
                    currentWeightKg: widget.profile.currentWeightKg,
                    age: widget.profile.age,
                    experience: widget.profile.experience,
                    fitnessLevel: widget.profile.fitnessLevel,
                    physicalLimitations: widget.profile.physicalLimitations,
                    dietPreference: widget.profile.dietPreference,
                    workoutsPerWeek: widget.profile.workoutsPerWeek,
                    workoutPreferences: widget.profile.workoutPreferences,
                    isTakingSupplements: widget.profile.isTakingSupplements,
                    supplementsTaken: widget.profile.supplementsTaken,
                    sleepQuality: widget.profile.sleepQuality,
                    heightCm: widget.profile.heightCm,

                    calorieGoal: _calorieGoal,
                    calorieUnit: _unit,
                  );

                  context.router
                      .push(SleepQualityRoute(profile: updatedProfile));
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
