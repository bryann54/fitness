// lib/features/workouts/presentation/widgets/workouts_app_bar.dart
import 'package:auto_route/auto_route.dart';
import 'package:fitness/common/helpers/app_router.gr.dart';
import 'package:fitness/common/widgets/welcome_header.dart';
import 'package:fitness/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class WorkoutsAppBar extends StatelessWidget implements PreferredSizeWidget {
  final VoidCallback onFilterTap;

  const WorkoutsAppBar({super.key, required this.onFilterTap});

  String _extractFirstName(AuthState state) {
    if (state is AuthAuthenticated) {
      return state.user.firstName ?? 'User';
    }
    return 'Guest';
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            BlocBuilder<AuthBloc, AuthState>(
              builder: (context, state) {
                return WelcomeHeader(firstName: _extractFirstName(state));
              },
            ),
            Row(
              children: [
                // Filter Icon to trigger the dialog
                IconButton(
                  onPressed: onFilterTap,
                  icon: const Icon(Icons.tune, color: Colors.grey),
                ),
                GestureDetector(
                  onTap: () {
                    context.router.push(const NotificationsRoute());
                  },
                  child: Container(
                    padding: const EdgeInsets.all(8.0),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey.shade300),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(Icons.notifications_none, size: 24),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(100);
}
