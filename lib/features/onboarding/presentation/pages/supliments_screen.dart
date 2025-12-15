// lib/features/onboarding/presentation/pages/supplements_screen.dart

import 'package:auto_route/auto_route.dart';
import 'package:fitness/features/onboarding/presentation/widgets/onboarding_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:fitness/common/helpers/app_router.gr.dart';
import 'package:fitness/features/onboarding/data/models/fitness_profile_model.dart';
import 'package:fitness/features/onboarding/presentation/widgets/continue_button.dart';

@RoutePage()
class SupplementsScreen extends StatefulWidget {
  final FitnessProfileModel profile;
  const SupplementsScreen({super.key, required this.profile});

  @override
  State<SupplementsScreen> createState() => _SupplementsScreenState();
}

class _SupplementsScreenState extends State<SupplementsScreen> {
  static const Color primaryColor = Color(0xFFFF9800);

  bool? _isTakingSupplements;
  Widget _buildSelectionButton({required String label, required bool value}) {
    final bool isSelected = _isTakingSupplements == value;
    final Color buttonColor =
        isSelected ? primaryColor : const Color(0xFF2C2C2C);
    final Color textColor = isSelected ? Colors.black : Colors.white;
    final IconData icon = isSelected ? Icons.check : Icons.close;
    final Color iconColor = isSelected ? Colors.black : Colors.white60;

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
              border: isSelected
                  ? Border.all(color: primaryColor, width: 2)
                  : Border.all(color: Colors.transparent),
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

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final bool isButtonEnabled = _isTakingSupplements != null;

    return Scaffold(
      backgroundColor: Colors.black,
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
              Text(
                "Are you taking any supplements?",
                style: theme.textTheme.headlineMedium?.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.w800,
                ),
              ),

              const Spacer(),

              Center(
                child: Image.asset(
                  'assets/supps.webp',
                  height: 250,
                ),
              ),

              const Spacer(),
              const Spacer(),
              Row(
                children: [
                  _buildSelectionButton(label: "No", value: false),
                  _buildSelectionButton(label: "Yes", value: true),
                ],
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
                          workoutPreferences: widget.profile.workoutPreferences,
                          calorieGoal: 0,
                          calorieUnit: 'Kcal',
                          isTakingSupplements: _isTakingSupplements!,
                          heightCm: widget.profile.heightCm,
                          sleepQuality: widget.profile.sleepQuality,
                        );

                        context.router
                            .push(SpecificSuppRoute(profile: updatedProfile));
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
