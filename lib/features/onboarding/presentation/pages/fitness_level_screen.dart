// lib/features/onboarding/presentation/pages/fitness_level_screen.dart

import 'package:auto_route/auto_route.dart';
import 'package:fitness/features/onboarding/presentation/widgets/onboarding_app_bar.dart';
import 'package:flutter/material.dart';
import 'dart:math';

import 'package:fitness/common/helpers/app_router.gr.dart';
import 'package:fitness/features/onboarding/data/models/fitness_profile_model.dart';
import 'package:fitness/features/onboarding/presentation/widgets/continue_button.dart';
import 'package:fitness/features/onboarding/presentation/widgets/fitness_arc_painter.dart'; // Import the new widget

// Mapping fitness level score to descriptive text
// Corrected to reflect a 0-5 scale
const List<String> fitnessDescriptions = [
  "Sedentary", // 0
  "Beginner", // 1
  "Casual Athlete", // 2
  "Somewhat Athletic", // 3
  "Advanced", // 4
  "Elite Athlete", // 5
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

  // Define constant angles used in the painter for calculation
  static const double startAngle = pi * 1.16; // 210 degrees
  static const double sweepAngle = pi * 0.66; // 120 degrees

  @override
  void initState() {
    super.initState();
    // Default to 'Somewhat Athletic' (Index 3), as per design and experience logic
    _selectedLevel = 3;
  }

  // --- Professional Angular Drag Logic ---
  void _handleGesture(Offset position, Size size) {
    // 1. Define the center and radius used by the painter
    final center = Offset(size.width / 2, size.height * 1.5);

    // 2. Calculate the angle of the touch position relative to the center
    final touchVector = position - center;
    double touchAngle =
        atan2(touchVector.dy, touchVector.dx); // angle in radians (-pi to pi)

    // 3. Normalize the angle to be in the 0 to 2*pi range
    if (touchAngle < 0) {
      touchAngle += 2 * pi;
    }

    // 4. Calculate the start and end angles of the visible arc
    final double endAngle = startAngle + sweepAngle;

    // 5. Clamp the angle to the arc range (startAngle to endAngle)
    double clampedAngle = touchAngle;

    // Handle wrap-around (since our arc wraps around the bottom)
    if (startAngle > endAngle) {
      // If the arc crosses the 0/2pi line (not applicable here, but good practice)
      // Complex logic for wrap-around angle clamping if needed, but for a 120-degree arc, simple clamping works:
    }

    // Simple clamping for this specific arc (210 to 330 degrees)
    // If angle is less than start (210), clamp to start
    if (clampedAngle < startAngle && clampedAngle > pi) {
      clampedAngle = startAngle;
    }
    // If angle is greater than end (330), clamp to end
    else if (clampedAngle > endAngle) {
      clampedAngle = endAngle;
    }

    // 6. Calculate the proportion along the sweep
    final double angleTraversed = clampedAngle - startAngle;
    double proportion = (angleTraversed / sweepAngle).clamp(0.0, 1.0);

    // 7. Convert proportion to the 0-5 score
    final newLevel = (proportion * maxScore.toDouble()).round();

    if (_selectedLevel != newLevel) {
      setState(() {
        _selectedLevel = newLevel;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final description = fitnessDescriptions[_selectedLevel];
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.black,
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
              Text(
                "How would you rate your fitness level?",
                style: theme.textTheme.headlineMedium?.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.w800,
                ),
              ),
              const SizedBox(height: 10),
              const Row(
                children: [
                  Icon(Icons.help_outline, color: Colors.white70, size: 16),
                  SizedBox(width: 4),
                  Text(
                    'Drag to adjust',
                    style: TextStyle(color: Colors.white70, fontSize: 14),
                  ),
                ],
              ),
              const SizedBox(height: 20),

              // Custom Angular Slider Area
              Expanded(
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    // Set height proportional to screen or container for the arc visualization
                    final size =
                        Size(constraints.maxWidth, screenHeight * 0.45);

                    return GestureDetector(
                      onPanUpdate: (details) =>
                          _handleGesture(details.localPosition, size),
                      onTapDown: (details) =>
                          _handleGesture(details.localPosition, size),
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          // 1. Custom Arc Painter
                          CustomPaint(
                            size: size,
                            painter: FitnessArcPainter(
                                level: _selectedLevel, maxLevel: maxScore),
                          ),

                          // 2. Large Number and Description (Positioned to match design)
                          Positioned(
                            bottom: size.height * 0.0, // Move it up slightly
                            child: Column(
                              children: [
                                // The large score number
                                Text(
                                  '$_selectedLevel',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize:
                                        180, // Larger size to match screenshot
                                    fontWeight: FontWeight.w900,
                                    height: 0.8, // Adjust line height
                                  ),
                                ),
                                // The text description below the number
                                Text(
                                  description,
                                  style: const TextStyle(
                                    color: Colors.white70,
                                    fontSize: 22,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),

              // Continue Button
              ContinueButton(
                onPressed: () {
                  final updatedProfile = FitnessProfileModel(
                    uid: widget.profile.uid,
                    primaryGoal: widget.profile.primaryGoal,
                    gender: widget.profile.gender,
                    currentWeightKg: widget.profile.currentWeightKg,
                    age: widget.profile.age,
                    experience: widget.profile.experience,
                    fitnessLevel: fitnessDescriptions[_selectedLevel],
                    heightCm: widget.profile.heightCm,
                    workoutsPerWeek: widget.profile.workoutsPerWeek,
                    isTakingSupplements: widget.profile.isTakingSupplements,
                    dietPreference: widget.profile.dietPreference,
                    workoutPreferences: widget.profile.workoutPreferences,
                    sleepQuality: widget.profile.sleepQuality,
                    physicalLimitations: widget.profile.physicalLimitations,
                    calorieGoal: 0,
                    calorieUnit: 'Kcal',
                  );

                  context.router
                      .push(PhysicalLimitationsRoute(profile: updatedProfile));
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
