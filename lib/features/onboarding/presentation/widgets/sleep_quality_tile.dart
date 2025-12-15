// lib/features/onboarding/presentation/widgets/sleep_quality_tile.dart

import 'package:flutter/material.dart';
import 'package:fitness/common/res/colors.dart';

class SleepQualityTile extends StatelessWidget {
  final String title;
  final String hours;
  final IconData icon;
  final bool isSelected;
  final VoidCallback onTap;

  const SleepQualityTile({
    super.key,
    required this.title,
    required this.hours,
    required this.icon,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: InkWell(
        onTap: onTap,
        child: Container(
          decoration: BoxDecoration(
            color: AppColors.cardDark,
            borderRadius: BorderRadius.circular(16.0),
            border: Border.all(
              color: isSelected ? AppColors.primary : Colors.transparent,
              width: 2.0,
            ),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 18.0),
          child: Row(
            children: [
              // Icon
              Icon(
                icon,
                size: 28,
                color: isSelected ? AppColors.primary : AppColors.textOnPrimary,
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  title,
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        color: AppColors.textOnPrimary,
                        fontWeight: FontWeight.bold,
                      ),
                ),
              ),
              // Hours (Right side)
              Text(
                hours,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
              const SizedBox(width: 12),
              // Selection Indicator
              Icon(
                isSelected ? Icons.check_circle : Icons.radio_button_unchecked,
                color: isSelected
                    ? AppColors.primary
                    : AppColors.textSecondary.withOpacity(0.5),
                size: 24,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
