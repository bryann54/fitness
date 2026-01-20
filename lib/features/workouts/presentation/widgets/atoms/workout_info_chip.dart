// lib/features/workouts/presentation/widgets/atoms/workout_info_chip.dart
import 'package:fitness/common/res/colors.dart';
import 'package:flutter/material.dart';

class WorkoutInfoChip extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color? color;

  const WorkoutInfoChip(
      {super.key, required this.icon, required this.label, this.color});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, color: color ?? AppColors.primary, size: 16),
        const SizedBox(width: 6),
        Text(
          label,
          style: const TextStyle(
              color: AppColors.cardLight,
              fontWeight: FontWeight.w500,
              fontSize: 13),
        ),
      ],
    );
  }
}
