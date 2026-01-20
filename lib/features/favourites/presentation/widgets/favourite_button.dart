// lib/features/favourites/presentation/widgets/favourite_button.dart
import 'package:fitness/common/res/colors.dart';
import 'package:fitness/features/favourites/presentation/bloc/favourites_bloc.dart';
import 'package:fitness/features/meals/data/models/meal_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_animate/flutter_animate.dart';

class FavouriteButton extends StatefulWidget {
  final MealModel meal;
  final Color? iconColor;
  final double? iconSize;

  const FavouriteButton({
    super.key,
    required this.meal,
    this.iconColor,
    this.iconSize = 28,
  });

  @override
  State<FavouriteButton> createState() => _FavouriteButtonState();
}

class _FavouriteButtonState extends State<FavouriteButton> {
  bool? _isFavourite;

  @override
  void initState() {
    super.initState();
    // Check if meal is favourite on init
    context.read<FavouritesBloc>().add(CheckIfFavEvent(meal: widget.meal));
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<FavouritesBloc, FavouritesState>(
      listener: (context, state) {
        if (state is FavouriteChecked && state.meal.id == widget.meal.id) {
          setState(() {
            _isFavourite = state.isFavourite;
          });
        }

        if (state is FavouriteToggled && state.meal.id == widget.meal.id) {
          setState(() {
            _isFavourite = state.isFavourite;
          });
        }
      },
      builder: (context, state) {
        if (_isFavourite == null) {
          // Loading state
          return SizedBox(
            width: widget.iconSize,
            height: widget.iconSize,
            child: CircularProgressIndicator(
              strokeWidth: 2,
              color: widget.iconColor ?? AppColors.primary,
            ),
          );
        }

        return IconButton(
          onPressed: () {
            // Toggle favourite
            context.read<FavouritesBloc>().add(
                  ToggleFavouriteEvent(meal: widget.meal),
                );

            // Optimistic update
            setState(() {
              _isFavourite = !_isFavourite!;
            });
          },
          icon: Icon(
            _isFavourite! ? Icons.bookmark : Icons.bookmark_border,
            color: _isFavourite!
                ? AppColors.primary
                : (widget.iconColor ?? AppColors.cardLight),
            size: widget.iconSize,
          )
              .animate(
                key: ValueKey(_isFavourite),
                target: _isFavourite! ? 1 : 0,
              )
              .scale(
                begin: const Offset(0.8, 0.8),
                end: const Offset(1.2, 1.2),
                curve: Curves.easeOut,
                duration: 1200.ms,
              )
              .then()
              .scale(
                begin: const Offset(1.2, 1.2),
                end: const Offset(1.0, 1.0),
                duration: 1100.ms,
              ),
        );
      },
    );
  }
}
