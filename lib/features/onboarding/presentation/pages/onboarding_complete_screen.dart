// lib/features/onboarding/presentation/pages/onboarding_complete_screen.dart

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:animate_do/animate_do.dart';
import 'package:fitness/common/helpers/app_router.gr.dart'; // Assuming HomeRoute is here
import 'package:fitness/features/onboarding/data/models/fitness_profile_model.dart';
import 'package:fitness/features/onboarding/presentation/bloc/onboarding_bloc.dart';
import 'package:fitness/features/onboarding/presentation/widgets/onboarding_submit_button.dart'; // <--- NEW WIDGET IMPORT

@RoutePage()
class OnboardingCompleteScreen extends StatefulWidget {
  final FitnessProfileModel finalProfile;

  const OnboardingCompleteScreen({super.key, required this.finalProfile});

  @override
  State<OnboardingCompleteScreen> createState() =>
      _OnboardingCompleteScreenState();
}

class _OnboardingCompleteScreenState extends State<OnboardingCompleteScreen> {
  static const Color primaryColor = Color(0xFFFF9800);

  // Helper to display key-value pairs (Unchanged)
  Widget _buildProfileDetail(BuildContext context, String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 150, // Fixed width for titles
            child: Text(
              '$title:',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: Colors.white70,
                  ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
            ),
          ),
        ],
      ),
    );
  }

  // --- No longer needed, logic moved to OnboardingSubmitButton
  // void _submitProfile(BuildContext context) {}
  // -----------------------------------------------------------

  @override
  Widget build(BuildContext context) {
    final profile = widget.finalProfile;

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          'Review & Complete',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
      // --- CORRECTED: Use BlocListener around the _buildBody for navigation and snackbars ---
      body: BlocListener<OnboardingBloc, OnboardingState>(
        listener: (context, state) {
          if (state is OnboardingSubmissionSuccess) {
            // Navigate away using AutoRouter replace to clear the stack
            context.router.replaceAll([const MainRoute()]);
          } else if (state is OnboardingFailure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Error: ${state.message}')),
            );
          }
        },
        child: _buildBody(context, profile),
      ),
    );
  }

  Widget _buildBody(BuildContext context, FitnessProfileModel profile) {
    final theme = Theme.of(context);

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header Animation
            FadeInDown(
              duration: const Duration(milliseconds: 600),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "All Set!",
                    style: theme.textTheme.headlineLarge?.copyWith(
                      color: primaryColor,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    "Review your profile data before we generate your personalized fitness plan.",
                    style: theme.textTheme.titleMedium?.copyWith(
                      color: Colors.white70,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 30),

            // Content Animation
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // --- DEMOGRAPHICS (Delay 300ms) ---
                    FadeInUp(
                      delay: const Duration(milliseconds: 300),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Demographics',
                              style: theme.textTheme.headlineSmall
                                  ?.copyWith(color: Colors.white)),
                          const Divider(color: Colors.white24),
                          _buildProfileDetail(
                              context, 'Gender', profile.gender),
                          _buildProfileDetail(
                              context, 'Age', profile.age.toString()),
                          _buildProfileDetail(context, 'Weight',
                              '${profile.currentWeightKg} kg'),
                          _buildProfileDetail(
                              context, 'Height', '${profile.heightCm} cm'),
                          _buildProfileDetail(context, 'Sleep Quality',
                              profile.sleepQuality.toString().split('.').last),
                        ],
                      ),
                    ),

                    const SizedBox(height: 20),

                    // --- FITNESS GOALS & EXPERIENCE (Delay 600ms) ---
                    FadeInUp(
                      delay: const Duration(milliseconds: 600),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Fitness & Goals',
                              style: theme.textTheme.headlineSmall
                                  ?.copyWith(color: Colors.white)),
                          const Divider(color: Colors.white24),
                          _buildProfileDetail(context, 'Primary Goal',
                              profile.primaryGoal.toString().split('.').last),
                          _buildProfileDetail(context, 'Experience',
                              profile.experience.toString().split('.').last),
                          _buildProfileDetail(
                              context, 'Fitness Level', profile.fitnessLevel),
                          _buildProfileDetail(context, 'Workouts/Week',
                              '${profile.workoutsPerWeek} times'),

                          // --- CALORIE GOAL FIELD ---
                          _buildProfileDetail(context, 'Calorie Goal',
                              '${profile.calorieGoal} ${profile.calorieUnit}'),
                        ],
                      ),
                    ),

                    const SizedBox(height: 20),

                    // --- PREFERENCES & HEALTH (Delay 900ms) ---
                    FadeInUp(
                      delay: const Duration(milliseconds: 900),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Preferences & Health',
                              style: theme.textTheme.headlineSmall
                                  ?.copyWith(color: Colors.white)),
                          const Divider(color: Colors.white24),
                          _buildProfileDetail(
                              context, 'Diet Pref.', profile.dietPreference),
                          _buildProfileDetail(context, 'Physical Limits',
                              profile.physicalLimitations ?? 'None'),
                          _buildProfileDetail(context, 'Workout Types',
                              profile.workoutPreferences.join(', ')),

                          // --- SUPPLEMENTS ---
                          _buildProfileDetail(context, 'Takes Supplements',
                              profile.isTakingSupplements ? 'Yes' : 'No'),
                          if (profile.isTakingSupplements)
                            _buildProfileDetail(context, 'Supplements Taken',
                                profile.supplementsTaken.join(', ')),

                          const SizedBox(height: 40),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // --- FINAL SUBMIT BUTTON (Delay 1200ms) ---
            FadeInUp(
              delay: const Duration(milliseconds: 1200),
              child: OnboardingSubmitButton(profile: profile),
            ),
          ],
        ),
      ),
    );
  }
}
