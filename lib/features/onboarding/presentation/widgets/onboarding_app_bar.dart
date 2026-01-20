// lib/features/onboarding/presentation/widgets/onboarding_app_bar.dart

import 'package:auto_route/auto_route.dart';
import 'package:fitness/common/res/colors.dart';
import 'package:flutter/material.dart';

class OnboardingAppBar extends StatelessWidget implements PreferredSizeWidget {
  final int currentStep;
  final int totalSteps;
  final bool isInitial; // New flag to control the back button

  const OnboardingAppBar({
    super.key,
    required this.currentStep,
    required this.totalSteps,
    this.isInitial = false,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      leading: isInitial
          ? const SizedBox.shrink()
          : IconButton(
              icon:
                  const Icon(Icons.arrow_back_ios, color: AppColors.cardLight),
              onPressed: () => context.router.maybePop(),
            ),
      // --- Title ---
      title: const Text(
        'Assessment',
        style:
            TextStyle(color: AppColors.cardLight, fontWeight: FontWeight.bold),
      ),

      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 16.0),
          child: Chip(
            label: Text(
              '$currentStep of $totalSteps',
              style: const TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(6.0),
            ),
          ),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
