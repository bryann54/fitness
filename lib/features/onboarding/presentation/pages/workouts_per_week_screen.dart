// lib/features/onboarding/presentation/pages/workouts_per_week_screen.dart

import 'package:auto_route/auto_route.dart';
import 'package:fitness/features/onboarding/presentation/widgets/onboarding_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:fitness/common/helpers/app_router.gr.dart';
import 'package:fitness/features/onboarding/data/models/fitness_profile_model.dart';
import 'package:fitness/features/onboarding/presentation/widgets/continue_button.dart';

@RoutePage()
class WorkoutsPerWeekScreen extends StatefulWidget {
  final FitnessProfileModel profile;

  const WorkoutsPerWeekScreen({super.key, required this.profile});

  @override
  State<WorkoutsPerWeekScreen> createState() => _WorkoutsPerWeekScreenState();
}

class _WorkoutsPerWeekScreenState extends State<WorkoutsPerWeekScreen> {
  // Days range from 1 to 5 as shown in the design
  static const List<int> availableDays = [1, 2, 3, 4, 5];

  // Default to 5x as shown in the screenshot
  late int _selectedDays;

  static const Color primaryColor = Color(0xFFFF9800);
  static const Color unselectedColor = Color(0xFF1E1E1E);

  @override
  void initState() {
    super.initState();
    _selectedDays = 5;
  }

  // --- Button Builder for the horizontal selector (1, 2, 3, 4, 5) ---
  Widget _buildDayButton(int day) {
    final isSelected = day == _selectedDays;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 6.0),
      child: MaterialButton(
        minWidth: 50, // Fixed width for consistent look
        height: 50, // Fixed height
        padding: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
        color: isSelected ? primaryColor : unselectedColor,
        elevation: 0,
        highlightElevation: 0,
        onPressed: () {
          setState(() {
            _selectedDays = day;
          });
        },
        child: Text(
          '$day',
          style: TextStyle(
            color: isSelected ? Colors.black : Colors.white70,
            fontSize: 18,
            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    // Determine the next route based on the established flow (likely Height/Workouts/Supplements)
    // We will assume the next logical step after this screen is where workouts are set.
    // For now, we will use a placeholder route/logic for the next screen.
    final nextRoute = WorkoutsPerWeekRoute(
        profile: widget
            .profile); // Placeholder: Replace with actual next screen route

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: const OnboardingAppBar(
        currentStep: 9,
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

              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "How many days/wk will you commit?",
                  style: theme.textTheme.headlineMedium?.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),

              const Spacer(),

              // Large Central Number (5x)
              Text(
                '${_selectedDays}x',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 180,
                  fontWeight: FontWeight.w900,
                  height: 0.8, // Adjust line height
                ),
              ),

              const Spacer(),

              // Horizontal Day Selector
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children:
                    availableDays.map((day) => _buildDayButton(day)).toList(),
              ),

              const SizedBox(height: 20),

              // Dynamic Commitment Text
              Text(
                "I'm committed to exercising ${_selectedDays}x weekly",
                style: theme.textTheme.titleMedium?.copyWith(
                  color: Colors.white70,
                ),
              ),

              const Spacer(),

              // Continue Button
              ContinueButton(
                onPressed: () {
                  final updatedProfile = FitnessProfileModel(
                    uid: widget.profile.uid,
                    primaryGoal: widget.profile.primaryGoal,
                    gender: widget.profile.gender,
                    currentWeightKg: widget.profile.currentWeightKg,
                    age: widget.profile.age,
                    experience: widget.profile.experience,
                    fitnessLevel: widget.profile.fitnessLevel,
                    physicalLimitations: widget.profile.physicalLimitations,
                    dietPreference: widget.profile.dietPreference,

                    // --- FIELD UPDATED IN THIS SCREEN ---
                    workoutsPerWeek: _selectedDays,
                    calorieGoal: 0,
                    calorieUnit: 'Kcal',
                    heightCm: widget.profile.heightCm,
                    isTakingSupplements: widget.profile.isTakingSupplements,
                    workoutPreferences: widget.profile.workoutPreferences,
                    sleepQuality: widget.profile.sleepQuality,
                  );

                  context.router
                      .push(ExercisePrefRoute(profile: updatedProfile));
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
