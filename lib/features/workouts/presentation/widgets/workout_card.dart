// lib/features/workouts/presentation/widgets/workout_card.dart
import 'package:fitness/common/res/colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:fitness/features/workouts/data/models/workout_model.dart';
import 'package:fitness/features/workouts/presentation/pages/workout_detail_page.dart';

// lib/features/workouts/presentation/widgets/workout_card.dart
class WorkoutCard extends StatelessWidget {
  final WorkoutModel workout;
  final dynamic profile;
  final bool isFeatured;
  final bool isCompact;

  const WorkoutCard({
    super.key,
    required this.workout,
    required this.profile,
    this.isFeatured = false,
    this.isCompact = false,
  });

  @override
  Widget build(BuildContext context) {
    isDarkTheme(context);
    final String image =
        workout.exercises.isNotEmpty ? workout.exercises.first.imageUrl : '';

    return GestureDetector(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) =>
                WorkoutDetailPage(workout: workout, profile: profile)),
      ),
      child: Hero(
        tag: 'workout_bg_${workout.focus}', // Hero tag for seamless transition
        child: Container(
          height: isFeatured ? 200 : 160,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(25),
            image:
                DecorationImage(image: NetworkImage(image), fit: BoxFit.cover),
          ),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(25),
              gradient: LinearGradient(
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
                colors: [Colors.black.withOpacity(0.8), Colors.transparent],
              ),
            ),
            padding: const EdgeInsets.all(15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                if (!isCompact)
                  Row(
                    children: [
                      const Icon(Icons.access_time,
                          color: Colors.white70, size: 14),
                      const SizedBox(width: 5),
                      Text(workout.duration,
                          style: const TextStyle(color: Colors.white)),
                      const SizedBox(width: 15),
                      const Icon(Icons.local_fire_department,
                          color: Colors.white70, size: 14),
                      const SizedBox(width: 5),
                      const Text("450kcal",
                          style: TextStyle(
                              color: Colors.white)), // Calculated/Estimated
                    ],
                  ),
                const SizedBox(height: 5),
                Text(
                  workout.focus,
                  style: GoogleFonts.poppins(
                    color: Colors.white,
                    fontSize: isFeatured ? 22 : 16,
                    fontWeight: FontWeight.bold,
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
