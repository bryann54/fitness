// lib/features/onboarding/presentation/widgets/gender_selection_tile.dart

import 'package:fitness/common/res/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

// --- Widget Definition ---

class GenderSelectionTile extends StatelessWidget {
  final String title;
  final IconData icon;
  final String imagePath;
  final bool isSelected;
  final VoidCallback onTap;

  const GenderSelectionTile({
    super.key,
    required this.title,
    required this.icon,
    required this.imagePath,
    required this.isSelected,
    required this.onTap,
  });

  Widget _buildSelectionIndicator() {
    return Container(
      width: 24,
      height: 24,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: isSelected ? AppColors.primary : Colors.transparent,
        border: Border.all(
          color: isSelected
              ? AppColors.primary
              : AppColors.visualLightBackgroundHalf,
          width: 2,
        ),
      ),
      child: isSelected
          ? const Icon(
              Icons.check,
              size: 16,
              color: Colors.black,
            )
          : null,
    )
        .animate(
          delay: 100.ms,
        )
        .fadeIn(duration: 500.ms, curve: Curves.easeOut)
        .scale(
            begin: const Offset(0.8, 0.8),
            end: const Offset(1.0, 1.0),
            duration: 500.ms,
            curve: Curves.easeOut);
  }

  Widget _buildTextContent(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 16.0, bottom: 16.0, left: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Icon and Title
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              FaIcon(
                icon,
                color: AppColors.visualLightBackgroundHalf,
                size: 24,
              ),
              const SizedBox(height: 8),
              Text(
                title,
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      color: AppColors.visualLightBackgroundHalf,
                      fontWeight: FontWeight.bold,
                    ),
              ),
            ],
          ),

          // Selection Indicator (Radio button)
          _buildSelectionIndicator(),
        ],
      ),
    );
  }

  // Widget for the image (right side)
  Widget _buildImageContent(BuildContext context) {
    // Determine the width for the image to leave space for text
    final double imageWidth = MediaQuery.of(context).size.width * 0.45;

    return ClipRRect(
      borderRadius: const BorderRadius.only(
        topRight: Radius.circular(14.0),
        bottomRight: Radius.circular(14.0),
      ),
      child: ColorFiltered(
        colorFilter: const ColorFilter.mode(
          Colors.black45,
          BlendMode.darken,
        ),
        child: SizedBox(
          width: imageWidth,
          height: double.infinity,
          child: Image.asset(
            imagePath,
            fit: BoxFit.contain,
            alignment: Alignment.centerRight,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: InkWell(
        onTap: onTap,
        child: Container(
          height: 150,
          decoration: BoxDecoration(
            color: AppColors.cardDark,
            borderRadius: BorderRadius.circular(16.0),
            border: Border.all(
              color: isSelected ? AppColors.primary : Colors.transparent,
              width: 2.0,
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: _buildTextContent(context),
              ),
              _buildImageContent(context),
            ],
          ),
        )
            .animate(
              delay: 100.ms,
            )
            .fadeIn(duration: 600.ms, curve: Curves.easeOut)
            .slideX(
                begin: 0.2, end: 0, duration: 600.ms, curve: Curves.easeOut),
      ),
    );
  }
}
