// lib/features/onboarding/presentation/pages/fitness_level_screen.dart

import 'package:auto_route/auto_route.dart';
import 'package:fitness/common/res/colors.dart';
import 'package:fitness/features/onboarding/presentation/widgets/onboarding_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'dart:math';

import 'package:fitness/common/helpers/app_router.gr.dart';
import 'package:fitness/features/onboarding/data/models/fitness_profile_model.dart';
import 'package:fitness/features/onboarding/presentation/widgets/continue_button.dart';
import 'package:fitness/features/onboarding/presentation/widgets/fitness_arc_painter.dart';

const List<String> fitnessDescriptions = [
  "Sedentary",
  "Beginner",
  "Casual Athlete",
  "Somewhat Athletic",
  "Advanced",
  "Elite Athlete",
];

@RoutePage()
class FitnessLevelScreen extends StatefulWidget {
  final FitnessProfileModel profile;
  const FitnessLevelScreen({super.key, required this.profile});

  @override
  State<FitnessLevelScreen> createState() => _FitnessLevelScreenState();
}

class _FitnessLevelScreenState extends State<FitnessLevelScreen> {
  static const int maxScore = 5;
  late int _selectedLevel;

  // Match the painter's constants
  static const double startAngle = pi * 1.16; // 210 degrees
  static const double sweepAngle = pi * 0.66; // 120 degrees

  @override
  void initState() {
    super.initState();
    _selectedLevel = 3; // Default to "Somewhat Athletic"
  }

  void _handleGesture(Offset position, Size size) {
    final center = Offset(size.width / 2, size.height * 0.75);

    final touchVector = position - center;
    double touchAngle = atan2(touchVector.dy, touchVector.dx);

    // Normalize to 0-2π range
    if (touchAngle < 0) {
      touchAngle += 2 * pi;
    }

    // Calculate the end angle
    final double endAngle = startAngle + sweepAngle;

    // Clamp the angle to our arc range (210° to 330°)
    double clampedAngle = touchAngle;

    // Handle angles outside the arc
    if (touchAngle < startAngle && touchAngle < pi) {
      // Touch is before start angle (counterclockwise from start)
      clampedAngle = startAngle;
    } else if (touchAngle > endAngle && touchAngle < startAngle) {
      // Touch is after end angle but before start (wrapping around)
      // Determine which end is closer
      final distToStart = _angleDifference(touchAngle, startAngle);
      final distToEnd = _angleDifference(touchAngle, endAngle);
      clampedAngle = distToStart < distToEnd ? startAngle : endAngle;
    }

    // Calculate proportion along the arc
    double angleTraversed = clampedAngle - startAngle;
    if (angleTraversed < 0) {
      angleTraversed += 2 * pi;
    }

    // Ensure we're within the sweep range
    if (angleTraversed > sweepAngle) {
      clampedAngle = endAngle;
      angleTraversed = sweepAngle;
    }

    final proportion = (angleTraversed / sweepAngle).clamp(0.0, 1.0);

    // Convert to level (0-5)
    final newLevel = (proportion * maxScore).round().clamp(0, maxScore);

    if (_selectedLevel != newLevel) {
      setState(() {
        _selectedLevel = newLevel;
      });
    }
  }

  // Helper to calculate the shortest angular distance
  double _angleDifference(double angle1, double angle2) {
    double diff = (angle1 - angle2).abs();
    if (diff > pi) {
      diff = 2 * pi - diff;
    }
    return diff;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final description = fitnessDescriptions[_selectedLevel];

    return Scaffold(
      backgroundColor: AppColors.cardDark,
      appBar: const OnboardingAppBar(
        currentStep: 6,
        totalSteps: 17,
        isInitial: false,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 10),

              // Animated title
              Text(
                "How would you rate your fitness level?",
                style: theme.textTheme.headlineMedium?.copyWith(
                  color: AppColors.cardLight,
                  fontWeight: FontWeight.w800,
                ),
              )
                  .animate()
                  .fadeIn(duration: 600.ms)
                  .slideX(begin: -0.2, end: 0, duration: 600.ms),

              const SizedBox(height: 10),

              // Animated hint
              const Row(
                children: [
                  Icon(Icons.help_outline,
                      color: AppColors.cardLight, size: 16),
                  SizedBox(width: 4),
                  Text(
                    'Drag to adjust',
                    style:
                        TextStyle(color: AppColors.cardLight, fontSize: 14),
                  ),
                ],
              ).animate().fadeIn(duration: 600.ms, delay: 200.ms),

              const SizedBox(height: 30),

              // Custom Angular Slider Area
              Expanded(
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    final size = Size(
                      constraints.maxWidth,
                      constraints.maxHeight,
                    );

                    return GestureDetector(
                      onPanUpdate: (details) =>
                          _handleGesture(details.localPosition, size),
                      onPanDown: (details) =>
                          _handleGesture(details.localPosition, size),
                      onTapDown: (details) =>
                          _handleGesture(details.localPosition, size),
                      child: Stack(
                        children: [
                          // Arc Painter
                          Positioned.fill(
                            child: CustomPaint(
                              painter: FitnessArcPainter(
                                level: _selectedLevel,
                                maxLevel: maxScore,
                              ),
                            )
                                .animate()
                                .fadeIn(duration: 800.ms, delay: 400.ms)
                                .scale(
                                  begin: const Offset(0.8, 0.8),
                                  duration: 800.ms,
                                  delay: 400.ms,
                                  curve: Curves.easeOutBack,
                                ),
                          ),

                          // Number and Description
                          Positioned.fill(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Spacer(),

                                // Large score number
                                Text(
                                  '$_selectedLevel',
                                  style: const TextStyle(
                                    color: AppColors.cardLight,
                                    fontSize: 160,
                                    fontWeight: FontWeight.w900,
                                    height: 0.9,
                                  ),
                                )
                                    .animate(
                                      key: ValueKey(_selectedLevel),
                                    )
                                    .scale(
                                      begin: const Offset(0.8, 0.8),
                                      duration: 300.ms,
                                      curve: Curves.easeOutBack,
                                    ),

                                const SizedBox(height: 8),

                                // Description text
                                Text(
                                  description,
                                  style: const TextStyle(
                                    color: AppColors.cardLight,
                                    fontSize: 20,
                                    fontWeight: FontWeight.w500,
                                    letterSpacing: 0.5,
                                  ),
                                )
                                    .animate(
                                      key: ValueKey(description),
                                    )
                                    .fadeIn(duration: 200.ms),

                                const SizedBox(height: 40),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),

              const SizedBox(height: 10),

              // Continue Button
              ContinueButton(
                onPressed: () {
                  final updatedProfile = widget.profile.copyWith(
                    fitnessLevel: fitnessDescriptions[_selectedLevel],
                  );

                  context.router
                      .push(PhysicalLimitationsRoute(profile: updatedProfile));
                },
              )
                  .animate()
                  .fadeIn(duration: 600.ms, delay: 600.ms)
                  .slideY(begin: 0.3, end: 0, duration: 600.ms, delay: 600.ms),
            ],
          ),
        ),
      ),
    );
  }
}
