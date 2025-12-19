// lib/features/workouts/presentation/pages/workout_schedule_page.dart
import 'package:auto_route/auto_route.dart';
import 'package:fitness/common/res/colors.dart';
import 'package:fitness/features/workouts/data/models/workout_model.dart';
import 'package:fitness/features/workouts/presentation/widgets/atoms/workout_hero_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';

@RoutePage()
class WorkoutSchedulePage extends StatelessWidget {
  final List<WorkoutModel> workouts;
  final dynamic profile;

  const WorkoutSchedulePage(
      {super.key, required this.workouts, required this.profile});

  @override
  Widget build(BuildContext context) {
    final daysOrder = [
      'Sunday',
      'Monday',
      'Tuesday',
      'Wednesday',
      'Thursday',
      'Friday',
      'Saturday'
    ];

    final sortedWorkouts = List<WorkoutModel>.from(workouts)
      ..sort((a, b) =>
          daysOrder.indexOf(a.day).compareTo(daysOrder.indexOf(b.day)));

    return Scaffold(
      backgroundColor: AppColors.backgroundDark,
      appBar: AppBar(
        title: Text(
          "Weekly Schedule",
          style: GoogleFonts.poppins(
              fontWeight: FontWeight.bold, color: Colors.white),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        itemCount: sortedWorkouts.length,
        itemBuilder: (context, index) {
          final workout = sortedWorkouts[index];

          return Padding(
            padding: const EdgeInsets.only(bottom: 25),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  workout.day.toUpperCase(),
                  style: const TextStyle(
                    color: AppColors.primary,
                    fontWeight: FontWeight.w900,
                    letterSpacing: 2.0,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 12),
                WorkoutHeroCard(
                    workout: workout, profile: profile, isLarge: true),
              ],
            )
                // Individual item animation
                .animate()
                .fadeIn(
                  duration: 400.ms,
                  curve: Curves.easeOut,
                  delay: (index * 100)
                      .ms, // Staggered delay based on list position
                )
                .slideX(
                  begin: -0.2, // Slide from the left (-20% of width)
                  end: 0,
                  duration: 500.ms,
                  curve: Curves.easeInOut, // Snappy "pro" curve
                ),
          );
        },
      ),
    );
  }
}
