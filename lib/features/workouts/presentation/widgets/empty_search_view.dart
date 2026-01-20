import 'package:fitness/features/notifications/presentation/widgets/empty_state_view.dart.dart';
import 'package:flutter/material.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class EmptySearchResultsView extends StatelessWidget {
  const EmptySearchResultsView({super.key});

  @override
  Widget build(BuildContext context) {
    return const EmptyStateView(
      imagePath: 'assets/search.webp',
      floatingIcon: FontAwesomeIcons.magnifyingGlass,
      title: 'No results found',
      subtitle: 'Try adjusting your search terms',
      iconColor: Colors.blue,
      floatingIconCount: 10,
    );
  }
}
