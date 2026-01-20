// lib/features/onboarding/presentation/pages/all_supplements_screen.dart

import 'package:auto_route/auto_route.dart';
import 'package:fitness/common/res/app_search_field.dart';
import 'package:flutter/material.dart';
import 'package:fitness/common/res/colors.dart';
import 'package:fitness/features/onboarding/presentation/widgets/onboarding_chip_builder.dart';
import 'package:flutter_animate/flutter_animate.dart'; // <--- NEW IMPORT

@RoutePage()
class AllSupplementsScreen extends StatefulWidget {
  final List<String> initialSelection;

  const AllSupplementsScreen({super.key, required this.initialSelection});

  @override
  State<AllSupplementsScreen> createState() => _AllSupplementsScreenState();
}

class _AllSupplementsScreenState extends State<AllSupplementsScreen> {
  // Full, static list of supplements
  final List<String> _fullSupplementsList = [
    'Protein',
    'Whey',
    'Casein',
    'Soy Protein',
    'BCAAs',
    'Creatine',
    'Beta-Alanine',
    'Tumeric',
    'Curcumin',
    'Glutamine',
    'Magnesium',
    'Iron',
    'Vitamin D',
    'Vitamin C',
    'Vitamin A',
    'Vitamin B',
    'Omega-3',
    'Omega-6',
    'Omega-9',
    'Fiber',
    'Probiotics',
    'Zinc',
    'Caffeine',
    'Fish Oil',
    'Pre-Workout',
    'ZMA',
    'Ginseng',
    'Melatonin',
    'Collagen',
    'Electrolytes'
  ];

  late List<String> _filteredSupplements;
  late List<String> _currentSelection;

  @override
  void initState() {
    super.initState();
    _currentSelection = List.from(widget.initialSelection);
    _filteredSupplements = _fullSupplementsList;
  }

  void _filterSupplements(String query) {
    final lowerCaseQuery = query.toLowerCase();
    setState(() {
      if (query.isEmpty) {
        _filteredSupplements = _fullSupplementsList;
      } else {
        _filteredSupplements = _fullSupplementsList
            .where((supp) => supp.toLowerCase().contains(lowerCaseQuery))
            .toList();
      }
    });
  }

  void _toggleSelection(String supplement) {
    setState(() {
      if (_currentSelection.contains(supplement)) {
        _currentSelection.remove(supplement);
      } else {
        _currentSelection.add(supplement);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: AppColors.backgroundDark,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          'All Supplements',
          style: theme.textTheme.headlineMedium?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ).animate(
          effects: [
            FadeEffect(delay: 100.ms, duration: 500.ms),
            SlideEffect(
              delay: 100.ms,
              duration: 500.ms,
              begin: const Offset(-0.5, 0),
              end: const Offset(0, 0),
            ),
          ],
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppSearchField(
                    onChanged: _filterSupplements,
                    hintText: 'Search supplements...',
                  ).animate(
                    effects: [
                      FadeEffect(),
                      SlideEffect(),
                    ],
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),

            // Supplements List
            Expanded(
              child: ListView.builder(
                padding: EdgeInsets.zero,
                itemCount: _filteredSupplements.length,
                itemBuilder: (context, index) {
                  final supplement = _filteredSupplements[index];
                  final isSelected = _currentSelection.contains(supplement);

                  return ListTile(
                    contentPadding: const EdgeInsets.symmetric(
                        horizontal: 20.0, vertical: 4.0),
                    title: Text(
                      supplement,
                      style: theme.textTheme.titleMedium?.copyWith(
                        color: isSelected
                            ? AppColors.primary
                            : AppColors.textOnPrimary,
                        fontWeight:
                            isSelected ? FontWeight.bold : FontWeight.normal,
                      ),
                    ),
                    trailing: Icon(
                      isSelected
                          ? Icons.radio_button_checked
                          : Icons.radio_button_unchecked,
                      color: isSelected
                          ? AppColors.primary
                          : AppColors.textSecondary,
                    ),
                    onTap: () => _toggleSelection(supplement),
                    tileColor: isSelected
                        ? AppColors.primary.withValues(alpha: 0.1)
                        : Colors.transparent,
                  );
                },
              ),
            ),

            // Bottom Selection Bar and Apply Button
            Container(
              padding: const EdgeInsets.only(
                  left: 20, right: 20, top: 10, bottom: 30),
              decoration: const BoxDecoration(
                color: AppColors.backgroundDark,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Selected:',
                    style:
                        TextStyle(color: AppColors.textSecondary, fontSize: 16),
                  ),
                  const SizedBox(height: 8),
                  Wrap(
                    spacing: 8.0,
                    runSpacing: 8.0,
                    children: _currentSelection
                        .map(
                          (supp) => OnboardingSelectedChip(
                            label: supp,
                            onDelete: () => _toggleSelection(supp),
                          ),
                        )
                        .toList(),
                  ),
                  const SizedBox(height: 20),

                  // Apply Button
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      onPressed: () {
                        context.router.maybePop(_currentSelection);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primary,
                        padding: const EdgeInsets.symmetric(vertical: 18.0),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16.0),
                        ),
                      ),
                      icon:
                          const Icon(Icons.check, color: AppColors.textAccent),
                      label: Text(
                        'Apply (${_currentSelection.length})',
                        style: theme.textTheme.titleLarge?.copyWith(
                          color: AppColors.textAccent,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ).animate(
                    effects: [
                      FadeEffect(),
                      SlideEffect(),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
