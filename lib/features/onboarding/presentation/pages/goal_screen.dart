// lib/features/onboarding/presentation/pages/goal_screen.dart

import 'package:auto_route/auto_route.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fitness/common/res/colors.dart';
import 'package:fitness/features/onboarding/presentation/widgets/continue_button.dart';
import 'package:fitness/features/onboarding/presentation/widgets/onboarding_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:fitness/common/helpers/app_router.gr.dart';
import 'package:fitness/features/onboarding/data/models/fitness_profile_model.dart';
import 'package:flutter_animate/flutter_animate.dart';

// Data Structure (linked to the FitnessGoal enum)
class GoalOption {
  final String title;
  final IconData icon;
  final FitnessGoal goalEnum;

  GoalOption(this.title, this.icon, this.goalEnum);
}

@RoutePage()
class GoalScreen extends StatefulWidget {
  const GoalScreen({super.key});

  @override
  State<GoalScreen> createState() => _GoalScreenState();
}

class _GoalScreenState extends State<GoalScreen> {
  final List<GoalOption> goals = [
    GoalOption("I want to lose weight", Icons.sentiment_neutral_outlined,
        FitnessGoal.loseWeight),
    GoalOption("I want to get bulk", Icons.fitness_center_outlined,
        FitnessGoal.gainMuscle),
    GoalOption("I want to gain endurance", Icons.show_chart_outlined,
        FitnessGoal.improveEndurance),
    GoalOption("I want to maintain my current fitness", Icons.favorite_outline,
        FitnessGoal.maintenance),
    GoalOption("I want to try AI Coach",
        Icons.sentiment_very_satisfied_outlined, FitnessGoal.gainMuscle),
  ];

  GoalOption? _selectedGoal;

  Widget _buildGoalTile(GoalOption goal) {
    final bool isSelected = _selectedGoal == goal;
    const Color primaryColor = Colors.teal;
    const Color darkTileColor = Color.fromARGB(255, 30, 30, 30);

    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: InkWell(
        onTap: () {
          setState(() {
            _selectedGoal = goal;
          });
        },
        child: Container(
          decoration: BoxDecoration(
            color: darkTileColor,
            borderRadius: BorderRadius.circular(16.0),
            border: Border.all(
              color: isSelected ? primaryColor : darkTileColor,
              width: 2.0,
            ),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 18.0),
          child: Row(
            children: [
              Icon(
                goal.icon,
                color: isSelected
                    ? primaryColor
                    : AppColors.visualLightBackgroundHalf
                        .withValues(alpha: 0.2),
              ),
              const SizedBox(width: 16.0),
              Expanded(
                child: Text(
                  goal.title,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        color: AppColors.visualLightBackgroundHalf,
                        fontWeight: FontWeight.w500,
                      ),
                ),
              ),
              Container(
                width: 24,
                height: 24,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: isSelected ? primaryColor : Colors.transparent,
                  border: Border.all(
                    color: isSelected
                        ? primaryColor
                        : AppColors.visualLightBackgroundHalf,
                    width: 2,
                  ),
                ),
                child: isSelected
                    ? const Icon(
                        Icons.check,
                        size: 16,
                        color: AppColors.cardDark,
                      )
                    : null,
              ),
            ],
          ),
        )
            .animate(
              delay: 100.ms,
            )
            .fadeIn(duration: 600.ms, curve: Curves.easeOut)
            .slideX(
                begin: 0.2, end: 0, duration: 600.ms, curve: Curves.easeOut),
      ),
    );
  }

  void _handleContinue() {
    if (_selectedGoal == null) return;

    // Get current user's UID
    final currentUser = FirebaseAuth.instance.currentUser;

    if (currentUser == null) {
      // User is not authenticated - show error and potentially navigate to login
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please sign in to continue with onboarding'),
          backgroundColor: AppColors.error,
        ),
      );
      // Optionally navigate to login screen
      // context.router.push(const LoginRoute());
      return;
    }

    // Create initial profile with user's UID
    final initialProfile = FitnessProfileModel(
      uid: currentUser.uid, // ✅ Use authenticated user's UID
      primaryGoal: _selectedGoal!.goalEnum,
      gender: '',
      age: 0,
      currentWeightKg: 0,
      heightCm: 0,
      experience: WorkoutExperience.never,
      fitnessLevel: '',
      workoutsPerWeek: 0,
      isTakingSupplements: false,
      dietPreference: '',
      workoutPreferences: [],
      sleepQuality: SleepQuality.poor,
      physicalLimitations: null,
      calorieGoal: 0,
      calorieUnit: 'Kcal',
    );

    context.router.push(GenderRoute(profile: initialProfile));
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: AppColors.cardDark,
      appBar: const OnboardingAppBar(
        currentStep: 1,
        totalSteps: 17,
        isInitial: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 10),
              Text(
                "What's your fitness goal/target?",
                style: theme.textTheme.headlineMedium?.copyWith(
                  color: AppColors.visualLightBackgroundHalf,
                  fontWeight: FontWeight.w800,
                ),
              )
                  .animate(
                    delay: 100.ms,
                  )
                  .fadeIn(duration: 600.ms, curve: Curves.easeOut)
                  .slideX(
                      begin: 0.2,
                      end: 0,
                      duration: 600.ms,
                      curve: Curves.easeOut),
              const SizedBox(height: 30),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children:
                        goals.map((goal) => _buildGoalTile(goal)).toList(),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              ContinueButton(
                onPressed: _selectedGoal == null ? null : _handleContinue,
              )
                  .animate(
                    delay: 500.ms,
                  )
                  .fadeIn(duration: 600.ms, curve: Curves.easeOut)
                  .slideX(
                      begin: 0.2,
                      end: 0,
                      duration: 600.ms,
                      curve: Curves.easeOut),
            ],
          ),
        ),
      ),
    );
  }
}
