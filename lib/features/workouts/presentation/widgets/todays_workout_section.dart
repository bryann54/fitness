import 'package:auto_route/auto_route.dart';
import 'package:fitness/common/helpers/app_router.gr.dart';
import 'package:fitness/features/workouts/data/models/workout_model.dart';
import 'package:fitness/features/workouts/presentation/widgets/atoms/section_header.dart';
import 'package:fitness/features/workouts/presentation/widgets/atoms/workout_hero_card.dart';
import 'package:flutter/material.dart';

class TodaysWorkoutSection extends StatelessWidget {
  final List<WorkoutModel> workouts;
  final dynamic profile;

  const TodaysWorkoutSection({
    super.key,
    required this.workouts,
    required this.profile,
  });

  String _getTodayName() {
    final now = DateTime.now();
    final dayNames = [
      'Sunday',
      'Monday',
      'Tuesday',
      'Wednesday',
      'Thursday',
      'Friday',
      'Saturday'
    ];
    return dayNames[now.weekday % 7];
  }

  WorkoutModel? _getTodaysWorkout() {
    final today = _getTodayName();
    try {
      return workouts.firstWhere(
        (workout) => workout.day.toLowerCase() == today.toLowerCase(),
      );
    } catch (e) {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    final todaysWorkout = _getTodaysWorkout();

    if (todaysWorkout == null) {
      return Column(
        children: [
          SectionHeader(
            title: "Today's Workout",
            count: "0",
            onSeeAll: () => context.router.push(
              WorkoutScheduleRoute(workouts: workouts, profile: profile),
            ),
          ),
          const SizedBox(height: 15),
          // Empty state card
          const SizedBox(height: 30),
        ],
      );
    }

    return Column(
      children: [
        SectionHeader(
          title: " ${_getTodayName()}'s Workout ",
          count: workouts.length.toString(),
          onSeeAll: () => context.router.push(
            WorkoutScheduleRoute(workouts: workouts, profile: profile),
          ),
        ),
        const SizedBox(height: 15),
        WorkoutHeroCard(
          workout: todaysWorkout,
          profile: profile,
          isLarge: true,
        ),
        const SizedBox(height: 30),
      ],
    );
  }
}
