// lib/features/onboarding/presentation/widgets/onboarding_chip_builder.dart

import 'package:flutter/material.dart';
import 'package:fitness/common/res/colors.dart';

class OnboardingSelectedChip extends StatelessWidget {
  final String label;
  final VoidCallback onDelete;

  const OnboardingSelectedChip({
    super.key,
    required this.label,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4.0, vertical: 4.0),
      child: InputChip(
        label: Text(
          label,
          style: TextStyle(
            color: AppColors.textAccent,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: AppColors.primary,
        deleteIcon:
            const Icon(Icons.close, color: AppColors.textAccent, size: 16),
        onDeleted: onDelete,
        onPressed: onDelete,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
    );
  }
}
