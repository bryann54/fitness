// lib/features/onboarding/presentation/pages/gender_screen.dart

import 'package:auto_route/auto_route.dart';
import 'package:fitness/common/res/colors.dart';
import 'package:fitness/features/onboarding/presentation/widgets/onboarding_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:fitness/common/helpers/app_router.gr.dart';
import 'package:fitness/features/onboarding/data/models/fitness_profile_model.dart';
import 'package:fitness/features/onboarding/presentation/widgets/continue_button.dart'; // User confirmed this path works
import 'package:fitness/features/onboarding/presentation/widgets/gender_selection_tile.dart'; // NEW IMPORT

// Data Structure
class GenderOption {
  final String title;
  final IconData icon;
  final String imagePath;

  GenderOption(this.title, this.icon, this.imagePath);
}

@RoutePage()
class GenderScreen extends StatefulWidget {
  final FitnessProfileModel profile;

  const GenderScreen({super.key, required this.profile});

  @override
  State<GenderScreen> createState() => _GenderScreenState();
}

class _GenderScreenState extends State<GenderScreen> {
  final List<GenderOption> genderOptions = [
    GenderOption("Male", FontAwesomeIcons.mars, 'assets/male.png'),
    GenderOption("Female", FontAwesomeIcons.venus, 'assets/female.png'),
  ];

  GenderOption? _selectedGender;

  Widget _buildSkipButton() {
    const Color skipBackgroundColor = Color.fromARGB(255, 59, 31, 23);

    return Padding(
      padding: const EdgeInsets.only(bottom: 15.0),
      child: InkWell(
        onTap: () {
          setState(() {
            _selectedGender = null;
          });
          context.router.push(WeightRoute(profile: widget.profile));
        },
        child: Container(
          height: 50,
          decoration: BoxDecoration(
            color: skipBackgroundColor,
            borderRadius: BorderRadius.circular(16.0),
          ),
          alignment: Alignment.center,
          child: Text(
            "Prefer to skip, thanks! ✕",
            style: TextStyle(
              color: AppColors.accent,
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: const OnboardingAppBar(
        currentStep: 2,
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
                "What is your gender?",
                style: theme.textTheme.headlineMedium?.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.w800,
                ),
              ),
              const SizedBox(height: 30),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: genderOptions
                        .map((option) => GenderSelectionTile(
                              key: ValueKey(option.title),
                              title: option.title,
                              icon: option.icon,
                              imagePath: option.imagePath,
                              isSelected: _selectedGender == option,
                              onTap: () {
                                setState(() {
                                  _selectedGender = option;
                                });
                              },
                            ))
                        .toList(),
                  )
                      .animate(
                        delay: 200.ms,
                      )
                      .fadeIn(duration: 600.ms, curve: Curves.easeOut)
                      .slideY(
                          begin: 0.2,
                          end: 0,
                          duration: 600.ms,
                          curve: Curves.easeOut),
                ),
              ),
              const SizedBox(height: 20),
              _buildSkipButton(),
              ContinueButton(
                onPressed: _selectedGender == null
                    ? null
                    : () {
                        // 1. Update the profile with the selected gender
                        final updatedProfile = FitnessProfileModel(
                          uid: widget.profile.uid,
                          primaryGoal: widget.profile.primaryGoal,

                          // --- FIELD UPDATED IN THIS SCREEN ---
                          gender: _selectedGender!.title,

                          // --- REMAINING FIELDS (copied from previous step) ---
                          age: widget.profile.age,
                          currentWeightKg: widget.profile.currentWeightKg,
                          heightCm: widget.profile.heightCm,
                          experience: widget.profile.experience,
                          fitnessLevel: widget.profile.fitnessLevel,
                          workoutsPerWeek: widget.profile.workoutsPerWeek,
                          isTakingSupplements:
                              widget.profile.isTakingSupplements,
                          dietPreference: widget.profile.dietPreference,
                          workoutPreferences: widget.profile.workoutPreferences,
                          sleepQuality: widget.profile.sleepQuality,
                          physicalLimitations:
                              widget.profile.physicalLimitations,
                          calorieGoal: 0,
                          calorieUnit: 'Kcal',
                        );

                        // 2. Navigate to the next screen (WeightScreen)
                        context.router
                            .push(WeightRoute(profile: updatedProfile));
                      },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
