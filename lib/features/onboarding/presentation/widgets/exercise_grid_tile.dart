// lib/features/onboarding/presentation/widgets/exercise_grid_tile.dart

import 'package:flutter/material.dart';
import 'package:fitness/common/res/colors.dart';

class ExerciseGridTile extends StatelessWidget {
  final String title;
  final IconData icon;
  final bool isSelected;
  final VoidCallback onTap;

  const ExerciseGridTile({
    super.key,
    required this.title,
    required this.icon,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          // Use AppColors
          color: isSelected
              ? AppColors.primary.withOpacity(0.2)
              : AppColors.textOnPrimary.withValues(alpha: 0.5),
          borderRadius: BorderRadius.circular(16.0),
          border: Border.all(
            color: isSelected ? AppColors.primary : Colors.transparent,
            width: 2.0,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 40,
              // Use AppColors
              color: isSelected
                  ? AppColors.primary
                  : AppColors.backgroundLight .withOpacity(0.5),
            ),
            const SizedBox(height: 8),
            Text(
              title,
              style: TextStyle(
                // Use AppColors
                color: isSelected ? AppColors.primary : AppColors.backgroundLight .withOpacity(0.5),
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                fontSize: 14,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
