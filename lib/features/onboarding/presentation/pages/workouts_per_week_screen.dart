// lib/features/onboarding/presentation/pages/workouts_per_week_screen.dart

import 'package:auto_route/auto_route.dart';
import 'package:fitness/features/onboarding/presentation/widgets/onboarding_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:fitness/common/helpers/app_router.gr.dart';
import 'package:fitness/features/onboarding/data/models/fitness_profile_model.dart';
import 'package:fitness/features/onboarding/presentation/widgets/continue_button.dart';
import 'package:fitness/common/res/colors.dart'; // Import AppColors

@RoutePage()
class WorkoutsPerWeekScreen extends StatefulWidget {
  final FitnessProfileModel profile;

  const WorkoutsPerWeekScreen({super.key, required this.profile});

  @override
  State<WorkoutsPerWeekScreen> createState() => _WorkoutsPerWeekScreenState();
}

class _WorkoutsPerWeekScreenState extends State<WorkoutsPerWeekScreen>
    with SingleTickerProviderStateMixin {
  // ADD MIXIN FOR ANIMATION

  // Animation variables
  late AnimationController _controller;
  late Animation<Offset> _slideAnimation;
  late Animation<double> _opacityAnimation;

  // Days range from 1 to 5 as shown in the design
  static const List<int> availableDays = [1, 2, 3, 4, 5];

  late int _selectedDays;

  @override
  void initState() {
    super.initState();
    _selectedDays = widget.profile.workoutsPerWeek > 0
        ? widget.profile.workoutsPerWeek
        : 5; // Use profile data or default to 5

    // Initialize Animation
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 700),
    );

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.2), // Start slightly below
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    ));

    _opacityAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeIn,
      ),
    );

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  // --- Button Builder for the horizontal selector (1, 2, 3, 4, 5) ---
  Widget _buildDayButton(int day) {
    final isSelected = day == _selectedDays;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 6.0),
      child: MaterialButton(
        minWidth: 50,
        height: 50,
        padding: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
        color:
            isSelected ? AppColors.primary : AppColors.cardDark, // Refactored
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
            color: isSelected
                ? AppColors.textAccent
                : AppColors.textSecondary, // Refactored
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

    return Scaffold(
      backgroundColor: AppColors.backgroundDark, // Refactored
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

              // Animated Content Wrapper
              FadeTransition(
                opacity: _opacityAnimation,
                child: SlideTransition(
                  position: _slideAnimation,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "How many days/wk will you commit?",
                          style: theme.textTheme.headlineMedium?.copyWith(
                            color: AppColors.textOnPrimary,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                      ),
                      const SizedBox(height: 120),
                      Text(
                        '${_selectedDays}x',
                        style: const TextStyle(
                          color: AppColors.cardLight,
                          fontSize: 180,
                          fontWeight: FontWeight.w900,
                          height: 0.8,
                        ),
                      ),
                      const SizedBox(height: 80),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: availableDays
                            .map((day) => _buildDayButton(day))
                            .toList(),
                      ),
                      const SizedBox(height: 20),
                      Text(
                        "I'm committed to exercising ${_selectedDays}x weekly",
                        style: theme.textTheme.titleMedium?.copyWith(
                          color: AppColors.textSecondary, // Refactored
                        ),
                      ),
                    ],
                  ),
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
                    heightCm: widget.profile.heightCm,
                    isTakingSupplements: widget.profile.isTakingSupplements,
                    workoutPreferences: widget.profile.workoutPreferences,
                    sleepQuality: widget.profile.sleepQuality,
                    calorieGoal: widget.profile.calorieGoal,
                    calorieUnit: widget.profile.calorieUnit,
                    workoutsPerWeek: _selectedDays,
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
