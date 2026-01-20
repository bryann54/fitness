import 'package:fitness/features/notifications/presentation/widgets/empty_state_view.dart.dart';
import 'package:flutter/material.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class EmptyHistoryView extends StatelessWidget {
  const EmptyHistoryView({super.key});

  @override
  Widget build(BuildContext context) {
    return const EmptyStateView(
      imagePath: 'assets/history.webp',
      floatingIcon: FontAwesomeIcons.clockRotateLeft,
      title: 'No workout history',
      subtitle: 'Complete your first workout to see it here',
      iconColor: Colors.purple,
    );
  }
}
