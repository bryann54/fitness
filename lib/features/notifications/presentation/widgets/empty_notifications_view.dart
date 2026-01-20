import 'package:fitness/features/notifications/presentation/widgets/empty_state_view.dart.dart';
import 'package:flutter/material.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class EmptyNotificationsView extends StatelessWidget {
  const EmptyNotificationsView({super.key});

  @override
  Widget build(BuildContext context) {
    return const EmptyStateView(
      imagePath: 'assets/notifications.webp',
      floatingIcon: FontAwesomeIcons.solidBell,
      title: 'No notifications yet!',
      subtitle: 'Your notifications will appear here',
      iconColor: Colors.cyan,
    );
  }
}

class EmptyProgressView extends StatelessWidget {
  const EmptyProgressView({super.key});

  @override
  Widget build(BuildContext context) {
    return const EmptyStateView(
      imagePath: 'assets/progress.webp',
      floatingIcon: FontAwesomeIcons.chartLine,
      title: 'No progress data',
      subtitle: 'Track your workouts to see your progress',
      iconColor: Colors.teal,
    );
  }
}

class EmptyTodaysWorkoutView extends StatelessWidget {
  final VoidCallback? onViewSchedule;

  const EmptyTodaysWorkoutView({
    super.key,
    this.onViewSchedule,
  });

  @override
  Widget build(BuildContext context) {
    return EmptyStateView(
      imagePath: 'assets/rest_day.webp',
      floatingIcon: FontAwesomeIcons.spa,
      title: 'Rest Day!',
      subtitle: 'No workout scheduled for today. Take time to recover.',
      iconColor: Colors.indigo,
      actionButton: onViewSchedule != null
          ? TextButton.icon(
              onPressed: onViewSchedule,
              icon: const Icon(FontAwesomeIcons.calendarDays),
              label: const Text('View Schedule'),
            )
          : null,
    );
  }
}
