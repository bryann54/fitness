// lib/features/meals/presentation/pages/meals_page.dart
import 'package:auto_route/auto_route.dart';
import 'package:fitness/common/helpers/app_router.gr.dart';
import 'package:fitness/common/res/colors.dart';
import 'package:fitness/features/favourites/presentation/bloc/favourites_bloc.dart';
import 'package:fitness/features/meals/data/models/meal_model.dart';
import 'package:fitness/features/meals/presentation/bloc/meals_bloc.dart';
import 'package:fitness/features/meals/presentation/widgets/meal_card.dart';
import 'package:fitness/features/meals/presentation/widgets/empty_meals_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_animate/flutter_animate.dart';

@RoutePage()
class MealsPage extends StatefulWidget {
  const MealsPage({super.key});

  @override
  State<MealsPage> createState() => _MealsPageState();
}

class _MealsPageState extends State<MealsPage> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    context.read<MealsBloc>().add(FetchMealsEvent());
    context.read<FavouritesBloc>().add(LoadFavouritesEvent());
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.cardDark,
      body: BlocBuilder<MealsBloc, MealsState>(
        builder: (context, state) {
          if (state is MealsLoading) {
            return const Center(
              child: CircularProgressIndicator(color: AppColors.primary),
            );
          }

          if (state is MealsError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.error_outline,
                    size: 80,
                    color: AppColors.error,
                  )
                      .animate(onPlay: (controller) => controller.repeat())
                      .shimmer(duration: 2.seconds),
                  const SizedBox(height: 20),
                  Text(
                    state.message,
                    style: const TextStyle(color: AppColors.textPrimaryDark),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      context.read<MealsBloc>().add(FetchMealsEvent());
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 32,
                        vertical: 16,
                      ),
                    ),
                    child: const Text('Retry'),
                  ),
                ],
              ).animate().fadeIn(duration: 600.ms),
            );
          }

          if (state is MealsLoaded) {
            return CustomScrollView(
              physics: const BouncingScrollPhysics(),
              slivers: [
                _buildAppBar(),
                _buildSearchBar(),
                _buildDietFilters(state),
                _buildCategoryFilters(state),
                _buildMealGrid(state.filteredMeals),
              ],
            );
          }

          return const SizedBox();
        },
      ),
    );
  }

  Widget _buildAppBar() {
    return SliverAppBar(
      expandedHeight: 120,
      backgroundColor: AppColors.cardDark,
      floating: true,
      pinned: true,
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: false,
        titlePadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        title: Row(
          children: [
            Text(
              "Fuel Your Body",
              style: GoogleFonts.acme(
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
            const Spacer(),
            BlocBuilder<FavouritesBloc, FavouritesState>(
              builder: (context, state) {
                int count = 0;
                if (state is FavouritesLoaded) {
                  count = state.favourites.length;
                }

                return Stack(
                  clipBehavior: Clip.none,
                  children: [
                    Container(
                      width: 35,
                      height: 35,
                      decoration: BoxDecoration(
                        color: AppColors.primary.withValues(alpha: .1),
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: AppColors.primary.withValues(alpha: 0.3),
                          width: 1,
                        ),
                      ),
                      child: Material(
                        type: MaterialType.transparency,
                        shape: const CircleBorder(),
                        child: InkWell(
                          onTap: () {
                            context.router.push(const FavouritesRoute());
                          },
                          customBorder: const CircleBorder(),
                          child: const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Icon(
                              Icons.bookmark,
                              color: AppColors.primary,
                              size: 16,
                            ),
                          ),
                        ),
                      ),
                    ),
                    if (count > 0)
                      Positioned(
                        right: 0,
                        top: 0,
                        child: Container(
                          padding: const EdgeInsets.all(4),
                          decoration: BoxDecoration(
                            color: AppColors.error,
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: AppColors.cardDark,
                              width: 2,
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: AppColors.error.withValues(alpha: 0.5),
                                blurRadius: 8,
                                spreadRadius: 1,
                              ),
                            ],
                          ),
                          constraints: const BoxConstraints(
                            minWidth: 20,
                            minHeight: 20,
                          ),
                          child: Center(
                            child: Text(
                              count > 99 ? '99+' : '$count',
                              style: GoogleFonts.poppins(
                                color: AppColors.textPrimaryDark,
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        )
                            .animate(
                              onPlay: (controller) => controller.repeat(
                                reverse: true,
                              ),
                            )
                            .scale(
                              begin: const Offset(1.0, 1.0),
                              end: const Offset(1.1, 1.1),
                              duration: 1.seconds,
                            )
                            .shimmer(duration: 2.seconds),
                      ),
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSearchBar() {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: TextField(
          controller: _searchController,
          onChanged: (query) {
            context.read<MealsBloc>().add(SearchMealsEvent(query));
          },
          style: const TextStyle(color: AppColors.textPrimaryDark),
          decoration: InputDecoration(
            hintText: 'Search meals...',
            hintStyle: TextStyle(
                color: AppColors.textPrimaryDark.withValues(alpha: 0.5)),
            prefixIcon: const Icon(Icons.search, color: AppColors.primary),
            suffixIcon: _searchController.text.isNotEmpty
                ? IconButton(
                    icon: Icon(Icons.clear,
                        color:
                            AppColors.textPrimaryDark.withValues(alpha: 0.7)),
                    onPressed: () {
                      _searchController.clear();
                      context.read<MealsBloc>().add(const SearchMealsEvent(''));
                    },
                  )
                : null,
            filled: true,
            fillColor: AppColors.textLightDark.withValues(alpha: 0.2),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: BorderSide.none,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDietFilters(MealsLoaded state) {
    final dietTags = ['All', 'Vegan', 'Keto', 'Traditional', 'Standard'];

    return SliverToBoxAdapter(
      child: SizedBox(
        height: 50,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          padding: const EdgeInsets.symmetric(horizontal: 16),
          itemCount: dietTags.length,
          itemBuilder: (context, index) {
            final tag = dietTags[index];
            final isSelected = state.selectedDietTag == tag ||
                (tag == 'All' && state.selectedDietTag == null);

            return FilterChip(
              label: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: isSelected
                      ? AppColors.primary.withValues(alpha: 0.2)
                      : AppColors.textLightDark.withValues(alpha: 0.2),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        _getDietIcon(tag),
                        size: 16,
                        color:
                            isSelected ? AppColors.cardDark : AppColors.primary,
                      ),
                      const SizedBox(width: 6),
                      Text(tag),
                    ],
                  ),
                ),
              ),
              selected: isSelected,
              onSelected: (_) {
                context.read<MealsBloc>().add(FilterByDietTagEvent(tag));
              },
              labelStyle: GoogleFonts.poppins(
                color: isSelected
                    ? AppColors.cardDark
                    : AppColors.textPrimaryDark.withValues(alpha: 0.7),
                fontSize: 12,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              ),
              selectedColor: AppColors.primary,
              backgroundColor: AppColors.cardDark,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              side: BorderSide.none,
              showCheckmark: false,
            ).animate().fadeIn(duration: 600.ms);
          },
        ),
      ),
    );
  }

  Widget _buildCategoryFilters(MealsLoaded state) {
    return SliverToBoxAdapter(
      child: SizedBox(
        height: 50,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 5),
          itemCount: state.categories.length,
          itemBuilder: (context, index) {
            final category = state.categories[index];
            final isSelected = state.selectedCategory == category;

            return Padding(
              padding: const EdgeInsets.only(right: 8),
              child: ChoiceChip(
                label: Text(category),
                selected: isSelected,
                onSelected: (_) {
                  context
                      .read<MealsBloc>()
                      .add(FilterByCategoryEvent(category));
                },
                labelStyle: GoogleFonts.poppins(
                  color: isSelected
                      ? AppColors.cardDark
                      : AppColors.textPrimaryDark.withValues(alpha: 0.7),
                  fontSize: 13,
                  fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                ),
                selectedColor: AppColors.primary,
                backgroundColor:
                    AppColors.textPrimaryDark.withValues(alpha: 0.1),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                side: isSelected
                    ? BorderSide.none
                    : BorderSide(
                        color:
                            AppColors.textPrimaryDark.withValues(alpha: 0.2)),
                showCheckmark: false,
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildMealGrid(List<MealModel> meals) {
    if (meals.isEmpty) {
      return EmptyMealsView();
    }

    return SliverPadding(
      padding: const EdgeInsets.fromLTRB(16, 20, 16, 100),
      sliver: SliverGrid(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 16,
          crossAxisSpacing: 16,
          childAspectRatio: 0.75,
        ),
        delegate: SliverChildBuilderDelegate(
          (context, index) {
            final meal = meals[index];
            return MealCard(
              meal: meal,
              onTap: () {
                context.router.push(
                  MealDetailRoute(meal: meal),
                );
              },
            );
          },
          childCount: meals.length,
        ),
      ),
    );
  }

  IconData _getDietIcon(String tag) {
    switch (tag.toLowerCase()) {
      case 'vegan':
        return Icons.eco;
      case 'keto':
        return Icons.local_fire_department;
      case 'traditional':
        return Icons.restaurant;
      case 'standard':
        return Icons.fastfood;
      default:
        return Icons.dining;
    }
  }
}
