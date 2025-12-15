// lib/features/onboarding/presentation/pages/weight_screen.dart

import 'package:auto_route/auto_route.dart';
import 'package:fitness/features/onboarding/presentation/widgets/continue_button.dart';
import 'package:fitness/features/onboarding/presentation/widgets/onboarding_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:fitness/common/helpers/app_router.gr.dart';
import 'package:fitness/features/onboarding/data/models/fitness_profile_model.dart';

@RoutePage()
class WeightScreen extends StatefulWidget {
  final FitnessProfileModel profile;
  const WeightScreen({super.key, required this.profile});

  @override
  State<WeightScreen> createState() => _WeightScreenState();
}

class _WeightScreenState extends State<WeightScreen> {
  String _unit = 'kg';
  double _currentWeight = 70.0;
  final double _minWeight = 30.0;
  final double _maxWeight = 200.0;

  double get _currentWeightLbs => _currentWeight * 2.20462;
  double get _displayedWeight =>
      _unit == 'kg' ? _currentWeight : _currentWeightLbs;

  Widget _buildRulerSlider() {
    return Column(
      children: [
        const SizedBox(height: 30),
        Text(
          _displayedWeight.toStringAsFixed(_unit == 'kg' ? 0 : 0),
          style: const TextStyle(
            // color: Colors.white,
            fontSize: 80,
            fontWeight: FontWeight.w900,
          ),
        ),

        // Unit label (Small Text)
        Text(
          _unit,
          style: TextStyle(
            // color: Colors.white.withValues(alpha: 0.5),
            fontSize: 24,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 50),

        SliderTheme(
          data: SliderTheme.of(context).copyWith(
            thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 10.0),
            trackHeight: 1.0,
            showValueIndicator: ShowValueIndicator.never,
          ),
          child: Slider(
            value: _currentWeight,
            min: _minWeight,
            max: _maxWeight,
            divisions: ((_maxWeight - _minWeight) * 10).toInt(),
            onChanged: (double newValue) {
              setState(() {
                _currentWeight = newValue;
              });
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '${_minWeight.toInt()}',
                // style: TextStyle(color: Colors.white.withValues(alpha: 0.5)),
              ),
              Text(
                '${_maxWeight.toInt()}',
                // style: TextStyle(color: Colors.white.withValues(alpha: 0.5)),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildUnitToggle() {
    return Container(
      height: 40,
      width: 120,
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 30, 30, 30),
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _buildUnitButton('kg'),
          _buildUnitButton('lbs'),
        ],
      ),
    );
  }

  Widget _buildUnitButton(String label) {
    final bool isSelected = _unit == label;
    return Expanded(
      child: InkWell(
        onTap: () {
          setState(() {
            if (_unit != label) {
              _unit = label;
            }
          });
        },
        child: Container(
          decoration: BoxDecoration(
            color: isSelected ? Colors.teal : Colors.transparent,
            borderRadius: BorderRadius.circular(8.0),
          ),
          alignment: Alignment.center,
          child: Text(
            label.toUpperCase(),
            style: TextStyle(
              color: isSelected ? Colors.white : Colors.white70,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: const OnboardingAppBar(
        currentStep: 3,
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
                "What is your weight?",
                style: theme.textTheme.headlineMedium?.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.w800,
                ),
              ),
              const SizedBox(height: 30),
              _buildUnitToggle(),
              Expanded(
                child: Center(
                  child: _buildRulerSlider(),
                ),
              ),
              ContinueButton(
                onPressed: () {
                  final weightInKg = _currentWeight;
                  final updatedProfile = FitnessProfileModel(
                    uid: widget.profile.uid,
                    primaryGoal: widget.profile.primaryGoal,
                    gender: widget.profile.gender,
                    currentWeightKg: weightInKg,
                    age: widget.profile.age,
                    heightCm: widget.profile.heightCm,
                    experience: widget.profile.experience,
                    fitnessLevel: widget.profile.fitnessLevel,
                    workoutsPerWeek: widget.profile.workoutsPerWeek,
                    isTakingSupplements: widget.profile.isTakingSupplements,
                    dietPreference: widget.profile.dietPreference,
                    workoutPreferences: widget.profile.workoutPreferences,
                    sleepQuality: widget.profile.sleepQuality,
                    physicalLimitations: widget.profile.physicalLimitations,
                    calorieGoal: 0,
                    calorieUnit: 'Kcal',
                  );
                  context.router.push(AgeRoute(profile: updatedProfile));
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
