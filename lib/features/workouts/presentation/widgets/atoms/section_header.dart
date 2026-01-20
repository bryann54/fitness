// lib/features/workouts/presentation/widgets/atoms/section_header.dart

import 'package:fitness/common/res/colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SectionHeader extends StatelessWidget {
  final String title;
  final String? count;
  final VoidCallback? onSeeAll;

  const SectionHeader(
      {super.key, required this.title, this.count, this.onSeeAll});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        RichText(
          text: TextSpan(
            text: title,
            style: GoogleFonts.poppins(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: AppColors.cardLight),
            children: count != null
                ? [
                    TextSpan(
                        text: " ($count)",
                        style: const TextStyle(
                            color: AppColors.cardLight, fontSize: 14))
                  ]
                : [],
          ),
        ),
        if (onSeeAll != null)
          GestureDetector(
            onTap: onSeeAll,
            child: const Text("See all",
                style: TextStyle(
                    color: AppColors.primary, fontWeight: FontWeight.w600)),
          ),
      ],
    );
  }
}
