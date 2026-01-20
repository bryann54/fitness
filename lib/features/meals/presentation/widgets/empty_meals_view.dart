import 'package:fitness/features/notifications/presentation/widgets/empty_state_view.dart.dart';
import 'package:flutter/material.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class EmptyMealsView extends StatelessWidget {
  final VoidCallback? onAddMeal;

  const EmptyMealsView({
    super.key,
    this.onAddMeal,
  });

  @override
  Widget build(BuildContext context) {
    return EmptyStateView(
      imagePath: 'assets/meals.webp',
      floatingIcon: FontAwesomeIcons.utensils,
      title: 'No meals planned',
      subtitle: 'Add your first meal to get started',
      iconColor: Colors.green,
      actionButton: onAddMeal != null
          ? ElevatedButton.icon(
              onPressed: onAddMeal,
              icon: const Icon(FontAwesomeIcons.plus),
              label: const Text('Add Meal'),
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
