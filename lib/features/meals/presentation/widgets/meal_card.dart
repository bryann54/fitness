// lib/features/meals/presentation/widgets/meal_card.dart
import 'package:cached_network_image/cached_network_image.dart';
import 'package:fitness/common/res/colors.dart';
import 'package:fitness/features/meals/data/models/meal_model.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MealCard extends StatelessWidget {
  final MealModel meal;
  final VoidCallback onTap;

  const MealCard({
    super.key,
    required this.meal,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Hero(
        tag: 'meal_${meal.id}',
        child: Container(
          decoration: BoxDecoration(
            color: AppColors.cardDark,
            borderRadius: BorderRadius.circular(15),
            boxShadow: [
              BoxShadow(
                color: AppColors.cardDark.withValues(alpha: 0.3),
                blurRadius: 15,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Image Section with overlays
              Expanded(
                flex: 3,
                child: Stack(
                  children: [
                    // Background Image
                    Positioned.fill(
                      child: ClipRRect(
                        borderRadius: const BorderRadius.vertical(
                          top: Radius.circular(24),
                        ),
                        child: CachedNetworkImage(
                          imageUrl: meal.imageUrl,
                          fit: BoxFit.cover,
                          placeholder: (context, url) => Container(
                            color: AppColors.cardDark,
                            child: const Center(
                              child: CircularProgressIndicator.adaptive(
                                
                                strokeWidth: 2,
                              ),
                            ),
                          ),
                          errorWidget: (context, url, error) => Container(
                            color: AppColors.cardDark,
                            child: const Icon(
                              Icons.restaurant_menu,
                              size: 48,
                              color: AppColors.primary,
                            ),
                          ),
                        ),
                      ),
                    ),

                    // Gradient Overlay
                    Positioned.fill(
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: const BorderRadius.vertical(
                            top: Radius.circular(24),
                          ),
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              Colors.transparent,
                              AppColors.cardDark.withValues(alpha: 0.7),
                            ],
                            stops: const [0.5, 1.0],
                          ),
                        ),
                      ),
                    ),

                    // Diet Tag Badge
                    Positioned(
                      top: 12,
                      left: 12,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 5,
                        ),
                        decoration: BoxDecoration(
                          color: _getDietTagColor(meal.dietTag),
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                              color: AppColors.cardDark.withValues(alpha: 0.3),
                              blurRadius: 8,
                            ),
                          ],
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              _getDietTagIcon(meal.dietTag),
                              size: 12,
                              color: AppColors.cardLight,
                            ),
                            const SizedBox(width: 4),
                            Text(
                              meal.dietTag.toUpperCase(),
                              style: const TextStyle(
                                color: AppColors.cardLight,
                                fontSize: 9,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 1,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    // Category Badge
                    Positioned(
                      top: 12,
                      right: 12,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.cardDark.withValues(alpha: 0.6),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Text(
                          meal.category,
                          style: const TextStyle(
                            color: AppColors.cardLight,
                            fontSize: 9,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              // Content Section
              Expanded(
                flex: 2,
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Title
                      Text(
                        meal.uiTitle,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: GoogleFonts.poppins(
                          color: AppColors.cardLight,
                          fontWeight: FontWeight.bold,
                          fontSize: 13,
                          height: 1.2,
                        ),
                      ),

                      // Macros Row
                      Row(
                        children: [
                          _buildMacroInfo(
                            Icons.local_fire_department_rounded,
                            "${meal.caloriesLoseWeight}",
                          ),
                          const SizedBox(width: 12),
                          _buildMacroInfo(
                            Icons.fitness_center_rounded,
                            "${meal.proteinLoseWeight}g",
                            isPrimary: true,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMacroInfo(IconData icon, String label,
      {bool isPrimary = false}) {
    return Row(
      children: [
        Icon(
          icon,
          size: 14,
          color: isPrimary ? AppColors.primary : AppColors.cardLight,
        ),
        const SizedBox(width: 4),
        Text(
          label,
          style: TextStyle(
            color: isPrimary ? AppColors.primary : AppColors.cardLight,
            fontSize: 11,
            fontWeight: isPrimary ? FontWeight.bold : FontWeight.normal,
          ),
        ),
      ],
    );
  }

  Color _getDietTagColor(String dietTag) {
    switch (dietTag.toLowerCase()) {
      case 'vegan':
        return Colors.green;
      case 'keto':
        return Colors.orange;
      case 'traditional':
        return Colors.brown;
      default:
        return AppColors.primary;
    }
  }

  IconData _getDietTagIcon(String dietTag) {
    switch (dietTag.toLowerCase()) {
      case 'vegan':
        return Icons.eco;
      case 'keto':
        return Icons.local_fire_department;
      case 'traditional':
        return Icons.restaurant;
      default:
        return Icons.fastfood;
    }
  }
}
