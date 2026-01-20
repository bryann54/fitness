// lib/features/workouts/presentation/pages/workout_detail_page.dart
import 'package:auto_route/auto_route.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:fitness/common/res/colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:fitness/features/onboarding/data/models/fitness_profile_model.dart';
import 'package:fitness/features/workouts/data/models/workout_model.dart';
import 'package:fitness/features/workouts/presentation/widgets/exercise_card.dart';
import 'package:flutter_animate/flutter_animate.dart';

@RoutePage()
class WorkoutDetailPage extends StatelessWidget {
  final WorkoutModel workout;
  final FitnessProfileModel profile;

  const WorkoutDetailPage({
    super.key,
    required this.workout,
    required this.profile,
  });

  @override
  Widget build(BuildContext context) {
    final calories = _calculateCalories(workout);
    final imageUrl =
        workout.exercises.isNotEmpty ? workout.exercises.first.imageUrl : '';

    return Scaffold(
      backgroundColor: AppColors.cardDark,
      body: Stack(
        children: [
          CustomScrollView(
            slivers: [
              // Hero Image Header
              SliverAppBar(
                expandedHeight: 400,
                pinned: true,
                backgroundColor: AppColors.cardDark,
                flexibleSpace: FlexibleSpaceBar(
                  background: Stack(
                    fit: StackFit.expand,
                    children: [
                      Hero(
                        tag: 'workout_${workout.day}_${workout.location}',
                        child: CachedNetworkImage(
                          imageUrl: imageUrl,
                          fit: BoxFit.cover,
                          placeholder: (context, url) => Container(
                            color: AppColors.cardDark,
                            child: const Center(
                              child: CircularProgressIndicator(
                                color: AppColors.primary,
                              ),
                            ),
                          ),
                          errorWidget: (context, url, error) => Container(
                            color: AppColors.cardDark,
                            child: const Icon(
                              Icons.fitness_center,
                              size: 80,
                              color: AppColors.primary,
                            ),
                          ),
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
                            ],
                            stops: const [0.6, 1.0],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // Content Section
              SliverToBoxAdapter(
                child: Container(
                  decoration: const BoxDecoration(
                    color: AppColors.cardDark,
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(30),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(25),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Workout Badge
                            Row(
                              children: [
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 12,
                                    vertical: 6,
                                  ),
                                  decoration: BoxDecoration(
                                    color: AppColors.primary
                                        .withValues(alpha: 0.2),
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: Text(
                                    "${workout.totalExercises} EXERCISES",
                                    style: const TextStyle(
                                      color: AppColors.primary,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 11,
                                      letterSpacing: 1.2,
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 10),
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 12,
                                    vertical: 6,
                                  ),
                                  decoration: BoxDecoration(
                                    color: AppColors.cardLight
                                        .withValues(alpha: 0.1),
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: Text(
                                    workout.muscleCategory.toUpperCase(),
                                    style: const TextStyle(
                                      color: AppColors.cardLight,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 11,
                                      letterSpacing: 1.2,
                                    ),
                                  ),
                                ),
                              ],
                            )
                                .animate()
                                .fadeIn(delay: 100.ms)
                                .slideX(begin: -0.2),

                            const SizedBox(height: 15),

                            // Title
                            Text(
                              workout.focus,
                              style: GoogleFonts.poppins(
                                fontSize: 28,
                                fontWeight: FontWeight.bold,
                                color: AppColors.cardLight,
                                height: 1.2,
                              ),
                            )
                                .animate()
                                .fadeIn(delay: 200.ms)
                                .slideX(begin: -0.2),

                            const SizedBox(height: 10),

                            // Description
                            Text(
                              _generateDescription(workout),
                              style: TextStyle(
                                color:
                                    AppColors.cardLight.withValues(alpha: 0.6),
                                height: 1.6,
                                fontSize: 15,
                              ),
                            ).animate().fadeIn(delay: 300.ms),

                            const SizedBox(height: 25),

                            // Stats Row
                            Row(
                              children: [
                                _statChip(
                                  Icons.access_time,
                                  workout.duration,
                                ),
                                const SizedBox(width: 15),
                                _statChip(
                                  Icons.local_fire_department,
                                  "${calories}kcal",
                                ),
                                const SizedBox(width: 15),
                                _statChip(
                                  Icons.star_rounded,
                                  "4.8",
                                ),
                              ],
                            )
                                .animate()
                                .fadeIn(delay: 400.ms)
                                .slideY(begin: 0.2),

                            const SizedBox(height: 30),

                            // Section Title
                            Text(
                              "Exercises",
                              style: GoogleFonts.poppins(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: AppColors.cardLight,
                              ),
                            ).animate().fadeIn(delay: 500.ms),

                            const SizedBox(height: 15),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // Exercise List
              SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    return ExerciseCard(
                      exercise: workout.exercises[index],
                      index: index + 1,
                    )
                        .animate()
                        .fadeIn(delay: (600 + index * 50).ms)
                        .slideX(begin: 0.1);
                  },
                  childCount: workout.exercises.length,
                ),
              ),

              const SliverToBoxAdapter(
                child: SizedBox(height: 120),
              ),
            ],
          ),

          // Bottom Action Buttons
          Positioned(
            bottom: 30,
            left: 20,
            right: 20,
            child: Row(
              children: [
                Expanded(
                  flex: 1,
                  child: _actionButton(
                    Icons.bookmark_outline,
                    "Save",
                    AppColors.cardLight.withValues(alpha: 0.15),
                    AppColors.cardLight,
                  ),
                ),
                const SizedBox(width: 15),
                Expanded(
                  flex: 2,
                  child: _actionButton(
                    Icons.play_arrow_rounded,
                    "Start Workout",
                    AppColors.primary,
                    AppColors.cardDark,
                  ),
                ),
              ],
            )
                .animate()
                .fadeIn(delay: 800.ms)
                .slideY(begin: 0.5, curve: Curves.easeOut),
          ),
        ],
      ),
    );
  }

  Widget _statChip(IconData icon, String label) {
    return Row(
      children: [
        Icon(icon, color: AppColors.primary, size: 20),
        const SizedBox(width: 6),
        Text(
          label,
          style: const TextStyle(
            color: AppColors.cardLight,
            fontWeight: FontWeight.bold,
            fontSize: 15,
          ),
        ),
      ],
    );
  }

  Widget _actionButton(IconData icon, String label, Color bg, Color textColor) {
    return Container(
      height: 60,
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(20),
        boxShadow: bg == AppColors.primary
            ? [
                BoxShadow(
                  color: AppColors.primary.withValues(alpha: 0.3),
                  blurRadius: 20,
                  offset: const Offset(0, 10),
                ),
              ]
            : null,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            label,
            style: TextStyle(
              color: textColor,
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
          const SizedBox(width: 8),
          Icon(icon, color: textColor, size: 24),
        ],
      ),
    );
  }

  String _generateDescription(WorkoutModel workout) {
    final muscleGroup = workout.muscleCategory;
    final exerciseCount = workout.totalExercises;

    return "This $muscleGroup-focused session includes $exerciseCount carefully selected exercises designed to maximize muscle engagement and promote strength gains. Perfect for ${workout.location} training.";
  }

  int _calculateCalories(WorkoutModel workout) {
    final durationMinutes = _parseDuration(workout.duration);
    final baseCalories = durationMinutes * 7;
    final exerciseMultiplier = (workout.totalExercises / 10).clamp(0.8, 1.3);
    return (baseCalories * exerciseMultiplier).round();
  }

  int _parseDuration(String duration) {
    final numbers = RegExp(r'\d+').allMatches(duration);
    if (numbers.isEmpty) return 60;
    final nums = numbers.map((m) => int.parse(m.group(0)!)).toList();
    return nums.isEmpty ? 60 : nums.reduce((a, b) => a + b) ~/ nums.length;
  }
}
