// lib/features/onboarding/presentation/widgets/onboarding_submit_button.dart

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fitness/features/onboarding/data/models/fitness_profile_model.dart';
import 'package:fitness/features/onboarding/presentation/bloc/onboarding_bloc.dart'; // Ensure this path is correct

class OnboardingSubmitButton extends StatelessWidget {
  final FitnessProfileModel profile;
  static const Color primaryColor = Color(0xFFFF9800);

  const OnboardingSubmitButton({super.key, required this.profile});

  @override
  Widget build(BuildContext context) {
    // We use BlocBuilder to listen only to the submission states
    return BlocBuilder<OnboardingBloc, OnboardingState>(
      // Only rebuild when submission state changes
      buildWhen: (previous, current) =>
          current is OnboardingSubmissionInProgress ||
          current is OnboardingSubmissionSuccess ||
          current is OnboardingFailure,

      builder: (context, state) {
        final bool isLoading = state is OnboardingSubmissionInProgress;

        return SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: isLoading
                ? null
                : () {
                    // Dispatch the event to save the profile
                    context.read<OnboardingBloc>().add(
                          SubmitProfileEvent(profileData: profile),
                        );
                  },
            style: ElevatedButton.styleFrom(
              backgroundColor: primaryColor,
              padding: const EdgeInsets.symmetric(vertical: 18.0),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16.0),
              ),
            ),
            child: isLoading
                ? const SizedBox(
                    height: 20,
                    width: 20,
                    child: CircularProgressIndicator(
                      color: Colors.black,
                      strokeWidth: 3,
                    ),
                  )
                : Text(
                    'Confirm & Start Plan',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                  ),
          ),
        );
      },
    );
  }
}
