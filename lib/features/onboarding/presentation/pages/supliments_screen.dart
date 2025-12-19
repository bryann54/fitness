// lib/features/onboarding/presentation/pages/supplements_screen.dart

import 'package:auto_route/auto_route.dart';
import 'package:fitness/common/res/colors.dart';
import 'package:fitness/features/onboarding/presentation/widgets/onboarding_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:fitness/common/helpers/app_router.gr.dart';
import 'package:fitness/features/onboarding/data/models/fitness_profile_model.dart';
import 'package:fitness/features/onboarding/presentation/widgets/continue_button.dart';
import 'package:flutter_animate/flutter_animate.dart';

@RoutePage()
class SupplementsScreen extends StatefulWidget {
  final FitnessProfileModel profile;
  const SupplementsScreen({super.key, required this.profile});

  @override
  State<SupplementsScreen> createState() => _SupplementsScreenState();
}

class _SupplementsScreenState extends State<SupplementsScreen>
    with SingleTickerProviderStateMixin {
  // Animation variables
  late AnimationController _controller;
  late Animation<Offset> _slideAnimation;
  late Animation<double> _opacityAnimation;

  bool? _isTakingSupplements;

  @override
  void initState() {
    super.initState();
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

  Widget _buildSelectionButton({required String label, required bool value}) {
    final bool isSelected = _isTakingSupplements == value;

    final Color buttonColor =
        isSelected ? AppColors.accent : AppColors.cardDark;
    final Color textColor =
        isSelected ? AppColors.textAccent : AppColors.textOnPrimary;
    final IconData icon = value ? Icons.check : Icons.close;
    final Color iconColor =
        isSelected ? AppColors.textAccent : AppColors.textOnPrimary;
    final Color borderColor =
        isSelected ? AppColors.accent : Colors.transparent;

    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: InkWell(
          onTap: () {
            setState(() {
              _isTakingSupplements = value;
            });
          },
          child: Container(
            height: 60,
            decoration: BoxDecoration(
              color: buttonColor,
              borderRadius: BorderRadius.circular(12.0),
              border: Border.all(color: borderColor, width: 2),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  label,
                  style: TextStyle(
                    color: textColor,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(width: 8),
                Icon(
                  icon,
                  color: iconColor,
                  size: 20,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Refactored navigation logic
  void _navigateToNextScreen() {
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
      workoutsPerWeek: widget.profile.workoutsPerWeek,
      workoutPreferences: widget.profile.workoutPreferences,
      heightCm: widget.profile.heightCm,
      sleepQuality: widget.profile.sleepQuality,
      calorieGoal: widget.profile.calorieGoal,
      calorieUnit: widget.profile.calorieUnit,
      isTakingSupplements: _isTakingSupplements!,
      supplementsTaken:
          _isTakingSupplements! ? widget.profile.supplementsTaken : <String>[],
    );

    if (_isTakingSupplements!) {
      context.router.push(SpecificSuppRoute(profile: updatedProfile));
    } else {
      context.router.push(CaloriesRoute(profile: updatedProfile));
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final bool isButtonEnabled = _isTakingSupplements != null;

    return Scaffold(
      backgroundColor: AppColors.backgroundDark,
      appBar: const OnboardingAppBar(
        currentStep: 11,
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

              // Animated Content
              FadeTransition(
                opacity: _opacityAnimation,
                child: SlideTransition(
                  position: _slideAnimation,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Are you taking any supplements?",
                        style: theme.textTheme.headlineMedium?.copyWith(
                          fontWeight: FontWeight.w800,
                        ),
                      ),

                      const SizedBox(height: 50),

                      // Image
                      Center(
                        child: Image.asset(
                          'assets/supps.png',
                          height: 250,
                          errorBuilder: (context, error, stackTrace) =>
                              Container(
                            height: 250,
                            color: AppColors.cardDark,
                            alignment: Alignment.center,
                            child: const Text('Supplements Image',
                                style:
                                    TextStyle(color: AppColors.textSecondary)),
                          ),
                        ),
                      ),

                      const SizedBox(height: 0),
                    ],
                  ),
                ),
              ),

              const Spacer(),
              Row(
                children: [
                  _buildSelectionButton(label: "No", value: false).animate(
                    effects: [
                      FadeEffect(delay: 100.ms, duration: 500.ms),
                      SlideEffect(
                        delay: 100.ms,
                        duration: 500.ms,
                        begin: const Offset(-0.5, 0),
                        end: const Offset(0, 0),
                      ),
                    ],
                  ),
                  _buildSelectionButton(label: "Yes", value: true).animate(
                    effects: [
                      FadeEffect(delay: 200.ms, duration: 500.ms),
                      SlideEffect(
                        delay: 200.ms,
                        duration: 500.ms,
                        begin: const Offset(0.5, 0),
                        end: const Offset(0, 0),
                      ),
                    ],
                  ),
                ],
              ),

              const SizedBox(height: 20),
              ContinueButton(
                onPressed: isButtonEnabled ? _navigateToNextScreen : null,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
