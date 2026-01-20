// lib/features/onboarding/presentation/widgets/limitation_chip.dart

import 'package:flutter/material.dart';
import 'package:fitness/common/res/colors.dart';

class LimitationChip extends StatelessWidget {
  final String limitation;
  final bool isSelected;
  final bool isRemovable;
  final bool isSuggestion;
  final VoidCallback onTap;
  final VoidCallback? onDeleted;

  const LimitationChip({
    super.key,
    required this.limitation,
    required this.isSelected,
    required this.onTap,
    this.isRemovable = true,
    this.isSuggestion = false,
    this.onDeleted,
  });

  @override
  Widget build(BuildContext context) {
    Color chipColor;
    Color textColor;
    BorderSide borderSide;

    if (isSelected) {
      chipColor = AppColors.primary;
      textColor = AppColors.textAccent;
      borderSide = BorderSide.none;
    } else {
      chipColor = AppColors.backgroundDark;
      textColor = AppColors.textOnPrimary;
      borderSide = isSuggestion
          ? const BorderSide(color: AppColors.primary, width: 1.5)
          : const BorderSide(color: AppColors.cardLight, width: 1.5);
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4.0, vertical: 4.0),
      child: InputChip(
        label: Text(
          limitation,
          style: TextStyle(
            color: textColor,
            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
          ),
        ),
        backgroundColor: chipColor,
        deleteIcon: isSelected && isRemovable
            ? const Icon(Icons.close, color: AppColors.textAccent, size: 16)
            : null,
        onDeleted: isSelected && isRemovable ? onDeleted : null,
        onPressed: onTap,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
          side: borderSide,
        ),
        selected: isSelected,
        selectedColor: AppColors.primary,
        checkmarkColor: AppColors.textAccent,
      ),
    );
  }
}
