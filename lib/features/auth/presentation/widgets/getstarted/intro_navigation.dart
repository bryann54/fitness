// widgets/intro_navigation.dart
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:fitness/common/res/colors.dart';
import 'package:fitness/features/auth/presentation/widgets/getstarted/split_theme_button.dart';
import 'package:fitness/features/auth/presentation/widgets/getstarted/next_button.dart';

class IntroNavigation extends StatelessWidget {
  final int currentPage;
  final int totalPages;
  final Animation<double> buttonAnimation;
  final VoidCallback onSkip;
  final VoidCallback onNext;
  final VoidCallback onGetStarted;

  const IntroNavigation({
    super.key,
    required this.currentPage,
    required this.totalPages,
    required this.buttonAnimation,
    required this.onSkip,
    required this.onNext,
    required this.onGetStarted,
  });

  bool get isLastPage => currentPage == totalPages - 1;

  @override
  Widget build(BuildContext context) {
    if (isLastPage) {
      return _buildLastPageNavigation(context);
    } else {
      return _buildRegularNavigation(context);
    }
  }

  Widget _buildRegularNavigation(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          TextButton(
            onPressed: onSkip,
            style: TextButton.styleFrom(
              padding: const EdgeInsets.symmetric(
                horizontal: 24.0,
                vertical: 12.0,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: Text(
              'Skip',
              style: GoogleFonts.poppins(
                fontSize: 20,
                fontWeight: FontWeight.w500,
                color: AppColors.backgroundLight,
                letterSpacing: 0.2,
              ),
            ),
          ),
          NextButton(
            animation: buttonAnimation,
            onPressed: onNext,
          ),
        ],
      ),
    );
  }

  Widget _buildLastPageNavigation(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32.0),
      child: Column(
        children: [
          TextButton(
            onPressed: onSkip,
            style: TextButton.styleFrom(
              padding: const EdgeInsets.symmetric(
                horizontal: 24.0,
                vertical: 12.0,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: Text(
              'Already have an account?',
              style: GoogleFonts.poppins(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: AppColors.cardDark,
                letterSpacing: 0.2,
              ),
            ),
          ),
          const SizedBox(height: 16),
          SplitThemeButton(
            animation: buttonAnimation,
            onPressed: onGetStarted,
          ).animate().fadeIn(duration: 600.ms).slideX(begin: -0.3, end: 0),
        ],
      ),
    );
  }
}
