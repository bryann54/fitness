// lib/common/widgets/empty_state_view.dart
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';

class EmptyStateView extends StatelessWidget {
  final String imagePath;
  final IconData floatingIcon;
  final String title;
  final String subtitle;
  final double imageSize;
  final int floatingIconCount;
  final Color? iconColor;
  final Widget? actionButton;

  const EmptyStateView({
    super.key,
    required this.imagePath,
    required this.floatingIcon,
    required this.title,
    required this.subtitle,
    this.imageSize = 150,
    this.floatingIconCount = 15,
    this.iconColor,
    this.actionButton,
  });

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Center(
      child: Stack(
        alignment: Alignment.center,
        children: [
          ...List.generate(
            floatingIconCount,
            (index) => _buildFloatingIcon(context, index, isDarkMode),
          ),
          _buildMainContent(context),
        ],
      ),
    );
  }

  Widget _buildFloatingIcon(BuildContext context, int index, bool isDarkMode) {
    final isSmall = index % 2 == 0;
    final xOffset = (index * 25 - 120).toDouble();
    final startY = index * 35 - 180.0;

    return Positioned(
      left: MediaQuery.of(context).size.width / 2 + xOffset,
      top: startY,
      child: _AnimatedFloatingIcon(
        icon: floatingIcon,
        isDarkMode: isDarkMode,
        isSmall: isSmall,
        index: index,
        iconColor: iconColor,
      ),
    );
  }

  Widget _buildMainContent(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        _AnimatedImage(
          imagePath: imagePath,
          size: imageSize,
        ),
        const SizedBox(height: 20),
        _AnimatedText(
          text: title,
          style: GoogleFonts.acme(
            textStyle: Theme.of(context).textTheme.titleLarge,
          ),
        ),
        const SizedBox(height: 10),
        _AnimatedText(
          text: subtitle,
          style: GoogleFonts.actor(
            textStyle: Theme.of(context).textTheme.bodyLarge,
          ),
          delay: 200,
        ),
        if (actionButton != null) ...[
          const SizedBox(height: 20),
          actionButton!.animate().fadeIn(duration: 600.ms, delay: 400.ms).scale(
                begin: const Offset(0.8, 0.8),
                end: const Offset(1.0, 1.0),
                duration: 800.ms,
                curve: Curves.elasticOut,
              ),
        ],
      ],
    );
  }
}

class _AnimatedFloatingIcon extends StatelessWidget {
  final IconData icon;
  final bool isDarkMode;
  final bool isSmall;
  final int index;
  final Color? iconColor;

  const _AnimatedFloatingIcon({
    required this.icon,
    required this.isDarkMode,
    required this.isSmall,
    required this.index,
    this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    final defaultColor = iconColor ?? Theme.of(context).primaryColor;

    return Icon(
      icon,
      color: defaultColor.withValues(alpha: 0.5 + (index % 5) * 0.1),
      size: isSmall ? 16.0 : 24.0,
    )
        .animate(onPlay: (controller) => controller.repeat())
        .moveY(
          begin: 0,
          end: 500,
          duration: Duration(seconds: isSmall ? 6 + index % 4 : 8 + index % 5),
          curve: Curves.easeInOut,
        )
        .fadeIn(duration: 600.ms)
        .then()
        .fadeOut(
          begin: 0.7,
          delay: Duration(seconds: isSmall ? 5 + index % 3 : 7 + index % 4),
        );
  }
}

class _AnimatedImage extends StatelessWidget {
  final String imagePath;
  final double size;

  const _AnimatedImage({
    required this.imagePath,
    required this.size,
  });

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      imagePath,
      width: size,
      height: size,
    ).animate().scale(
          begin: const Offset(0.8, 0.8),
          end: const Offset(1.0, 1.0),
          duration: 800.ms,
          curve: Curves.elasticOut,
        );
  }
}

class _AnimatedText extends StatelessWidget {
  final String text;
  final TextStyle style;
  final int delay;

  const _AnimatedText({
    required this.text,
    required this.style,
    this.delay = 0,
  });

  @override
  Widget build(BuildContext context) {
    return Text(text, style: style)
        .animate()
        .fadeIn(duration: 600.ms, delay: Duration(milliseconds: delay))
        .scale(
          begin: const Offset(0.8, 0.8),
          end: const Offset(1.0, 1.0),
          duration: 800.ms,
          curve: Curves.elasticOut,
        );
  }
}
