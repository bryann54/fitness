import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:fitness/common/res/colors.dart';
import 'package:fitness/features/account/presentation/widgets/section_header_widget.dart';
import 'package:fitness/features/account/presentation/widgets/support_card_widget.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

@RoutePage()
class HelpSupportScreen extends StatelessWidget {
  const HelpSupportScreen({super.key});

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
            _buildContactSection(context, colorScheme),
            const SizedBox(height: 32),
            _buildFAQSection(context, colorScheme),
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
        'Help & Support',
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
                  FontAwesomeIcons.circleQuestion,
                  color: AppColors.primary,
                  size: 24,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Text(
                  'Need Help With Your Fitness Journey?',
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
            'We\'re here to help you achieve your fitness goals. Contact us for support with workouts, nutrition plans, or app features.',
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

  Widget _buildContactSection(BuildContext context, ColorScheme colorScheme) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SectionHeaderWidget(title: 'Contact Us'),
        const SizedBox(height: 16),
        SupportCardWidget(
          icon: FontAwesomeIcons.envelope,
          title: 'Email: support@fitnessapp.com',
          onTap: () => _sendEmail(context),
          colorScheme: colorScheme,
        ),
        SupportCardWidget(
          icon: FontAwesomeIcons.phone,
          title: 'Phone: +254 7 1234-5678',
          onTap: () => _callSupport(context),
          colorScheme: colorScheme,
        ),
        SupportCardWidget(
          icon: FontAwesomeIcons.clock,
          title: 'Hours: Mon-Fri 8AM-8PM EST',
          onTap: () {},
          colorScheme: colorScheme,
        ),
      ],
    );
  }

  Widget _buildFAQSection(BuildContext context, ColorScheme colorScheme) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SectionHeaderWidget(title: 'Frequently Asked Questions'),
        const SizedBox(height: 16),
        ..._buildFAQItems(context, colorScheme),
      ],
    );
  }

  List<Widget> _buildFAQItems(BuildContext context, ColorScheme colorScheme) {
    final faqs = [
      {
        'question': 'How do I create a personalized workout plan?',
        'answer':
            'Go to the Workouts section and click "Create Plan." The AI will ask about your goals, fitness level, available equipment, and time commitment to generate a personalized workout schedule.',
      },
      {
        'question': 'Can the AI create meal plans for specific diets?',
        'answer':
            'Yes! Our AI can generate meal plans for keto, vegetarian, vegan, paleo, and other diets. Just specify your dietary preferences when creating your nutrition plan.',
      },
      {
        'question': 'How accurate are the calorie calculations?',
        'answer':
            'Calorie calculations are estimates based on standard metabolic formulas. For precise nutritional tracking, we recommend consulting with a nutritionist and using a food scale for accurate measurements.',
      },
      {
        'question': 'Can I sync the app with my fitness tracker?',
        'answer':
            'Yes! We support integration with Apple Health, Google Fit, Fitbit, and Garmin. Go to Settings > Connected Devices to link your tracker.',
      },
      {
        'question': 'How often should I update my fitness goals?',
        'answer':
            'We recommend reviewing your goals every 4-6 weeks. The AI will prompt you to assess progress and adjust your plan based on your results and changing objectives.',
      },
      {
        'question': 'Is my health data secure?',
        'answer':
            'Yes, we use industry-standard encryption and never share your personal health data. You can delete your data at any time in the Privacy Settings.',
      },
    ];

    return faqs
        .map((faq) => _buildFAQItem(
            context, faq['question']!, faq['answer']!, colorScheme))
        .toList();
  }

  Widget _buildFAQItem(BuildContext context, String question, String answer,
      ColorScheme colorScheme) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
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
      child: ExpansionTile(
        tilePadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        title: Text(
          question,
          style: GoogleFonts.montserrat(
            fontWeight: FontWeight.w600,
            fontSize: 15,
            color: colorScheme.onSurface,
          ),
        ),
        iconColor: AppColors.primary,
        collapsedIconColor: colorScheme.onSurfaceVariant,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        clipBehavior: Clip.antiAlias,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
            child: Text(
              answer,
              style: GoogleFonts.montserrat(
                fontSize: 14,
                color: colorScheme.onSurfaceVariant,
                height: 1.5,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _sendEmail(BuildContext context) async {
    final Uri emailUri = Uri(
      scheme: 'mailto',
      path: 'support@fitnessapp.com',
      query: Uri.encodeQueryComponent('subject=Fitness App Support Request'),
    );

    if (await canLaunchUrl(emailUri)) {
      await launchUrl(emailUri);
    } else {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
                'Unable to open email client. Please email support@fitnessapp.com directly.'),
            backgroundColor: Theme.of(context).colorScheme.error,
          ),
        );
      }
    }
  }

  void _callSupport(BuildContext context) async {
    final Uri phoneUri = Uri(
      scheme: 'tel',
      path: '+15551234567',
    );

    if (await canLaunchUrl(phoneUri)) {
      await launchUrl(phoneUri);
    } else {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content:
                Text('Unable to make a call. Please call +1 (555) 123-4567'),
            backgroundColor: Theme.of(context).colorScheme.error,
          ),
        );
      }
    }
  }
}
