import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:fitness/common/res/colors.dart';
import 'package:fitness/features/account/presentation/widgets/section_header_widget.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

@RoutePage()
class TipsTricksScreen extends StatelessWidget {
  const TipsTricksScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: _buildAppBar(context, colorScheme),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildWelcomeSection(colorScheme),
            const SizedBox(height: 32),
            _buildTipsSection(context, colorScheme),
            const SizedBox(height: 32),
            _buildPromptingSection(context, colorScheme),
            const SizedBox(height: 32),
            _buildUnderstandingAISection(context, colorScheme),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  PreferredSizeWidget _buildAppBar(
      BuildContext context, ColorScheme colorScheme) {
    return AppBar(
      title: Text(
        'fitness Guru Tips',
        style: GoogleFonts.montserrat(
          fontWeight: FontWeight.w600,
          color: colorScheme.onSurface,
        ),
      ),
      backgroundColor: colorScheme.surface,
      elevation: 0,
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(1),
        child: Divider(
          height: 1,
          color: colorScheme.onSurface.withValues(alpha: 0.1),
        ),
      ),
    );
  }

  Widget _buildWelcomeSection(ColorScheme colorScheme) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: colorScheme.primary.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: colorScheme.primary.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: FaIcon(
                  FontAwesomeIcons.robot,
                  color: AppColors.primary,
                  size: 24,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Text(
                  'Mastering fitness Guru',
                  style: GoogleFonts.montserrat(
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                    color: colorScheme.onSurface,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            'Unlock the full potential of your fitness Guru assistant with these expert tips and tricks.',
            style: GoogleFonts.montserrat(
              fontSize: 14,
              color: colorScheme.onSurfaceVariant,
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTipsSection(BuildContext context, ColorScheme colorScheme) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SectionHeaderWidget(title: 'Getting Started with fitness Guru'),
        const SizedBox(height: 16),
        ..._buildTipItems(context, _getFitnessUsageTips(), colorScheme),
      ],
    );
  }

  Widget _buildPromptingSection(BuildContext context, ColorScheme colorScheme) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SectionHeaderWidget(title: 'Crafting Effective Prompts'),
        const SizedBox(height: 16),
        ..._buildTipItems(context, _getPromptingTips(), colorScheme),
      ],
    );
  }

  Widget _buildUnderstandingAISection(
      BuildContext context, ColorScheme colorScheme) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SectionHeaderWidget(title: 'Understanding AI Advice'),
        const SizedBox(height: 16),
        ..._buildTipItems(context, _getAIBestPracticesTips(), colorScheme),
      ],
    );
  }

  List<Widget> _buildTipItems(BuildContext context,
      List<Map<String, dynamic>> tips, ColorScheme colorScheme) {
    return tips
        .map((tip) => _buildTipCard(
              context,
              icon: tip['icon'],
              title: tip['title'],
              description: tip['description'],
              isNew: tip['isNew'] ?? false,
              colorScheme: colorScheme,
            ))
        .toList();
  }

  Widget _buildTipCard(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String description,
    bool isNew = false,
    required ColorScheme colorScheme,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: colorScheme.outlineVariant,
          width: 0.5,
        ),
        boxShadow: [
          BoxShadow(
            color: colorScheme.shadow.withValues(alpha: 0.03),
            blurRadius: 4,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: AppColors.primary.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: FaIcon(
              icon,
              color: AppColors.primary,
              size: 20,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        title,
                        style: GoogleFonts.montserrat(
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                          color: colorScheme.onSurface,
                        ),
                      ),
                    ),
                    if (isNew) ...[
                      const SizedBox(width: 8),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: AppColors.secondary,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          'NEW',
                          style: GoogleFonts.montserrat(
                            fontSize: 10,
                            fontWeight: FontWeight.w700,
                            color: colorScheme.onPrimary,
                          ),
                        ),
                      ),
                    ],
                  ],
                ),
                const SizedBox(height: 8),
                Text(
                  description,
                  style: GoogleFonts.montserrat(
                    fontSize: 14,
                    color: colorScheme.onSurfaceVariant,
                    height: 1.5,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // --- fitness Guru Specific Tips ---

  List<Map<String, dynamic>> _getFitnessUsageTips() {
    return [
      {
        'icon': FontAwesomeIcons.dumbbell,
        'title': 'Start with Clear Fitness Goals',
        'description':
            'Begin by telling the AI your specific fitness goals (weight loss, muscle gain, endurance). E.g., "I want to lose 10kg in 3 months"',
        'isNew': false,
      },
      {
        'icon': FontAwesomeIcons.heartPulse,
        'title': 'Share Your Health Details',
        'description':
            'For personalized advice, share your age, weight, fitness level, and any health conditions. The more details, the better the plan.',
        'isNew': false,
      },
      {
        'icon': FontAwesomeIcons.calendarCheck,
        'title': 'Track Your Progress',
        'description':
            'The AI remembers your previous workouts and nutrition logs. Update it regularly for personalized adjustments to your plan.',
        'isNew': false,
      },
    ];
  }

  List<Map<String, dynamic>> _getPromptingTips() {
    return [
      {
        'icon': FontAwesomeIcons.rulerVertical,
        'title': 'Be Specific with Measurements',
        'description':
            'Include specific details like current weight, target weight, available equipment, and time constraints for tailored workouts.',
        'isNew': true,
      },
      {
        'icon': FontAwesomeIcons.listCheck,
        'title': 'Break Down Your Routine',
        'description':
            'Ask for separate components: warm-up, main workout, cool-down. This helps structure your fitness sessions effectively.',
        'isNew': false,
      },
      {
        'icon': FontAwesomeIcons.utensils,
        'title': 'Request Meal Plan Variations',
        'description':
            'Ask for different meal options based on dietary preferences (vegetarian, keto, etc.) or specific calorie targets.',
        'isNew': false,
      },
    ];
  }

  List<Map<String, dynamic>> _getAIBestPracticesTips() {
    return [
      {
        'icon': FontAwesomeIcons.userMd,
        'title': 'AI Guidance, Not Medical Advice',
        'description':
            'This AI provides fitness guidance only. Always consult healthcare professionals before starting new exercise or diet programs.',
        'isNew': false,
      },
      {
        'icon': FontAwesomeIcons.earListen,
        'title': 'Listen to Your Body',
        'description':
            'The AI suggests workouts based on data. Adjust intensity based on how you feel during and after exercise.',
        'isNew': false,
      },
      {
        'icon': FontAwesomeIcons.repeat,
        'title': 'Adjust Based on Results',
        'description':
            'If a workout routine isn\'t working, ask the AI to modify it. Fitness is personal and needs regular adjustments.',
        'isNew': true,
      },
      {
        'icon': FontAwesomeIcons.comment,
        'title': 'Provide Feedback',
        'description':
            'Tell the AI what worked and what didn\'t. Your feedback helps it create better personalized plans for you.',
        'isNew': true,
      },
    ];
  }
}
