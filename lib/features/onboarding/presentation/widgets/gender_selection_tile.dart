// lib/features/onboarding/presentation/widgets/gender_selection_tile.dart

import 'package:flutter/material.dart';
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

  // Color constants matching the design (Orange)
  static const Color primaryColor = Colors.teal;
  static const Color darkTileColor = Color.fromARGB(255, 30, 30, 30);

  // Widget for the selection indicator (the radio button circle)
  Widget _buildSelectionIndicator() {
    return Container(
      width: 24,
      height: 24,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: isSelected ? primaryColor : Colors.transparent,
        border: Border.all(
          color: isSelected ? primaryColor : Colors.white38,
          width: 2,
        ),
      ),
      child: isSelected
          ? const Icon(
              Icons.check,
              size: 16,
              color: Colors.black, // Checkmark color
            )
          : null,
    );
  }

  // Widget for the main text/icon content (left side)
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
                color: Colors.white,
                size: 24,
              ),
              const SizedBox(height: 8),
              Text(
                title,
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      color: Colors.white,
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
            fit: BoxFit.cover,
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
          height: 150, // Fixed height for visual consistency
          decoration: BoxDecoration(
            color: darkTileColor,
            borderRadius: BorderRadius.circular(16.0),
            border: Border.all(
              color: isSelected ? primaryColor : Colors.transparent,
              width: 2.0,
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Left side (Text Content)
              Expanded(
                child: _buildTextContent(context),
              ),

              // Right side (Image Content)
              _buildImageContent(context),
            ],
          ),
        ),
      ),
    );
  }
}
