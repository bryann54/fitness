// lib/features/onboarding/presentation/widgets/onboarding_submit_button.dart

import 'package:firebase_auth/firebase_auth.dart';
import 'package:fitness/common/res/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fitness/features/onboarding/data/models/fitness_profile_model.dart';
import 'package:fitness/features/onboarding/presentation/bloc/onboarding_bloc.dart';

class OnboardingSubmitButton extends StatelessWidget {
  final FitnessProfileModel profile;

  const OnboardingSubmitButton({super.key, required this.profile});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<OnboardingBloc, OnboardingState>(
      listener: (context, state) {
        if (state is OnboardingSubmissionSuccess) {
          // Navigate to home or show success message
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Profile saved successfully!')),
          );
          // Navigator.pushReplacementNamed(context, '/home');
        } else if (state is OnboardingFailure) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.message),
              backgroundColor: Colors.red,
            ),
          );
        }
      },
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
                    final currentUser = FirebaseAuth.instance.currentUser;

                    if (currentUser == null) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Please sign in first'),
                          backgroundColor: Colors.red,
                        ),
                      );
                      return;
                    }

                    // Create profile with current user's UID
                    final profileWithUid =
                        profile.copyWith(uid: currentUser.uid);

                    context.read<OnboardingBloc>().add(
                          SubmitProfileEvent(profileData: profileWithUid),
                        );
                  },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary,
              padding: const EdgeInsets.symmetric(vertical: 18.0),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16.0),
              ),
            ),
            child: isLoading
                ? const SizedBox(
                    height: 20,
                    width: 20,
                    child: CircularProgressIndicator.adaptive(
                      strokeWidth: 3,
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
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
