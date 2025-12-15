// lib/features/onboarding/presentation/pages/physical_limitations_screen.dart

import 'package:auto_route/auto_route.dart';
import 'package:fitness/features/onboarding/presentation/widgets/onboarding_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:fitness/common/helpers/app_router.gr.dart';
import 'package:fitness/features/onboarding/data/models/fitness_profile_model.dart';
import 'package:fitness/features/onboarding/presentation/widgets/continue_button.dart';

@RoutePage()
class PhysicalLimitationsScreen extends StatefulWidget {
  final FitnessProfileModel profile;
  const PhysicalLimitationsScreen({super.key, required this.profile});

  @override
  State<PhysicalLimitationsScreen> createState() =>
      _PhysicalLimitationsScreenState();
}

class _PhysicalLimitationsScreenState extends State<PhysicalLimitationsScreen> {
  static const Color primaryColor = Color(0xFFFF9800);
  static const int maxSelections = 10;

  final TextEditingController _customLimitationController =
      TextEditingController();
  final FocusNode _inputFocusNode = FocusNode();
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
  void dispose() {
    _customLimitationController.dispose();
    _inputFocusNode.dispose();
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

  void _addCustomLimitation() {
    final text = _customLimitationController.text.trim();
    if (text.isNotEmpty && !_selectedLimitations.contains(text)) {
      if (_selectedLimitations.length < maxSelections) {
        setState(() {
          _selectedLimitations.add(text);
          _customLimitationController.clear();
        });
      }
    }
    _inputFocusNode.unfocus();
  }

  Widget _buildLimitationChip(String limitation,
      {bool isRemovable = true, bool isCommonSuggestion = false}) {
    final isSelected = _selectedLimitations.contains(limitation);
    Color chipColor = Colors.black;
    Color textColor = Colors.white;
    BorderSide borderSide = const BorderSide(color: Colors.white24, width: 1.5);

    if (isSelected) {
      chipColor = primaryColor;
      textColor = Colors.black;
      borderSide = BorderSide.none;
    } else if (isCommonSuggestion) {
      borderSide = const BorderSide(color: primaryColor, width: 1.5);
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4.0, vertical: 4.0),
      child: InputChip(
        label: Text(
          limitation,
          style: TextStyle(
            color: textColor,
            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
          ),
        ),
        backgroundColor: chipColor,
        deleteIcon: isSelected && isRemovable
            ? const Icon(Icons.close, color: Colors.black, size: 16)
            : null,
        onDeleted: isSelected && isRemovable
            ? () => _toggleLimitation(limitation)
            : null,
        onPressed: () => _toggleLimitation(limitation),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
          side: borderSide,
        ),
        selected: isSelected,
        selectedColor: primaryColor,
        checkmarkColor: Colors.black,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isMaxedOut = _selectedLimitations.length >= maxSelections;
    final List<String> mainWrapLimitations = availableLimitations.sublist(0, 5);

    return Scaffold(
      backgroundColor: Colors.black,
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
              Text(
                "Do you have any physical limitations?",
                style: theme.textTheme.headlineMedium?.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.w800,
                ),
              ),
              const SizedBox(height: 30),

              // Image for context
              Center(
                child: Image.asset(
                  'assets/wheelchair.png',
                  height: 160,
                ),
              ),
              const SizedBox(height: 30),

              // Custom Chip Grid/Wrap and Input Field
              Container(
                padding: const EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16.0),
                  border: Border.all(
                    color: primaryColor,
                    width: 1.5,
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Row for Predefined Chips
                    Wrap(
                      spacing: 8.0,
                      runSpacing: 0.0,
                      // These chips are selectable/unselectable but not deletable with 'X'
                      children: mainWrapLimitations
                          .map((limitation) => _buildLimitationChip(limitation,
                              isRemovable: false))
                          .toList(),
                    ),

                    // Manual Input Field
                    const SizedBox(height: 10),
                    TextField(
                      controller: _customLimitationController,
                      focusNode: _inputFocusNode,
                      textInputAction: TextInputAction.done,
                      onSubmitted: (_) => _addCustomLimitation(),
                      style: const TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        hintText:
                            'Type custom limitation here (e.g., Torn ACL)',
                        hintStyle: const TextStyle(
                            color: Colors.white38, fontSize: 14),
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.zero,
                        suffixIcon: IconButton(
                          icon: Icon(Icons.add, color: primaryColor),
                          onPressed: _addCustomLimitation,
                        ),
                      ),
                    ),
                    const Divider(height: 1, color: Colors.white12),

                    // Counter
                    Align(
                      alignment: Alignment.bottomRight,
                      child: Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: Text(
                          '${_selectedLimitations.length}/$maxSelections',
                          style: TextStyle(
                            color: isMaxedOut ? Colors.red : primaryColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              // "Most Common" Chips (Displayed below the main container)
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Most Common:',
                    style: TextStyle(color: Colors.white70, fontSize: 14),
                  ),
                  Row(
                    children: availableLimitations
                        .sublist(4, 6) // Knee Pain and Muscle Pain
                        // These are selectable suggestions, not deletable with 'X'
                        .map((limitation) => _buildLimitationChip(limitation,
                            isRemovable: false, isCommonSuggestion: true))
                        .toList(),
                  ),
                ],
              ),

              const Spacer(),

              // Continue Button
              ContinueButton(
                onPressed: () {
                  // Add text input if any exists before proceeding
                  if (_customLimitationController.text.isNotEmpty) {
                    _addCustomLimitation();
                  }

                  final updatedProfile = FitnessProfileModel(
                    calorieGoal: 0,
                    calorieUnit: 'Kcal',
                    uid: widget.profile.uid,
                    primaryGoal: widget.profile.primaryGoal,
                    gender: widget.profile.gender,
                    currentWeightKg: widget.profile.currentWeightKg,
                    age: widget.profile.age,
                    experience: widget.profile.experience,
                    fitnessLevel: widget.profile.fitnessLevel,

                    // --- FIELD UPDATED IN THIS SCREEN ---
                    physicalLimitations: _selectedLimitations.join(', '),

                    // ... remaining profile data ...
                    heightCm: widget.profile.heightCm,
                    workoutsPerWeek: widget.profile.workoutsPerWeek,
                    isTakingSupplements: widget.profile.isTakingSupplements,
                    dietPreference: widget.profile.dietPreference,
                    workoutPreferences: widget.profile.workoutPreferences,
                    sleepQuality: widget.profile.sleepQuality,
                  );

                  // Navigate to the next screen (DietPrefScreen - Step 8)
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
