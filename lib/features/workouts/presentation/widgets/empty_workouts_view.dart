import 'package:fitness/features/notifications/presentation/widgets/empty_state_view.dart.dart';
import 'package:flutter/material.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class EmptyWorkoutsView extends StatelessWidget {
  final VoidCallback? onBrowseWorkouts;

  const EmptyWorkoutsView({
    super.key,
    this.onBrowseWorkouts,
  });

  @override
  Widget build(BuildContext context) {
    return EmptyStateView(
      imagePath: 'assets/workouts.webp',
      floatingIcon: FontAwesomeIcons.dumbbell,
      title: 'No workouts found!',
      subtitle: 'Start your fitness journey today',
      iconColor: Colors.orange,
      actionButton: onBrowseWorkouts != null
          ? ElevatedButton.icon(
              onPressed: onBrowseWorkouts,
              icon: const Icon(FontAwesomeIcons.fire),
              label: const Text('Browse Workouts'),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 12,
                ),
              ),
            )
          : null,
    );
  }
}
