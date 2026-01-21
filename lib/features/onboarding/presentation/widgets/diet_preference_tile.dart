// lib/features/onboarding/presentation/widgets/diet_preference_tile.dart

import 'package:flutter/material.dart';
import 'package:fitness/common/res/colors.dart';

class DietPreferenceTile extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;
  final bool isSelected;
  final VoidCallback onTap;

  const DietPreferenceTile({
    super.key,
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: InkWell(
          onTap: onTap,
          child: Container(
            height: 140, 
            padding: const EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              color: isSelected
                  ? AppColors.primary.withOpacity(0.1) // Light primary tint
                  : AppColors.cardDark,
              borderRadius: BorderRadius.circular(16.0),
              border: Border.all(
                color: isSelected ? AppColors.primary : Colors.transparent,
                width: 2.0,
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            color: isSelected
                                ? AppColors.primary
                                : AppColors.textOnPrimary,
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      subtitle,
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color:isSelected?AppColors.primary: AppColors.textPrimaryDark,
                          ),
                    ),
                  ],
                ),
                Align(
                  alignment: Alignment.bottomRight,
                  child: Icon(
                    icon,
                    size: 36,
                    color: isSelected
                        ? AppColors.primary
                        : AppColors.textSecondary.withOpacity(0.4),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
