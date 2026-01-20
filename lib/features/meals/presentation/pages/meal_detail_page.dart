// lib/features/meals/presentation/pages/meal_detail_page.dart
import 'package:auto_route/auto_route.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:fitness/common/res/colors.dart';
import 'package:fitness/features/favourites/presentation/widgets/favourite_button.dart';
import 'package:fitness/features/meals/data/models/meal_model.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_animate/flutter_animate.dart';

@RoutePage()
class MealDetailPage extends StatelessWidget {
  final MealModel meal;

  const MealDetailPage({super.key, required this.meal});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.cardDark,
      body: CustomScrollView(
        slivers: [
          // Hero Image Header
          SliverAppBar(
            expandedHeight: 400,
            pinned: true,
            backgroundColor: AppColors.cardDark,
            leading: IconButton(
              icon: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: AppColors.cardDark.withValues(alpha: 0.5),
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.arrow_back, color: AppColors.cardLight),
              ),
              onPressed: () => Navigator.pop(context),
            ),
            actions: [
              Container(
                margin: const EdgeInsets.only(right: 8),
                padding: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                  color: AppColors.cardDark.withValues(alpha: 0.5),
                  shape: BoxShape.circle,
                ),
                child: FavouriteButton(
                  meal: meal,
                  iconColor: AppColors.cardLight,
                  iconSize: 24,
                ),
              ),
            ],
            flexibleSpace: FlexibleSpaceBar(
              background: Hero(
                tag: 'meal_${meal.id}',
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    CachedNetworkImage(
                      imageUrl: meal.imageUrl,
                      fit: BoxFit.cover,
                      placeholder: (context, url) => Container(
                        color: AppColors.cardDark,
                        child: const Center(
                          child: CircularProgressIndicator(
                            color: AppColors.primary,
                          ),
                        ),
                      ),
                      errorWidget: (context, url, error) => Container(
                        color: AppColors.cardDark,
                        child: const Icon(
                          Icons.restaurant_menu,
                          size: 80,
                          color: AppColors.primary,
                        ),
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Colors.transparent,
                            AppColors.cardDark.withValues(alpha: 0.8),
                          ],
                          stops: const [0.6, 1.0],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          // Content Section
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Category & Diet Tags
                  Row(
                    children: [
                      _buildBadge(
                        meal.category,
                        AppColors.primary.withValues(alpha: 0.2),
                        AppColors.primary,
                      ),
                      const SizedBox(width: 10),
                      _buildBadge(
                        meal.dietTag,
                        _getDietTagColor(meal.dietTag).withValues(alpha: 0.2),
                        _getDietTagColor(meal.dietTag),
                      ),
                    ],
                  ).animate().fadeIn(delay: 100.ms).slideX(begin: -0.2),

                  const SizedBox(height: 20),

                  // Title
                  Text(
                    meal.uiTitle,
                    style: GoogleFonts.poppins(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: AppColors.cardLight,
                      height: 1.2,
                    ),
                  ).animate().fadeIn(delay: 200.ms).slideX(begin: -0.2),

                  const SizedBox(height: 24),

                  // Macros Grid
                  Row(
                    children: [
                      Expanded(
                        child: _buildMacroCard(
                          'Calories',
                          '${meal.caloriesLoseWeight}',
                          'kcal',
                          Icons.local_fire_department,
                          Colors.orange,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: _buildMacroCard(
                          'Protein',
                          '${meal.proteinLoseWeight}',
                          'g',
                          Icons.fitness_center,
                          AppColors.primary,
                        ),
                      ),
                    ],
                  ).animate().fadeIn(delay: 300.ms).slideY(begin: 0.2),

                  const SizedBox(height: 30),

                  // Portions Section
                  Text(
                    'Portions',
                    style: GoogleFonts.poppins(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: AppColors.cardLight,
                    ),
                  ).animate().fadeIn(delay: 400.ms),

                  const SizedBox(height: 15),

                  _buildPortionCard(
                    'Weight Loss',
                    meal.loseWeightPortion,
                    meal.caloriesLoseWeight,
                    meal.proteinLoseWeight,
                  ).animate().fadeIn(delay: 450.ms).slideX(begin: -0.1),

                  const SizedBox(height: 12),

                  _buildPortionCard(
                    'Muscle Gain',
                    meal.gainMusclePortion,
                    meal.caloriesGainMuscle,
                    meal.proteinGainMuscle,
                  ).animate().fadeIn(delay: 500.ms).slideX(begin: -0.1),

                  const SizedBox(height: 30),

                  // Preparation Instructions
                  Text(
                    'How to Prepare',
                    style: GoogleFonts.poppins(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: AppColors.cardLight,
                    ),
                  ).animate().fadeIn(delay: 550.ms),

                  const SizedBox(height: 15),

                  Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: AppColors.cardDark,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      meal.howToPrepare,
                      style: TextStyle(
                        color: AppColors.cardLight.withValues(alpha: 0.8),
                        fontSize: 15,
                        height: 1.6,
                      ),
                    ),
                  ).animate().fadeIn(delay: 600.ms).slideY(begin: 0.1),

                  const SizedBox(height: 100),
                ],
              ),
            ),
          ),
        ],
      ),

      // Bottom Action Button
      floatingActionButton: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: FloatingActionButton.extended(
          onPressed: () {
            // TODO: Add to meal plan
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Added to your meal plan!'),
                backgroundColor: AppColors.primary,
              ),
            );
          },
          backgroundColor: AppColors.primary,
          icon: const Icon(Icons.add_circle_outline, color: AppColors.cardDark),
          label: Text(
            'Add to Meal Plan',
            style: GoogleFonts.poppins(
              color: AppColors.cardDark,
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
        ),
      ).animate().fadeIn(delay: 800.ms).slideY(begin: 0.5),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  Widget _buildBadge(String text, Color bgColor, Color textColor) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        text.toUpperCase(),
        style: TextStyle(
          color: textColor,
          fontSize: 11,
          fontWeight: FontWeight.bold,
          letterSpacing: 1.2,
        ),
      ),
    );
  }

  Widget _buildMacroCard(
    String label,
    String value,
    String unit,
    IconData icon,
    Color color,
  ) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.cardDark,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        children: [
          Icon(icon, color: color, size: 28),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                value,
                style: GoogleFonts.poppins(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: AppColors.cardLight,
                ),
              ),
              const SizedBox(width: 4),
              Padding(
                padding: const EdgeInsets.only(bottom: 4),
                child: Text(
                  unit,
                  style: TextStyle(
                    fontSize: 12,
                    color: AppColors.cardLight.withValues(alpha: 0.6),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              color: AppColors.cardLight.withValues(alpha: 0.6),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPortionCard(
    String title,
    String portion,
    int calories,
    int protein,
  ) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.cardDark,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: AppColors.cardLight.withValues(alpha: 0.1),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: GoogleFonts.poppins(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: AppColors.primary,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            portion,
            style: TextStyle(
              color: AppColors.cardLight.withValues(alpha: 0.9),
              fontSize: 14,
            ),
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              _buildSmallMacro(Icons.local_fire_department, '$calories kcal'),
              const SizedBox(width: 16),
              _buildSmallMacro(Icons.fitness_center, '${protein}g protein'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSmallMacro(IconData icon, String text) {
    return Row(
      children: [
        Icon(icon, size: 16, color: AppColors.cardLight),
        const SizedBox(width: 4),
        Text(
          text,
          style: TextStyle(
            color: AppColors.cardLight,
            fontSize: 12,
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
}
