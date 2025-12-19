// lib/features/onboarding/presentation/pages/exercise_pref_screen.dart

import 'package:auto_route/auto_route.dart';
import 'package:fitness/features/onboarding/presentation/widgets/onboarding_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:fitness/common/helpers/app_router.gr.dart';
import 'package:fitness/features/onboarding/data/models/fitness_profile_model.dart';
import 'package:fitness/features/onboarding/presentation/widgets/continue_button.dart';
import 'package:fitness/common/res/colors.dart'; // Import AppColors
import 'package:fitness/features/onboarding/presentation/widgets/exercise_grid_tile.dart'; // NEW IMPORT

// Data structure for the exercise options
class ExerciseOption {
  final String title;
  final IconData icon;

  const ExerciseOption(this.title, this.icon);
}

@RoutePage()
class ExercisePrefScreen extends StatefulWidget {
  final FitnessProfileModel profile;
  const ExercisePrefScreen({super.key, required this.profile});

  @override
  State<ExercisePrefScreen> createState() => _ExercisePrefScreenState();
}

class _ExercisePrefScreenState extends State<ExercisePrefScreen>
    with SingleTickerProviderStateMixin {
  // ADD MIXIN FOR ANIMATION

  // Animation variables
  late AnimationController _controller;
  late Animation<Offset> _slideAnimation;
  late Animation<double> _opacityAnimation;

  // List of exercise options matching the 3x3 grid
  final List<ExerciseOption> exerciseOptions = [
    const ExerciseOption("Jogging", Icons.directions_run),
    const ExerciseOption("Walking", Icons.directions_walk),
    const ExerciseOption("Hiking", Icons.hiking),
    const ExerciseOption("Skating", Icons.ice_skating),
    const ExerciseOption("Biking", Icons.directions_bike),
    const ExerciseOption("Weightlift", Icons.fitness_center),
    const ExerciseOption("Cardio", Icons.monitor_heart),
    const ExerciseOption("Yoga", Icons.self_improvement),
    const ExerciseOption("Other", Icons.settings),
  ];

  // List to hold the titles of selected options
  late List<String> _selectedPreferences;

  @override
  void initState() {
    super.initState();
    // Initialize state from profile data or default to empty list
    _selectedPreferences = widget.profile.workoutPreferences.isNotEmpty
        ? List.from(widget.profile.workoutPreferences)
        : [];

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

  // _buildGridTile is replaced by ExerciseGridTile widget

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final bool isButtonEnabled = _selectedPreferences.isNotEmpty;

    return Scaffold(
      backgroundColor: AppColors.backgroundDark, // Refactored
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

              // Animated Content Wrapper
              FadeTransition(
                opacity: _opacityAnimation,
                child: SlideTransition(
                  position: _slideAnimation,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Do you have a specific Exercise Preference?",
                        style: theme.textTheme.headlineMedium?.copyWith(
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      const SizedBox(height: 30),
                      SizedBox(
                        height: (MediaQuery.of(context).size.width - 40 - 20) /
                                3 *
                                3 +
                            20,
                        child: GridView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3,
                            crossAxisSpacing: 10.0,
                            mainAxisSpacing: 10.0,
                            childAspectRatio: 1.0,
                          ),
                          itemCount: exerciseOptions.length,
                          itemBuilder: (context, index) {
                            final option = exerciseOptions[index];
                            return ExerciseGridTile(
                              title: option.title,
                              icon: option.icon,
                              isSelected:
                                  _selectedPreferences.contains(option.title),
                              onTap: () => _toggleSelection(option.title),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              const Spacer(),
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
                          heightCm: widget.profile.heightCm,
                          isTakingSupplements:
                              widget.profile.isTakingSupplements,
                          sleepQuality: widget.profile.sleepQuality,
                          calorieGoal: widget.profile.calorieGoal,
                          calorieUnit: widget.profile.calorieUnit,
                          workoutPreferences: _selectedPreferences,
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
