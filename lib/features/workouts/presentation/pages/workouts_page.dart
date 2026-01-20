// lib/features/workouts/presentation/pages/workouts_page.dart
import 'package:auto_route/auto_route.dart';
import 'package:fitness/common/helpers/app_router.gr.dart';
import 'package:fitness/common/res/colors.dart';
import 'package:fitness/features/workouts/presentation/widgets/empty_workouts_view.dart';
import 'package:fitness/features/workouts/presentation/widgets/atoms/section_header.dart';
import 'package:fitness/features/workouts/presentation/widgets/atoms/workout_hero_card.dart';
import 'package:fitness/features/workouts/presentation/widgets/atoms/workout_progress_card.dart';
import 'package:fitness/features/workouts/presentation/widgets/todays_workout_section.dart';
import 'package:fitness/features/workouts/presentation/widgets/workouts_app_bar.dart';
import 'package:fitness/features/workouts/presentation/widgets/exercise_shimmer.dart';
import 'package:fitness/features/workouts/presentation/widgets/workouts_dashboard_shimmer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fitness/features/onboarding/presentation/bloc/onboarding_bloc.dart';
import 'package:fitness/features/workouts/presentation/bloc/workouts_bloc.dart';

@RoutePage()
class WorkoutsPage extends StatefulWidget {
  const WorkoutsPage({super.key});

  @override
  State<WorkoutsPage> createState() => _WorkoutsPageState();
}

class _WorkoutsPageState extends State<WorkoutsPage> {
  @override
  void initState() {
    super.initState();
    context.read<OnboardingBloc>().add(CheckProfileStatusEvent());
  }

  void _loadWorkouts(String gender, String location) {
    context.read<WorkoutsBloc>().add(
          FetchWorkoutsEvent(gender: gender, location: location),
        );
  }

  @override
  Widget build(BuildContext context) {
    final bool dark = isDarkTheme(context);

    return Scaffold(
      backgroundColor: dark
          ? AppColors.backgroundDark.withValues(alpha: .2)
          : AppColors.backgroundLight,
      appBar: WorkoutsAppBar(onFilterTap: () => _showFilterDialog(context)),
      body: BlocConsumer<OnboardingBloc, OnboardingState>(
        listener: (context, onboardingState) {
          if (onboardingState is OnboardingProfileLoaded) {
            // Auto-load workouts once profile is known
            _loadWorkouts(onboardingState.profile.gender.toLowerCase(), '');
          }
        },
        builder: (context, onboardingState) {
          if (onboardingState is OnboardingProfileLoading) {
            return const Center(child: WorkoutsDashboardShimmer());
          }

          if (onboardingState is OnboardingProfileLoaded) {
            return _buildWorkoutsContent(onboardingState.profile);
          }

          return _buildEmptyState(
            icon: Icons.person_outline,
            message: "Complete your profile to see workouts",
            onRetry: () => context.router.push(WorkoutsRoute()),
            buttonText: "Skip to home page",
          );
        },
      ),
    );
  }

  /// Main Dashboard Content populated by WorkoutsBloc
  Widget _buildWorkoutsContent(dynamic profile) {
    return BlocBuilder<WorkoutsBloc, WorkoutsState>(
      builder: (context, state) {
        if (state is WorkoutsLoading) {
          return const ExerciseCardPlaceholder();
        }

        if (state is WorkoutsError) {
          return _buildEmptyState(
            icon: Icons.error_outline,
            message: state.message,
            onRetry: () => _loadWorkouts(profile.gender.toLowerCase(), 'both'),
          );
        }

        if (state is WorkoutsLoaded) {
          final workouts = state.workouts;
          if (workouts.isEmpty) {
            return EmptyWorkoutsView();
          }

          return SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Atomic: Progress Tracker
                WorkoutProgressCard(
                  percent: 0.75,
                  exercisesLeft: workouts.first.exercises.length,
                ),
                const SizedBox(height: 30),

                TodaysWorkoutSection(workouts: workouts, profile: profile),
                const SizedBox(height: 30),

                SectionHeader(
                  title: "Popular Exercise",
                  onSeeAll: () => context.router.push(
                      AllExercisesRoute(workouts: workouts, profile: profile)),
                ),
                const SizedBox(height: 15),

                // Horizontal List of Organisms
                SizedBox(
                  height: 180,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: workouts.length,
                    itemBuilder: (context, index) {
                      return WorkoutHeroCard(
                        workout: workouts[index],
                        profile: profile,
                        isLarge: false,
                      );
                    },
                  ),
                ),
                const SizedBox(height: 100),
              ],
            ),
          );
        }

        return const SizedBox.shrink();
      },
    );
  }

  // --- Helper Layouts (Scalability) ---

  Widget _buildEmptyState({
    required IconData icon,
    required String message,
    required VoidCallback onRetry,
    String buttonText = 'Retry',
  }) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 60, color: AppColors.textLight),
          const SizedBox(height: 16),
          Text(message, style: TextStyle(color: AppColors.textLight)),
          TextButton(
              onPressed: onRetry,
              child: Text(buttonText,
                  style: const TextStyle(color: AppColors.primary))),
        ],
      ),
    );
  }

  void _showFilterDialog(BuildContext context) {
    final state = context.read<OnboardingBloc>().state;
    if (state is! OnboardingProfileLoaded) return;

    showModalBottomSheet(
      context: context,
      backgroundColor:
          isDarkTheme(context) ? AppColors.cardDark : AppColors.cardLight,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(25))),
      builder: (_) => Padding(
        padding: const EdgeInsets.all(25),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                    color: AppColors.cardLight,
                    borderRadius: BorderRadius.circular(10))),
            const SizedBox(height: 20),
            const Text('Choose Environment',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 20),
            _filterTile(Icons.fitness_center, 'Gym Workouts',
                () => _loadWorkouts(state.profile.gender.toLowerCase(), 'gym')),
            _filterTile(
                Icons.home,
                'Home Workouts',
                () =>
                    _loadWorkouts(state.profile.gender.toLowerCase(), 'home')),
            _filterTile(
                Icons.all_inclusive,
                'Show Both',
                () =>
                    _loadWorkouts(state.profile.gender.toLowerCase(), 'both')),
          ],
        ),
      ),
    );
  }

  Widget _filterTile(IconData icon, String title, VoidCallback onTap) {
    return ListTile(
      leading: Icon(icon, color: AppColors.primary),
      title: Text(title),
      onTap: () {
        Navigator.pop(context);
        onTap();
      },
    );
  }
}
