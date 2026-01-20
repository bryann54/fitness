// lib/features/favourites/presentation/pages/favourites_page.dart
import 'package:auto_route/auto_route.dart';
import 'package:fitness/common/helpers/app_router.gr.dart';
import 'package:fitness/common/res/colors.dart';
import 'package:fitness/features/favourites/presentation/bloc/favourites_bloc.dart';
import 'package:fitness/features/meals/presentation/widgets/meal_card.dart';
import 'package:fitness/features/favourites/presentation/widgets/empty_favourites_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_animate/flutter_animate.dart';

@RoutePage()
class FavouritesPage extends StatefulWidget {
  const FavouritesPage({super.key});

  @override
  State<FavouritesPage> createState() => _FavouritesPageState();
}

class _FavouritesPageState extends State<FavouritesPage> {
  @override
  void initState() {
    super.initState();
    context.read<FavouritesBloc>().add(LoadFavouritesEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.cardDark,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          'Bookmarks',
          style: GoogleFonts.acme(
            fontWeight: FontWeight.bold,
            color: AppColors.cardLight,
          ),
        ),
        actions: [
          BlocBuilder<FavouritesBloc, FavouritesState>(
            builder: (context, state) {
              if (state is FavouritesLoaded && state.favourites.isNotEmpty) {
                return IconButton(
                  icon:
                      const Icon(Icons.delete_outline, color: AppColors.error),
                  onPressed: () => _showClearAllDialog(context),
                );
              }
              return const SizedBox.shrink();
            },
          ),
        ],
      ),
      body: BlocConsumer<FavouritesBloc, FavouritesState>(
        listener: (context, state) {
          if (state is FavouriteToggled) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  state.isFavourite
                      ? 'Added to bookmarks'
                      : 'Removed from bookmarks',
                ),
                backgroundColor:
                    state.isFavourite ? Colors.green : AppColors.error,
                duration: const Duration(seconds: 2),
                behavior: SnackBarBehavior.floating,
              ),
            );
            // Reload favourites after toggle
            context.read<FavouritesBloc>().add(LoadFavouritesEvent());
          }

          if (state is FavouritesError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
                backgroundColor: AppColors.error,
                behavior: SnackBarBehavior.floating,
              ),
            );
          }
        },
        builder: (context, state) {
          if (state is FavouritesLoading) {
            return const Center(
              child: CircularProgressIndicator(color: AppColors.primary),
            );
          }

          if (state is FavouritesLoaded) {
            if (state.favourites.isEmpty) {
              return const EmptyFavoritesView();
            }

            return RefreshIndicator(
              onRefresh: () async {
                context.read<FavouritesBloc>().add(LoadFavouritesEvent());
              },
              color: AppColors.primary,
              child: GridView.builder(
                padding: const EdgeInsets.all(16),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 16,
                  crossAxisSpacing: 16,
                  childAspectRatio: 0.75,
                ),
                itemCount: state.favourites.length,
                itemBuilder: (context, index) {
                  final meal = state.favourites[index];
                  return MealCard(
                    meal: meal,
                    onTap: () {
                      context.router.push(MealDetailRoute(meal: meal));
                    },
                  )
                      .animate()
                      .fadeIn(delay: (index * 50).ms)
                      .scale(begin: const Offset(0.8, 0.8));
                },
              ),
            );
          }

          // Initial or error state
          return EmptyFavoritesView();
        },
      ),
    );
  }

  void _showClearAllDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog.adaptive(
        backgroundColor: AppColors.cardDark,
        title: Text(
          'Clear All bookmarks?',
          style: GoogleFonts.poppins(
            color: AppColors.cardLight,
            fontWeight: FontWeight.bold,
          ),
        ),
        content: Text(
          'This will remove all meals from your bookmarks.',
          style: TextStyle(color: AppColors.cardLight.withValues(alpha: 0.8)),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: const Text(
              'Cancel',
              style: TextStyle(color: AppColors.cardLight),
            ),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(dialogContext);
              // Clear all favourites
              final bloc = context.read<FavouritesBloc>();
              final state = bloc.state;
              if (state is FavouritesLoaded) {
                for (var meal in state.favourites) {
                  bloc.add(DeleteFavouriteEvent(meal: meal));
                }
              }
            },
            child: const Text(
              'Clear All',
              style: TextStyle(color: AppColors.error),
            ),
          ),
        ],
      ),
    );
  }
}
