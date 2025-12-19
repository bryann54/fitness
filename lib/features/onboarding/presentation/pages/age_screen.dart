// lib/features/onboarding/presentation/pages/age_screen.dart

import 'package:auto_route/auto_route.dart';
import 'package:fitness/common/helpers/app_router.gr.dart';
import 'package:fitness/features/onboarding/presentation/widgets/continue_button.dart';
import 'package:fitness/features/onboarding/presentation/widgets/onboarding_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:fitness/features/onboarding/data/models/fitness_profile_model.dart';
import 'package:fitness/common/res/colors.dart';
import 'package:flutter_animate/flutter_animate.dart'; // <--- NEW IMPORT
// <--- NEW IMPORT

@RoutePage()
class AgeScreen extends StatefulWidget {
  final FitnessProfileModel profile;
  const AgeScreen({super.key, required this.profile});

  @override
  State<AgeScreen> createState() => _AgeScreenState();
}

class _AgeScreenState extends State<AgeScreen> {
  static const int minAge = 16;
  static const int maxAge = 100;
  late int _selectedAge;

  @override
  void initState() {
    super.initState();
    _selectedAge = widget.profile.age > minAge ? widget.profile.age : 18;
  }

  Widget _buildAgeItem(BuildContext context, int index) {
    final age = minAge + index;
    final isSelected = age == _selectedAge;

    final fontSize = isSelected ? 80.0 : 40.0;
    final fontWeight = isSelected ? FontWeight.w900 : FontWeight.normal;
    final color = isSelected ? AppColors.textAccent : AppColors.textOnPrimary;

    return Center(
      child: Container(
        width: isSelected ? 200 : null,
        height: isSelected ? 100 : null,
        decoration: isSelected
            ? BoxDecoration(
                color: AppColors.primary,
                borderRadius: BorderRadius.circular(20),
              )
            : null,
        alignment: Alignment.center,
        child: Text(
          age.toString(),
          style: TextStyle(
            color: color,
            fontSize: fontSize,
            fontWeight: fontWeight,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final itemExtent = 100.0;
    final itemCount = maxAge - minAge + 1;
    final initialIndex = _selectedAge - minAge;

    return Scaffold(
      backgroundColor: AppColors.backgroundDark,
      appBar: const OnboardingAppBar(
        currentStep: 4,
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
                "What is your age?",
                style: theme.textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.w800,
                ),
              ).animate(
                effects: [FadeEffect(), SlideEffect()],
              ),
              const SizedBox(height: 30),
              Expanded(
                child: ListWheelScrollView.useDelegate(
                  itemExtent: itemExtent,
                  diameterRatio: 1.5,
                  perspective: 0.003,
                  physics: const FixedExtentScrollPhysics(),
                  onSelectedItemChanged: (index) {
                    setState(() {
                      _selectedAge = minAge + index;
                    });
                  },
                  childDelegate: ListWheelChildBuilderDelegate(
                    builder: (context, index) {
                      if (index < 0 || index >= itemCount) {
                        return null;
                      }
                      return _buildAgeItem(context, index)
                          .animate()
                          .fadeIn(duration: 600.ms, delay: 400.ms)
                          .slideX(
                            begin: -0.5,
                            end: 0,
                            duration: 600.ms,
                            delay: 200.ms,
                            curve: Curves.easeOut,
                          );
                    },
                    childCount: itemCount,
                  ),
                  controller:
                      FixedExtentScrollController(initialItem: initialIndex),
                ),
              ),
              const SizedBox(height: 20),
              ContinueButton(
                onPressed: () {
                  final updatedProfile = FitnessProfileModel(
                    uid: widget.profile.uid,
                    primaryGoal: widget.profile.primaryGoal,
                    gender: widget.profile.gender,
                    currentWeightKg: widget.profile.currentWeightKg,
                    age: _selectedAge,
                    heightCm: widget.profile.heightCm,
                    experience: widget.profile.experience,
                    fitnessLevel: widget.profile.fitnessLevel,
                    workoutsPerWeek: widget.profile.workoutsPerWeek,
                    isTakingSupplements: widget.profile.isTakingSupplements,
                    dietPreference: widget.profile.dietPreference,
                    workoutPreferences: widget.profile.workoutPreferences,
                    sleepQuality: widget.profile.sleepQuality,
                    physicalLimitations: widget.profile.physicalLimitations,
                    calorieGoal: widget.profile.calorieGoal,
                    calorieUnit: widget.profile.calorieUnit,
                  );

                  context.router.push(ExperienceRoute(profile: updatedProfile));
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
