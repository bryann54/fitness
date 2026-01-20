// lib/features/workouts/presentation/widgets/atoms/workout_hero_card.dart
import 'package:auto_route/auto_route.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:fitness/common/helpers/app_router.gr.dart';
import 'package:fitness/common/res/colors.dart';
import 'package:fitness/features/workouts/data/models/workout_model.dart';
import 'package:fitness/features/workouts/presentation/widgets/atoms/workout_info_chip.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';

class WorkoutHeroCard extends StatelessWidget {
  final WorkoutModel workout;
  final dynamic profile;
  final bool isLarge;

  const WorkoutHeroCard({
    super.key,
    required this.workout,
    required this.profile,
    this.isLarge = false,
  });

  @override
  Widget build(BuildContext context) {
    final String heroTag = 'workout_${workout.day}_${workout.location}';
    final String imageUrl =
        workout.exercises.isNotEmpty ? workout.exercises.first.imageUrl : '';

    // Calculate estimated calories based on duration and exercises
    final calories = _calculateCalories(workout);

    return GestureDetector(
      onTap: () => context.router.push(
        WorkoutDetailRoute(workout: workout, profile: profile),
      ),
      child: Hero(
        tag: heroTag,
        child: Container(
          height: isLarge ? 240 : 180,
          width: isLarge ? double.infinity : 280,
          margin: EdgeInsets.only(right: isLarge ? 0 : 15, bottom: 10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: AppColors.accent.withValues(alpha: .2)),
            boxShadow: [
              BoxShadow(
                color: AppColors.cardDark.withValues(alpha: 0.3),
                blurRadius: 15,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Stack(
              fit: StackFit.expand,
              children: [
                // Background Image
                if (imageUrl.isNotEmpty)
                  CachedNetworkImage(
                    imageUrl: imageUrl,
                    fit: BoxFit.cover,
                    placeholder: (context, url) => Container(
                      color: AppColors.cardDark,
                      child: const Center(
                        child: CircularProgressIndicator.adaptive(
                        
                        ),
                      ),
                    ),
                    errorWidget: (context, url, error) => Container(
                      color: AppColors.cardDark,
                      child: const Icon(
                        Icons.fitness_center,
                        size: 64,
                        color: AppColors.primary,
                      ),
                    ),
                  )
                else
                  Container(
                    color: AppColors.cardDark,
                    child: const Icon(
                      Icons.fitness_center,
                      size: 64,
                      color: AppColors.primary,
                    ),
                  ),

                // Gradient Overlay
                Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.transparent,
                        AppColors.cardDark.withValues(alpha: 0.7),
                        AppColors.cardDark.withValues(alpha: 0.95),
                      ],
                      stops: const [0.3, 0.7, 1.0],
                    ),
                  ),
                ),

                // Content
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      // Chips Row
                      Row(
                        children: [
                          WorkoutInfoChip(
                            icon: Icons.timer_outlined,
                            label: workout.duration,
                          ),
                          const SizedBox(width: 12),
                          WorkoutInfoChip(
                            icon: Icons.local_fire_department,
                            label: '${calories}kcal',
                          ),
                          const SizedBox(width: 12),
                          WorkoutInfoChip(
                            icon: Icons.fitness_center,
                            label: '${workout.totalExercises}x',
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),

                      // Workout Focus Title
                      Text(
                        workout.focus,
                        style: GoogleFonts.poppins(
                          color: AppColors.cardLight,
                          fontSize: isLarge ? 22 : 16,
                          fontWeight: FontWeight.bold,
                          height: 1.2,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),

                      // Muscle Category Badge
                      if (isLarge) ...[
                        const SizedBox(height: 8),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 6,
                          ),
                          decoration: BoxDecoration(
                            color: AppColors.primary.withValues(alpha: 0.2),
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                              color: AppColors.primary.withValues(alpha: 0.5),
                            ),
                          ),
                          child: Text(
                            workout.muscleCategory.toUpperCase(),
                            style: const TextStyle(
                              color: AppColors.primary,
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 1.2,
                            ),
                          ),
                        ),
                      ],
                    ],
                  ),
                ),

                // Location Badge (Top Right)
                Positioned(
                  top: 15,
                  right: 15,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.cardDark.withValues(alpha: 0.6),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: AppColors.cardLight.withValues(alpha: 0.2),
                      ),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          _getLocationIcon(workout.location),
                          size: 12,
                          color: AppColors.cardLight,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          workout.location.toUpperCase(),
                          style: const TextStyle(
                            color: AppColors.cardLight,
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 0.5,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    ).animate().fadeIn(duration: 400.ms).scale(begin: const Offset(0.95, 0.95));
  }

  int _calculateCalories(WorkoutModel workout) {
    // Estimate calories based on duration and exercise count
    final durationMinutes = _parseDuration(workout.duration);
    final baseCalories = durationMinutes * 7; // ~7 cal/min average
    final exerciseMultiplier = (workout.totalExercises / 10).clamp(0.8, 1.3);

    return (baseCalories * exerciseMultiplier).round();
  }

  int _parseDuration(String duration) {
    final numbers = RegExp(r'\d+').allMatches(duration);
    if (numbers.isEmpty) return 60; // default

    final nums = numbers.map((m) => int.parse(m.group(0)!)).toList();
    return nums.isEmpty ? 60 : nums.reduce((a, b) => a + b) ~/ nums.length;
  }

  IconData _getLocationIcon(String location) {
    switch (location.toLowerCase()) {
      case 'gym':
        return Icons.fitness_center;
      case 'home':
        return Icons.home;
      default:
        return Icons.location_on;
    }
  }
}
