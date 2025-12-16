// lib/features/onboarding/presentation/pages/physical_limitations_screen.dart

import 'package:auto_route/auto_route.dart';
import 'package:fitness/common/res/colors.dart';
import 'package:fitness/features/onboarding/presentation/widgets/onboarding_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:fitness/common/helpers/app_router.gr.dart';
import 'package:fitness/features/onboarding/data/models/fitness_profile_model.dart';
import 'package:fitness/features/onboarding/presentation/widgets/continue_button.dart';
import 'package:fitness/features/onboarding/presentation/widgets/limitation_chip.dart'; // NEW IMPORT
import 'package:fitness/features/onboarding/presentation/widgets/limitation_input_box.dart';
import 'package:flutter_animate/flutter_animate.dart'; // NEW IMPORT

@RoutePage()
class PhysicalLimitationsScreen extends StatefulWidget {
  final FitnessProfileModel profile;
  const PhysicalLimitationsScreen({super.key, required this.profile});

  @override
  State<PhysicalLimitationsScreen> createState() =>
      _PhysicalLimitationsScreenState();
}

class _PhysicalLimitationsScreenState extends State<PhysicalLimitationsScreen>
    with SingleTickerProviderStateMixin {
  // ADD MIXIN FOR ANIMATION

  static const int maxSelections = 10;
  final TextEditingController _customLimitationController =
      TextEditingController();
  final FocusNode _inputFocusNode = FocusNode();

  // Animation Controllers
  late AnimationController _controller;
  late Animation<Offset> _slideAnimation;
  late Animation<double> _opacityAnimation;

  final List<String> availableLimitations = [
    'Arthritis',
    'Back Pain',
    'Asthma',
    'Obesity',
    'Knee Pain',
    'Muscle Pain',
    'Shoulder Injury',
    'Hernia',
    'High Blood Pressure',
    'Diabetes'
  ];
  final List<String> _selectedLimitations = [];

  @override
  void initState() {
    super.initState();
    // Initialize Animation
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 700),
    );

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.2), // Start slightly below
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    ));

    _opacityAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeIn,
      ),
    );

    _controller.forward();
  }

  @override
  void dispose() {
    _customLimitationController.dispose();
    _inputFocusNode.dispose();
    _controller.dispose();
    super.dispose();
  }

  void _toggleLimitation(String limitation) {
    if (_selectedLimitations.contains(limitation)) {
      setState(() {
        _selectedLimitations.remove(limitation);
      });
    } else if (_selectedLimitations.length < maxSelections) {
      setState(() {
        _selectedLimitations.add(limitation);
      });
    }
    _inputFocusNode.unfocus();
  }

  // Refactored to ensure custom input is added on button press or submit
  void _addCustomLimitation() {
    final text = _customLimitationController.text.trim();
    if (text.isNotEmpty &&
        !_selectedLimitations.contains(text) &&
        _selectedLimitations.length < maxSelections) {
      setState(() {
        _selectedLimitations.add(text);
        _customLimitationController.clear();
      });
    }
    _inputFocusNode.unfocus();
  }

  // Renamed to ensure clarity and remove redundant chip building logic
  Widget _buildSelectedChip(String limitation) {
    // Only used for the 'Selected' row at the bottom, which needs removal logic
    return LimitationChip(
      limitation: limitation,
      isSelected: true, // Always selected in this list
      isRemovable: true, // Always removable here
      onTap: () => _toggleLimitation(limitation),
      onDeleted: () => _toggleLimitation(limitation),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final List<String> mainWrapLimitations = availableLimitations.sublist(0, 5);
    final List<String> commonSuggestions =
        availableLimitations.sublist(5, 7); // Muscle Pain and Shoulder Injury

    // Filter out suggestions that are already selected to avoid duplicates in the main box
    final List<String> currentSelected = _selectedLimitations
        .where(
          (limitation) =>
              !mainWrapLimitations.contains(limitation) &&
              !commonSuggestions.contains(limitation),
        )
        .toList();

    // Ensure the text controller input is not included in the 'Selected' chips below

    return Scaffold(
      backgroundColor: AppColors.backgroundDark, // Refactored color
      appBar: const OnboardingAppBar(
        currentStep: 7,
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

              // Animated Content
              FadeTransition(
                opacity: _opacityAnimation,
                child: SlideTransition(
                  position: _slideAnimation,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Do you have any physical limitations?",
                        style: theme.textTheme.headlineMedium?.copyWith(
                        
                          fontWeight: FontWeight.w800,
                        ),
                      ).animate(
                        effects: [FadeEffect(), SlideEffect()],
                      ),
                      const SizedBox(height: 30),
                      Center(
                        child: Image.asset(
                          'assets/wheelchair.png',
                          height: 160,
                          errorBuilder: (context, error, stackTrace) =>
                              Container(
                            height: 160,
                            color: AppColors.cardDark,
                            alignment: Alignment.center,
                            child: const Text('Limitation Image',
                                style:
                                    TextStyle(color: AppColors.textSecondary)),
                          ),
                        ),
                      ),
                      const SizedBox(height: 30),

                      // Reusable Input Box
                      LimitationInputBox(
                        mainLimitations: mainWrapLimitations,
                        selectedLimitations: _selectedLimitations,
                        maxSelections: maxSelections,
                        controller: _customLimitationController,
                        focusNode: _inputFocusNode,
                        onAddCustom: _addCustomLimitation,
                        onToggle: _toggleLimitation,
                      ),

                      const SizedBox(height: 20),

                      // "Most Common" Suggestions
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Most Common:',
                            style: TextStyle(
                                color: AppColors.textSecondary,
                                fontSize: 14),
                          ),
                          Row(
                            children: commonSuggestions
                                .map((limitation) => LimitationChip(
                                      limitation: limitation,
                                      isSelected: _selectedLimitations
                                          .contains(limitation),
                                      isRemovable: false,
                                      isSuggestion: true,
                                      onTap: () =>
                                          _toggleLimitation(limitation),
                                    ))
                                .toList(),
                          ),
                        ],
                      ).animate(
                        effects: [FadeEffect(), SlideEffect()],
                      ),

                      const SizedBox(height: 20),

                      // Selected Chips Display (Custom additions + suggestions)
                      if (currentSelected.isNotEmpty)
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Custom / Other Selected:',
                              style: TextStyle(
                                  color: AppColors.textSecondary, fontSize: 14),
                            ),
                            const SizedBox(height: 8),
                            Wrap(
                              spacing: 8.0,
                              runSpacing: 8.0,
                              children: currentSelected
                                  .map((limitation) =>
                                      _buildSelectedChip(limitation))
                                  .toList(),
                            ),
                          ],
                        ),
                    ],
                  ),
                ),
              ),

              const Spacer(),

              ContinueButton(
                onPressed: () {
                  if (_customLimitationController.text.isNotEmpty) {
                    _addCustomLimitation();
                  }

                  final updatedProfile = FitnessProfileModel(
                    uid: widget.profile.uid,
                    primaryGoal: widget.profile.primaryGoal,
                    gender: widget.profile.gender,
                    currentWeightKg: widget.profile.currentWeightKg,
                    age: widget.profile.age,
                    experience: widget.profile.experience,
                    fitnessLevel: widget.profile.fitnessLevel,
                    heightCm: widget.profile.heightCm,
                    workoutsPerWeek: widget.profile.workoutsPerWeek,
                    isTakingSupplements: widget.profile.isTakingSupplements,
                    dietPreference: widget.profile.dietPreference,
                    workoutPreferences: widget.profile.workoutPreferences,
                    sleepQuality: widget.profile.sleepQuality,
                    calorieGoal: widget.profile.calorieGoal,
                    calorieUnit: widget.profile.calorieUnit,
                    physicalLimitations: _selectedLimitations.join(', '),
                  );

                  context.router.push(DietPrefRoute(profile: updatedProfile));
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
