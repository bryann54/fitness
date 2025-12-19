// lib/features/auth/presentation/widgets/getstarted/intro_background.dart
import 'package:flutter/material.dart';
import 'package:fitness/common/res/colors.dart';

class IntroBackground extends StatelessWidget {
  final String? imagePath; // Optional background image

  const IntroBackground({
    super.key,
    this.imagePath,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Stack(
      children: [
        // Optional background image layer
        if (imagePath != null)
          Positioned.fill(
            child: Image.asset(
              imagePath!,
              fit: BoxFit.cover,
              cacheWidth: size.width.toInt() * 2,
            ),
          ),

        // Split gradient overlay - reduced opacity for better image visibility
        Row(
          children: [
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      AppColors.visualDarkBackgroundHalf.withValues(alpha: 0.4),
                      AppColors.visualDarkBackgroundHalf.withValues(alpha: 0.5),
                    ],
                  ),
                ),
              ),
            ),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topRight,
                    end: Alignment.bottomLeft,
                    colors: [
                      AppColors.visualLightBackgroundHalf
                          .withValues(alpha: 0.4),
                      AppColors.visualLightBackgroundHalf
                          .withValues(alpha: 0.5),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),

        // Center divider with more prominent glow effect
        Positioned(
          left: size.width / 2 - 1,
          top: 0,
          bottom: 0,
          child: Container(
            width: 2,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.transparent,
                  Colors.white.withValues(alpha: 0.25),
                  Colors.white.withValues(alpha: 0.4),
                  Colors.white.withValues(alpha: 0.25),
                  Colors.transparent,
                ],
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.white.withValues(alpha: 0.3),
                  blurRadius: 8,
                  spreadRadius: 1,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
