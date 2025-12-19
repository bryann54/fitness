// lib/features/workouts/presentation/widgets/organisms/workouts_dashboard_shimmer.dart
import 'package:fitness/common/res/colors.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class WorkoutsDashboardShimmer extends StatelessWidget {
  const WorkoutsDashboardShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    final bool dark = isDarkTheme(context);
    final baseColor = dark ? AppColors.cardDark : Colors.grey[300]!;
    final highlightColor = dark ? const Color(0xFF3A3A3A) : Colors.grey[100]!;

    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Shimmer.fromColors(
        baseColor: baseColor,
        highlightColor: highlightColor,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 1. Progress Card Shimmer
            Container(
              height: 100,
              decoration: BoxDecoration(
                color: baseColor,
                borderRadius: BorderRadius.circular(25),
              ),
            ),
            const SizedBox(height: 30),

            // 2. Section Header Shimmer
            _buildHeaderShimmer(baseColor),
            const SizedBox(height: 15),

            // 3. Featured Hero Card Shimmer
            Container(
              height: 220,
              decoration: BoxDecoration(
                color: baseColor,
                borderRadius: BorderRadius.circular(25),
              ),
            ),
            const SizedBox(height: 30),

            // 4. Second Section Header
            _buildHeaderShimmer(baseColor),
            const SizedBox(height: 15),

            // 5. Horizontal List Shimmer
            SizedBox(
              height: 160,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: 3,
                itemBuilder: (_, __) => Container(
                  width: 260,
                  margin: const EdgeInsets.only(right: 15),
                  decoration: BoxDecoration(
                    color: baseColor,
                    borderRadius: BorderRadius.circular(25),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeaderShimmer(Color color) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
            width: 150,
            height: 20,
            decoration: BoxDecoration(
                color: color, borderRadius: BorderRadius.circular(4))),
        Container(
            width: 50,
            height: 15,
            decoration: BoxDecoration(
                color: color, borderRadius: BorderRadius.circular(4))),
      ],
    );
  }
}
