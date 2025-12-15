// lib/features/workouts/presentation/pages/workouts_page.dart

import 'package:auto_route/auto_route.dart';
import 'package:fitness/common/widgets/welcome_header.dart';
import 'package:fitness/core/di/injector.dart';
import 'package:fitness/features/auth/presentation/bloc/auth_bloc.dart'; // Import AuthBloc
import 'package:fitness/features/workouts/presentation/bloc/workouts_bloc.dart';
import 'package:fitness/features/workouts/presentation/widgets/category_selector.dart';
import 'package:fitness/features/workouts/presentation/widgets/upper_body_workout_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

@RoutePage()
class WorkoutsPage extends StatelessWidget {
  const WorkoutsPage({super.key});

  // Helper method to extract first name safely
  String _getFirstNameFromAuthState(AuthState state) {
    if (state is AuthAuthenticated) {
      // Assuming UserModel has a firstName property
      return state.user.firstName ?? 'User';
    }
    return 'Guest';
  }

  @override
  Widget build(BuildContext context) {
    // We use MultiBlocProvider implicitly since AuthBloc is provided higher up (in main.dart)
    return BlocProvider(
      create: (context) => getIt<WorkoutsBloc>()
        ..add(GetCategoriesEvent()), // Load categories on creation
      // Remove misplaced 'String? firstName;' here
      child: Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    BlocBuilder<AuthBloc, AuthState>(
                      builder: (context, state) {
                        final firstName = _getFirstNameFromAuthState(state);
                        return WelcomeHeader(firstName: firstName);
                      },
                    ),
                    Container(
                      margin: const EdgeInsets.only(left: 8.0),
                      padding: const EdgeInsets.all(8.0),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.grey.shade500,
                        ),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.notifications_none,
                        size: 24,
                      ),
                    ),
                  ],
                ),
                // -----------------------------------------------------

                // Featured Workout Card
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.0),
                  child: UpperBodyWorkoutCard(),
                ),

                const SizedBox(height: 32),

                // Category Selector
                const Padding(
                  padding: EdgeInsets.only(left: 20.0, bottom: 16.0),
                  child: Text(
                    'Popular Exercise',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
                const CategorySelector(), // This is the API-driven widget

                const SizedBox(height: 20),

                // TODO: Add Exercises List Widget here
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Text(
                    'Today Workouts (17)',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
                // This area will eventually show the detailed list of exercises.
              ],
            ),
          ),
        ),
      ),
    );
  }
}
