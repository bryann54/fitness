// lib/features/workouts/presentation/widgets/molecules/workout_progress_card.dart
import 'package:fitness/common/res/colors.dart';
import 'package:flutter/material.dart';

class WorkoutProgressCard extends StatelessWidget {
  final double percent;
  final int exercisesLeft;

  const WorkoutProgressCard(
      {super.key, required this.percent, required this.exercisesLeft});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.primary.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(25),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text("Workout Progress!",
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: AppColors.cardLight)),
                const SizedBox(height: 4),
                Text("$exercisesLeft Exercise Left",
                    style: const TextStyle(color: AppColors.cardLight)),
              ],
            ),
          ),
          Stack(
            alignment: Alignment.center,
            children: [
              SizedBox(
                width: 60,
                height: 60,
                child: CircularProgressIndicator(
                  value: percent,
                  strokeWidth: 6,
                  backgroundColor: AppColors.cardLight,
                  color: AppColors.primary,
                ),
              ),
              Text("${(percent * 100).toInt()}%",
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, color: AppColors.cardLight)),
            ],
          )
        ],
      ),
    );
  }
}
