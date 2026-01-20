import 'package:fitness/common/res/colors.dart';
import 'package:fitness/features/notifications/presentation/widgets/empty_state_view.dart.dart';
import 'package:flutter/material.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class EmptyFavoritesView extends StatelessWidget {
  const EmptyFavoritesView({super.key});

  @override
  Widget build(BuildContext context) {
    return EmptyStateView(
      imagePath: 'assets/favorites.webp',
      floatingIcon: FontAwesomeIcons.bookmark,
      title: 'No bookmarks yet!',
      subtitle: 'Start adding your bookmarks workouts',
      iconColor: AppColors.primary,
    );
  }
}
