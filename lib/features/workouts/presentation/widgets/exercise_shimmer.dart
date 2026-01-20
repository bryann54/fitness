// lib/features/workouts/presentation/widgets/exercise_shimmer.dart
import 'package:fitness/common/res/colors.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ExerciseShimmerThumbnail extends StatelessWidget {
  const ExerciseShimmerThumbnail({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: AppColors.cardLight,
      highlightColor: AppColors.cardLight,
      child: Container(
        width: 65,
        height: 65,
        decoration: BoxDecoration(
          color: AppColors.cardDark,
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    );
  }
}

// Use this in your ListView while the Bloc is in Loading state
class ExerciseCardPlaceholder extends StatelessWidget {
  const ExerciseCardPlaceholder({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: AppColors.cardLight,
      highlightColor: AppColors.cardLight,
      child: Container(
        height: 90,
        margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
        decoration: BoxDecoration(
          color: AppColors.cardDark,
          borderRadius: BorderRadius.circular(20),
        ),
      ),
    );
  }
}
