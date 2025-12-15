// lib/features/workouts/presentation/widgets/category_selector.dart

import 'package:fitness/features/workouts/data/models/exercise_category_model.dart';
import 'package:fitness/features/workouts/presentation/bloc/workouts_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CategorySelector extends StatefulWidget {
  const CategorySelector({super.key});

  @override
  State<CategorySelector> createState() => _CategorySelectorState();
}

class _CategorySelectorState extends State<CategorySelector> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WorkoutsBloc, WorkoutsState>(
      builder: (context, state) {
        if (state is CategoriesLoading) {
          return const Center(child: CircularProgressIndicator());
        }
        if (state is CategoriesError) {
          return Center(
              child: Text('Failed to load categories: ${state.error}'));
        }
        if (state is CategoriesSuccess) {
          final categories = state.categories;

          if (categories.isEmpty) {
            return const Center(child: Text('No categories found.'));
          }

          return SizedBox(
            height: 120, // Height for the icon and text container
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: categories.length,
              itemBuilder: (context, index) {
                final category = categories[index];
                final isSelected = index == _selectedIndex;

                // Ensure the first item starts padded, and all subsequent items are spaced
                final leftPadding = index == 0 ? 20.0 : 8.0;

                return Padding(
                  padding: EdgeInsets.only(left: leftPadding, right: 8.0),
                  child: InkWell(
                    onTap: () {
                      setState(() {
                        _selectedIndex = index;
                      });
                      // TODO: Implement fetching exercises for this category
                      // context.read<WorkoutsBloc>().add(GetExercisesEvent(category.id));
                    },
                    child: CategoryItem(
                      category: category,
                      isSelected: isSelected,
                    ),
                  ),
                );
              },
            ),
          );
        }
        return const SizedBox.shrink();
      },
    );
  }
}

class CategoryItem extends StatelessWidget {
  final ExerciseCategoryModel category;
  final bool isSelected;

  const CategoryItem({
    super.key,
    required this.category,
    required this.isSelected,
  });

  // Placeholder logic for icon based on category name
  IconData _getIconForCategory(String name) {
    if (name.toLowerCase().contains('dumbbell')) return Icons.fitness_center;
    if (name.toLowerCase().contains('yoga')) return Icons.self_improvement;
    if (name.toLowerCase().contains('free hand')) return Icons.run_circle;
    if (name.toLowerCase().contains('cardio')) return Icons.directions_run;
    return Icons.star;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 70,
          width: 70,
          decoration: BoxDecoration(
            color: isSelected ? Colors.lightGreen : Colors.grey.shade200,
            borderRadius: BorderRadius.circular(15),
          ),
          child: Icon(
            _getIconForCategory(category.name),
            color: isSelected ? Colors.white : Colors.black,
            size: 30,
          ),
        ),
        const SizedBox(height: 8),
        SizedBox(
          width: 70,
          child: Text(
            category.name,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 12,
              color: isSelected ? Colors.lightGreen : Colors.black87,
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}
