// lib/features/workouts/presentation/widgets/exercise_card.dart
import 'package:fitness/common/res/colors.dart';
import 'package:fitness/features/workouts/presentation/widgets/exercise_shimmer.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:fitness/features/workouts/data/models/workout_model.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_animate/flutter_animate.dart';

class ExerciseCard extends StatefulWidget {
  final ExerciseModel exercise;
  final int index;

  const ExerciseCard({super.key, required this.exercise, required this.index});

  @override
  State<ExerciseCard> createState() => _ExerciseCardState();
}

class _ExerciseCardState extends State<ExerciseCard> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    final bool dark = isDarkTheme(context);

    return GestureDetector(
      onTap: () => setState(() => _isExpanded = !_isExpanded),
      child: AnimatedContainer(
        duration: 400.ms,
        curve: Curves.bounceOut,
        margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: dark ? AppColors.cardDark : AppColors.cardLight,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: _isExpanded
                ? AppColors.primary.withOpacity(0.5)
                : (dark
                    ? AppColors.borderColorDark
                    : AppColors.borderColorLight),
          ),
          boxShadow: _isExpanded
              ? [
                  BoxShadow(
                    color: AppColors.primary.withOpacity(0.1),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  )
                ]
              : null,
        ),
        child: Column(
          children: [
            Row(
              children: [
                // Index
                SizedBox(
                  width: 30,
                  child: Text(
                    "${widget.index}",
                    style: GoogleFonts.poppins(
                      color:
                          dark ? AppColors.textLightDark : AppColors.textLight,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                ),

                // Image Hero
                Hero(
                  tag: 'exercise_img_${widget.exercise.exercise}',
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: CachedNetworkImage(
                      imageUrl: widget.exercise.imageUrl,
                      width: 65,
                      height: 65,
                      fit: BoxFit.cover,
                      placeholder: (context, url) =>
                          const ExerciseShimmerThumbnail(),
                    ),
                  ),
                ),
                const SizedBox(width: 15),

                // Details
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.exercise.exercise,
                        style: GoogleFonts.poppins(
                          color: dark
                              ? AppColors.textPrimaryDark
                              : AppColors.textPrimary,
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          _buildBadge(
                              context, Icons.repeat, widget.exercise.sets),
                          const SizedBox(width: 12),
                          _buildBadge(context, Icons.fitness_center,
                              widget.exercise.reps),
                        ],
                      ),
                    ],
                  ),
                ),

                Icon(
                  Icons.expand_more,
                  color: dark ? AppColors.textLightDark : AppColors.textLight,
                )
                    .animate(target: _isExpanded ? 1 : 0)
                    .rotate(begin: 0, end: 0.5),
              ],
            ),

            // Expandable Notes
            ClipRect(
              child: AnimatedAlign(
                duration: 400.ms,
                curve: Curves.bounceOut,
                alignment: Alignment.topCenter,
                heightFactor: _isExpanded ? 1.0 : 0.0,
                child: Padding(
                  padding: const EdgeInsets.only(top: 15, left: 45),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Divider(
                          color: dark
                              ? AppColors.dividerColor
                              : AppColors.borderColorLight),
                      const SizedBox(height: 8),
                      Text(
                        "NOTES",
                        style: GoogleFonts.poppins(
                          color: AppColors.primary,
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1.5,
                        ),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        widget.exercise.notes,
                        style: GoogleFonts.poppins(
                          color: dark
                              ? AppColors.textSecondaryDark
                              : AppColors.textSecondary,
                          fontSize: 13,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ).animate().fadeIn(duration: 300.ms).slideX(begin: 0.05, end: 0),
    );
  }

  Widget _buildBadge(BuildContext context, IconData icon, String text) {
    final bool dark = isDarkTheme(context);
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 14, color: AppColors.primary),
        const SizedBox(width: 4),
        Text(
          text,
          style: GoogleFonts.poppins(
            color: dark ? AppColors.textLightDark : AppColors.textLight,
            fontSize: 12,
          ),
        ),
      ],
    );
  }
}
