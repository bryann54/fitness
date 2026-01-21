// lib/features/community/presentation/widgets/buddy_card.dart
import 'package:fitness/common/res/colors.dart';
import 'package:fitness/features/onboarding/data/models/fitness_profile_model.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

class BuddyCard extends StatelessWidget {
  final FitnessProfileModel profile;
  final VoidCallback onConnect;
  final int? compatibilityScore;

  const BuddyCard({
    super.key,
    required this.profile,
    required this.onConnect,
    this.compatibilityScore,
  });

  @override
  Widget build(BuildContext context) {
    final score = compatibilityScore ?? _calculateCompatibility();
    final sharedGoals = _getSharedGoals();

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.textLightDark.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: AppColors.textPrimaryDark.withValues(alpha: 0.1),
        ),
      ),
      child: Row(
        children: [
          // Avatar with compatibility badge
          Stack(
            children: [
              CircleAvatar(
                radius: 36,
                backgroundColor: AppColors.primary.withValues(alpha: 0.2),
                child: Text(
                  _getInitials(),
                  style: GoogleFonts.poppins(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: AppColors.primary,
                  ),
                ),
              ),
              Positioned(
                bottom: 0,
                right: 0,
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                  decoration: BoxDecoration(
                    color: _getCompatibilityColor(score),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: AppColors.cardDark,
                      width: 2,
                    ),
                  ),
                  child: Text(
                    '$score%',
                    style: GoogleFonts.poppins(
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(width: 16),

          // Info
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'User ${profile.uid.substring(0, 8)}',
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textPrimaryDark,
                  ),
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    Icon(
                      FontAwesomeIcons.fire,
                      size: 12,
                      color: _getCompatibilityColor(score),
                    ),
                    const SizedBox(width: 4),
                    Text(
                      '$score% Match',
                      style: GoogleFonts.poppins(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: _getCompatibilityColor(score),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Icon(
                      profile.gender == 'Male'
                          ? FontAwesomeIcons.mars
                          : FontAwesomeIcons.venus,
                      size: 12,
                      color: AppColors.textPrimaryDark.withValues(alpha: 0.6),
                    ),
                    const SizedBox(width: 4),
                    Text(
                      '${profile.age} years',
                      style: GoogleFonts.poppins(
                        fontSize: 11,
                        color: AppColors.textPrimaryDark.withValues(alpha: 0.6),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Wrap(
                  spacing: 6,
                  runSpacing: 6,
                  children: sharedGoals.map((goal) {
                    return Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.primary.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        goal,
                        style: GoogleFonts.poppins(
                          fontSize: 10,
                          color: AppColors.primary,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ],
            ),
          ),

          // Connect button
          IconButton(
            onPressed: onConnect,
            style: IconButton.styleFrom(
              backgroundColor: AppColors.primary,
              shape: const CircleBorder(),
            ),
            icon: const Icon(
              FontAwesomeIcons.userPlus,
              color: Colors.white,
              size: 18,
            ),
          ),
        ],
      ),
    );
  }

  String _getInitials() {
    return profile.uid.substring(0, 2).toUpperCase();
  }

  int _calculateCompatibility() {
    // Simple compatibility calculation based on shared attributes
    int score = 50; // Base score

    // Same fitness goal: +20
    // Same workout preferences: +15
    // Similar experience level: +10
    // Same gender: +5

    // This is simplified - you can make it more complex
    return score + (20) + (15); // Returns 85 as example
  }

  List<String> _getSharedGoals() {
    final goals = <String>[];

    // Add fitness goal
    final goalName = profile.primaryGoal.toString().split('.').last;
    goals.add(_formatGoalName(goalName));

    // Add workout preferences (max 2)
    if (profile.workoutPreferences.isNotEmpty) {
      goals.add(profile.workoutPreferences.first);
    }

    return goals;
  }

  String _formatGoalName(String goal) {
    switch (goal) {
      case 'loseWeight':
        return 'Lose Weight';
      case 'gainMuscle':
        return 'Gain Muscle';
      case 'improveEndurance':
        return 'Endurance';
      case 'maintenance':
        return 'Maintain';
      default:
        return goal;
    }
  }

  Color _getCompatibilityColor(int score) {
    if (score >= 80) return Colors.green;
    if (score >= 60) return Colors.orange;
    return Colors.red;
  }
}
