// lib/features/onboarding/presentation/pages/specific_supp_screen.dart

import 'package:auto_route/auto_route.dart';
import 'package:fitness/common/res/colors.dart';
import 'package:fitness/features/onboarding/presentation/widgets/onboarding_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:fitness/common/helpers/app_router.gr.dart';
import 'package:fitness/features/onboarding/data/models/fitness_profile_model.dart';
import 'package:fitness/features/onboarding/presentation/widgets/continue_button.dart';
import 'package:flutter_animate/flutter_animate.dart';

@RoutePage()
class SpecificSuppScreen extends StatefulWidget {
  final FitnessProfileModel profile;
  const SpecificSuppScreen({super.key, required this.profile});

  @override
  State<SpecificSuppScreen> createState() => _SpecificSuppScreenState();
}

class _SpecificSuppScreenState extends State<SpecificSuppScreen> {
  static const Color primaryColor = AppColors.accent;
  static const Color unselectedColor = Color(0xFF2C2C2C);

  final List<String> commonSupplements = [
    'Protein',
    'Whey',
    'BCAAs',
    'Creatine',
    'Vitamin D',
    'Magnesium',
    'Fish Oil',
    'Multivitamin',
    'Pre-Workout',
    'Glutamine',
    'Zinc',
    'Calcium',
    'Iron',
    'Vitamin C',
  ];

  final List<String> _selectedSupplements = [];

  void _toggleSupplement(String supplement) {
    setState(() {
      if (_selectedSupplements.contains(supplement)) {
        _selectedSupplements.remove(supplement);
      } else {
        _selectedSupplements.add(supplement);
      }
    });
  }

  void _showAllSupplements() async {
    final result = await context.router.push<List<String>>(
      AllSupplementsRoute(initialSelection: _selectedSupplements),
    );

    if (result != null) {
      setState(() {
        _selectedSupplements
          ..clear()
          ..addAll(result);
      });
    }
  }

  Widget _buildSupplementChip(String supplement) {
    final isSelected = _selectedSupplements.contains(supplement);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 3.0, vertical: 4.0),
      child: InputChip(
        label: Text(
          supplement,
          style: TextStyle(
            color:
                isSelected ? Colors.black : AppColors.visualLightBackgroundHalf,
            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
          ),
        ),
        backgroundColor: isSelected ? primaryColor : unselectedColor,
        deleteIcon: isSelected
            ? const Icon(Icons.close, color: Colors.black, size: 16)
            : null,
        onDeleted: isSelected ? () => _toggleSupplement(supplement) : null,
        onPressed: () => _toggleSupplement(supplement),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        selected: isSelected,
        selectedColor: primaryColor,
        checkmarkColor: Colors.black,
      ).animate(
        effects: [
          FadeEffect(duration: 800.ms),
          ScaleEffect(duration: 400.ms, curve: Curves.easeOutBack),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    // MOVE SingleChildScrollView INSIDE THE SCAFFOLD BODY
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: const OnboardingAppBar(
        currentStep: 12,
        totalSteps: 17,
        isInitial: false,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 10),
              Text(
                "Specify Supplement",
                style: theme.textTheme.headlineMedium?.copyWith(
                  color: AppColors.visualLightBackgroundHalf,
                  fontWeight: FontWeight.w800,
                ),
              ),
              Text(
                "Please specify your supplement.",
                style: theme.textTheme.titleMedium?.copyWith(
                  color: AppColors.visualLightBackgroundHalf,
                ),
              ),
              const SizedBox(height: 30),

              // Header Row for Chips
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Most Common',
                    style: theme.textTheme.titleMedium?.copyWith(
                      color: AppColors.visualLightBackgroundHalf,
                      fontWeight: FontWeight.bold,
                    ),
                  ).animate(
                    effects: [
                      FadeEffect(delay: 100.ms, duration: 500.ms),
                      SlideEffect(begin: const Offset(-0.2, 0)),
                    ],
                  ),
                  TextButton(
                    onPressed: _showAllSupplements,
                    child: Text(
                      'See All Supplements',
                      style: theme.textTheme.bodyLarge?.copyWith(
                        color: primaryColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ).animate(
                    effects: [
                      FadeEffect(delay: 100.ms, duration: 500.ms),
                      SlideEffect(begin: const Offset(0.2, 0)),
                    ],
                  ),
                ],
              ),

              const SizedBox(height: 10),

              Wrap(
                spacing: 8.0,
                runSpacing: 4.0,
                children: commonSupplements
                    .map((supp) => _buildSupplementChip(supp))
                    .toList(),
              ),

              const SizedBox(height: 40), // REPLACED Spacer()

              if (_selectedSupplements.isNotEmpty) ...[
                const Text(
                  'Selected:',
                  style: TextStyle(
                      color: AppColors.visualLightBackgroundHalf,
                      fontSize: 16,
                      fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 12),
                // REMOVED Expanded() here
                Wrap(
                  spacing: 8.0,
                  runSpacing: 4.0,
                  children: _selectedSupplements
                      .map((supp) => _buildSupplementChip(supp))
                      .toList(),
                ),
                const SizedBox(height: 40),
              ],

              ContinueButton(
                onPressed: () {
                  final updatedProfile = FitnessProfileModel(
                    uid: widget.profile.uid,
                    primaryGoal: widget.profile.primaryGoal,
                    gender: widget.profile.gender,
                    currentWeightKg: widget.profile.currentWeightKg,
                    age: widget.profile.age,
                    experience: widget.profile.experience,
                    fitnessLevel: widget.profile.fitnessLevel,
                    physicalLimitations: widget.profile.physicalLimitations,
                    dietPreference: widget.profile.dietPreference,
                    workoutsPerWeek: widget.profile.workoutsPerWeek,
                    workoutPreferences: widget.profile.workoutPreferences,
                    isTakingSupplements: widget.profile.isTakingSupplements,
                    calorieGoal: 0,
                    calorieUnit: 'Kcal',
                    supplementsTaken: _selectedSupplements,
                    heightCm: widget.profile.heightCm,
                    sleepQuality: widget.profile.sleepQuality,
                  );

                  context.router.push(CaloriesRoute(profile: updatedProfile));
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
