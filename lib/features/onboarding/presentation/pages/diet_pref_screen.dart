// lib/features/onboarding/presentation/pages/diet_pref_screen.dart

import 'package:auto_route/auto_route.dart';
import 'package:fitness/features/onboarding/presentation/widgets/onboarding_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:fitness/common/helpers/app_router.gr.dart';
import 'package:fitness/features/onboarding/data/models/fitness_profile_model.dart';
import 'package:fitness/features/onboarding/presentation/widgets/continue_button.dart';
import 'package:fitness/common/res/colors.dart';
import 'package:fitness/features/onboarding/presentation/widgets/diet_preference_tile.dart';

@RoutePage()
class DietPrefScreen extends StatefulWidget {
  final FitnessProfileModel profile;
  const DietPrefScreen({super.key, required this.profile});

  @override
  State<DietPrefScreen> createState() => _DietPrefScreenState();
}

class DietPreference {
  final String title;
  final String subtitle;
  final IconData icon;

  const DietPreference(this.title, this.subtitle, this.icon);
}

// Add TickerProviderStateMixin for the AnimationController
class _DietPrefScreenState extends State<DietPrefScreen>
    with SingleTickerProviderStateMixin {
  // Animation variables
  late AnimationController _controller;
  late Animation<Offset> _slideAnimation;

  final List<DietPreference> dietOptions = [
    const DietPreference("Plant Based", "Vegan / Vegetarian", Icons.eco),
    const DietPreference(
        "Carbohydrate Cycle", "Bread, pasta, etc", Icons.bakery_dining),
    const DietPreference(
        "Specialized", "Paleo, Keto, Low Carb", Icons.restaurant_menu),
    const DietPreference(
        "Traditional / Standard", "Fruit, veggies, meats", Icons.local_dining),
  ];

  late String? _selectedDietTitle;

  @override
  void initState() {
    super.initState();

    // Initialize state from existing profile data
    _selectedDietTitle = widget.profile.dietPreference.isNotEmpty
        ? widget.profile.dietPreference
        : null;

    // Initialize Animation
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 700),
    );

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.2),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    ));

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: AppColors.backgroundDark,
      appBar: const OnboardingAppBar(
        currentStep: 8,
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
              SlideTransition(
                position: _slideAnimation,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Do you have a specific diet preference?",
                      style: theme.textTheme.headlineMedium?.copyWith(
                        color: AppColors.textPrimaryDark,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    const SizedBox(height: 30),
                    Column(
                      children: [
                        Row(
                          children: [
                            DietPreferenceTile(
                              title: dietOptions[0].title,
                              subtitle: dietOptions[0].subtitle,
                              icon: dietOptions[0].icon,
                              isSelected:
                                  _selectedDietTitle == dietOptions[0].title,
                              onTap: () => setState(() =>
                                  _selectedDietTitle = dietOptions[0].title),
                            ),
                            DietPreferenceTile(
                              title: dietOptions[1].title,
                              subtitle: dietOptions[1].subtitle,
                              icon: dietOptions[1].icon,
                              isSelected:
                                  _selectedDietTitle == dietOptions[1].title,
                              onTap: () => setState(() =>
                                  _selectedDietTitle = dietOptions[1].title),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            DietPreferenceTile(
                              title: dietOptions[2].title,
                              subtitle: dietOptions[2].subtitle,
                              icon: dietOptions[2].icon,
                              isSelected:
                                  _selectedDietTitle == dietOptions[2].title,
                              onTap: () => setState(() =>
                                  _selectedDietTitle = dietOptions[2].title),
                            ),
                            DietPreferenceTile(
                              title: dietOptions[3].title,
                              subtitle: dietOptions[3].subtitle,
                              icon: dietOptions[3].icon,
                              isSelected:
                                  _selectedDietTitle == dietOptions[3].title,
                              onTap: () => setState(() =>
                                  _selectedDietTitle = dietOptions[3].title),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              const Spacer(),

              // Continue Button
              ContinueButton(
                onPressed: _selectedDietTitle == null
                    ? null
                    : () {
                        final updatedProfile = FitnessProfileModel(
                          // Preserve existing fields
                          uid: widget.profile.uid,
                          primaryGoal: widget.profile.primaryGoal,
                          gender: widget.profile.gender,
                          currentWeightKg: widget.profile.currentWeightKg,
                          age: widget.profile.age,
                          experience: widget.profile.experience,
                          fitnessLevel: widget.profile.fitnessLevel,
                          physicalLimitations:
                              widget.profile.physicalLimitations,
                          heightCm: widget.profile.heightCm,
                          workoutsPerWeek: widget.profile.workoutsPerWeek,
                          isTakingSupplements:
                              widget.profile.isTakingSupplements,
                          workoutPreferences: widget.profile.workoutPreferences,
                          sleepQuality: widget.profile.sleepQuality,
                          calorieGoal: widget.profile.calorieGoal,
                          calorieUnit: widget.profile.calorieUnit,

                          // --- FIELD UPDATED HERE ---
                          dietPreference: _selectedDietTitle!,
                        );

                        context.router.push(
                            WorkoutsPerWeekRoute(profile: updatedProfile));
                      },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
