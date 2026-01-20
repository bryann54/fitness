// lib/features/workouts/presentation/pages/all_exercises_page.dart
import 'package:auto_route/auto_route.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:fitness/common/helpers/app_router.gr.dart';
import 'package:fitness/common/res/colors.dart';
import 'package:fitness/features/workouts/data/models/workout_model.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_animate/flutter_animate.dart';

@RoutePage()
class AllExercisesPage extends StatelessWidget {
  final List<WorkoutModel> workouts;
  final dynamic profile;

  const AllExercisesPage({
    super.key,
    required this.workouts,
    required this.profile,
  });

  @override
  Widget build(BuildContext context) {
    // Group by muscle category for better organization
    final categorized = <String, List<WorkoutModel>>{};
    for (var workout in workouts) {
      categorized.putIfAbsent(workout.muscleCategory, () => []).add(workout);
    }

    return Scaffold(
      backgroundColor: AppColors.cardDark,
      appBar: AppBar(
        title: Text(
          "All Exercises",
          style: GoogleFonts.poppins(
            fontWeight: FontWeight.bold,
            color: AppColors.cardLight,
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(20),
        itemCount: categorized.length,
        itemBuilder: (context, categoryIndex) {
          final category = categorized.keys.elementAt(categoryIndex);
          final categoryWorkouts = categorized[category]!;

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Category Header
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 3),
                child: Text(
                  category.toUpperCase(),
                  style: const TextStyle(
                    color: AppColors.primary,
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.5,
                  ),
                ),
              )
                  .animate()
                  .fadeIn(delay: (categoryIndex * 100).ms)
                  .slideX(begin: -0.2),

              // Workout Cards in Category
              ...categoryWorkouts.asMap().entries.map((entry) {
                final index = entry.key;
                final workout = entry.value;
                final imageUrl = workout.exercises.isNotEmpty
                    ? workout.exercises.first.imageUrl
                    : '';

                return Container(
                  margin: const EdgeInsets.only(bottom: 5),
                  decoration: BoxDecoration(
                    color: AppColors.cardDark,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.cardDark.withValues(alpha: 0.3),
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: ListTile(
                    contentPadding: const EdgeInsets.all(12),
                    leading: ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: CachedNetworkImage(
                        imageUrl: imageUrl,
                        width: 60,
                        height: 60,
                        fit: BoxFit.cover,
                        placeholder: (context, url) => Container(
                          color: AppColors.cardDark,
                          child: const Center(
                            child: CircularProgressIndicator.adaptive(),
                          ),
                        ),
                        errorWidget: (context, url, error) => Container(
                          color: AppColors.cardDark,
                          child: const Icon(
                            Icons.fitness_center,
                            color: AppColors.primary,
                          ),
                        ),
                      ),
                    ),
                    title: Text(
                      workout.focus,
                      style: GoogleFonts.poppins(
                        color: AppColors.cardLight,
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                      ),
                    ),
                    subtitle: Padding(
                      padding: const EdgeInsets.only(top: 6),
                      child: Row(
                        children: [
                          Icon(
                            Icons.fitness_center,
                            size: 14,
                            color: AppColors.cardLight.withValues(alpha: 0.6),
                          ),
                          const SizedBox(width: 4),
                          Text(
                            "${workout.totalExercises} exercises",
                            style: TextStyle(
                              color: AppColors.cardLight.withValues(alpha: 0.6),
                              fontSize: 13,
                            ),
                          ),
                          const SizedBox(width: 12),
                          Icon(
                            Icons.timer,
                            size: 14,
                            color: AppColors.cardLight.withValues(alpha: 0.6),
                          ),
                          const SizedBox(width: 4),
                          Text(
                            workout.duration,
                            style: TextStyle(
                              color: AppColors.cardLight.withValues(alpha: 0.6),
                              fontSize: 13,
                            ),
                          ),
                        ],
                      ),
                    ),
                    trailing: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: AppColors.primary.withValues(alpha: 0.2),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.arrow_forward_rounded,
                        color: AppColors.primary,
                        size: 20,
                      ),
                    ),
                    onTap: () => context.router.push(
                      WorkoutDetailRoute(workout: workout, profile: profile),
                    ),
                  ),
                )
                    .animate()
                    .fadeIn(delay: (categoryIndex * 100 + index * 50).ms)
                    .slideX(begin: 0.1, curve: Curves.easeOut);
              }),

              const SizedBox(height: 10),
            ],
          );
        },
      ),
    );
  }
}
