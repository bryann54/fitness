// lib/features/workouts/presentation/widgets/upper_body_workout_card.dart

import 'package:flutter/material.dart';

class UpperBodyWorkoutCard extends StatelessWidget {
  const UpperBodyWorkoutCard({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    // Placeholder Image from the provided design
    //

    return Container(
      height: 200,
      padding: const EdgeInsets.all(20.0),
      decoration: BoxDecoration(
        color: Colors.grey.shade500,
        borderRadius: BorderRadius.circular(20),
        image: const DecorationImage(
          // In a real app, this would use the ExerciseImageModel's URL
          image: AssetImage('assets/images/upper_body_workout.png'),
          fit: BoxFit.cover,
          alignment: Alignment.centerRight,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Text(
            'Upper Body\nWorkout',
            style: theme.textTheme.headlineSmall?.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              shadows: [
                Shadow(
                  blurRadius: 5.0,
                  color: Colors.black.withValues(alpha: 0.5),
                  offset: const Offset(1, 1),
                ),
              ],
            ),
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              const Icon(Icons.watch_later_outlined,
                  color: Colors.white, size: 16),
              const SizedBox(width: 4),
              Text('90min',
                  style:
                      theme.textTheme.bodySmall?.copyWith(color: Colors.white)),
              const SizedBox(width: 16),
              const Icon(Icons.local_fire_department_outlined,
                  color: Colors.white, size: 16),
              const SizedBox(width: 4),
              Text('1,200kacl',
                  style:
                      theme.textTheme.bodySmall?.copyWith(color: Colors.white)),
            ],
          ),
        ],
      ),
    );
  }
}
