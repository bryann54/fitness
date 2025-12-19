// lib/features/onboarding/presentation/pages/sleep_quality_screen.dart

import 'package:auto_route/auto_route.dart';
import 'package:fitness/features/onboarding/presentation/widgets/onboarding_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:fitness/common/helpers/app_router.gr.dart';
import 'package:fitness/features/onboarding/data/models/fitness_profile_model.dart';
import 'package:fitness/features/onboarding/presentation/widgets/continue_button.dart';
import 'package:fitness/common/res/colors.dart'; // <--- NEW IMPORT
import 'package:fitness/features/onboarding/presentation/widgets/sleep_quality_tile.dart';
import 'package:flutter_animate/flutter_animate.dart'; // <--- NEW IMPORT

@RoutePage()
class SleepQualityScreen extends StatefulWidget {
  final FitnessProfileModel profile;
  const SleepQualityScreen({super.key, required this.profile});

  @override
  State<SleepQualityScreen> createState() => _SleepQualityScreenState();
}

class _SleepQualityScreenState extends State<SleepQualityScreen> {
  // Data structure for the options (Using IconData instead of strings/emojis)
  final List<Map<String, dynamic>> sleepOptions = [
    {
      'title': 'Excellent',
      'hours': '>8 hours',
      'value': SleepQuality.excellent,
      'icon': Icons.sentiment_very_satisfied, // Replaced emoji with IconData
    },
    {
      'title': 'Great',
      'hours': '7-8 hours',
      'value': SleepQuality.good,
      'icon': Icons.sentiment_satisfied, // Replaced emoji with IconData
    },
    {
      'title': 'Normal',
      'hours': '6-7 hours',
      'value': SleepQuality.fair,
      'icon': Icons.sentiment_neutral, // Replaced emoji with IconData
    },
    {
      'title': 'Bad',
      'hours': '3-4 hours',
      'value': SleepQuality.poor,
      'icon': Icons.sentiment_dissatisfied, // Replaced emoji with IconData
    },
    {
      'title': 'Insomniac',
      'hours': '<2 hours',
      'value':
          SleepQuality.poor, // Note: Insomniac often maps to the worst quality
      'icon': Icons.sentiment_very_dissatisfied, // Replaced emoji with IconData
    },
  ];

  late SleepQuality? _selectedQuality;

  @override
  void initState() {
    super.initState();
    _selectedQuality = widget.profile.sleepQuality;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final bool isButtonEnabled = _selectedQuality != null;

    return Scaffold(
      backgroundColor: AppColors.backgroundDark,
      appBar: const OnboardingAppBar(
        currentStep: 14,
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
                "What's your sleep quality like?",
                style: theme.textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.w800,
                ),
              ).animate(
                effects: [FadeEffect(), SlideEffect()],
              ),
              const SizedBox(height: 30),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: sleepOptions.map((option) {
                      final SleepQuality quality =
                          option['value'] as SleepQuality;

                      // Using the extracted widget
                      return SleepQualityTile(
                        title: option['title'] as String,
                        hours: option['hours'] as String,
                        icon: option['icon'] as IconData,
                        isSelected: _selectedQuality == quality,
                        onTap: () {
                          setState(() {
                            _selectedQuality = quality;
                          });
                        },
                      )
                          .animate(
                            delay: 100.ms,
                          )
                          .fadeIn(duration: 600.ms, curve: Curves.easeOut)
                          .slideX(
                              begin: 0.2,
                              end: 0,
                              duration: 600.ms,
                              curve: Curves.easeOut);
                    }).toList(),
                  ),
                ),
              ),
              const SizedBox(height: 20),
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
                          isTakingSupplements:
                              widget.profile.isTakingSupplements,
                          supplementsTaken: widget.profile.supplementsTaken,
                          heightCm: widget.profile.heightCm,
                          calorieGoal: widget.profile.calorieGoal,
                          calorieUnit: widget.profile.calorieUnit,
                          sleepQuality: _selectedQuality!,
                        );

                        context.router.push(OnboardingCompleteRoute(
                            finalProfile: updatedProfile));
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
