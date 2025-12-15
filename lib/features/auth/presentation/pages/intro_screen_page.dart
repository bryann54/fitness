import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:fitness/common/res/colors.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class IntroScreenPage extends StatelessWidget {
  final IconData? icon;
  final String? imagePath;
  final String title;
  final String description;

  const IntroScreenPage({
    super.key,
    this.icon,
    this.imagePath,
    required this.title,
    required this.description,
  }) : assert(
          icon != null || imagePath != null,
          'Either icon or imagePath must be provided',
        );

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDarkMode = theme.brightness == Brightness.dark;

    final Color leftColor = Colors.black;
    final Color rightColor = Colors.white;
    final Color darkSideTextColor = Colors.white;
    final Color lightSideTextColor = AppColors.textPrimary;
    final Color lightSideSecondaryTextColor = AppColors.textSecondary;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Image or Icon with your gradient styling
          if (imagePath != null)
            _buildImageContainer(
              isDarkMode,
              leftColor,
              rightColor,
            )
          else if (icon != null)
            _buildIconContainer(
              isDarkMode,
              leftColor,
              rightColor,
            ),

          const SizedBox(height: 56),

          // Enhanced title with gradient (unchanged)
          ShaderMask(
            shaderCallback: (bounds) => LinearGradient(
              colors: [
                darkSideTextColor,
                lightSideTextColor,
              ],
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              stops: const [0.5, 0.5],
            ).createShader(bounds),
            child: Text(
              title,
              textAlign: TextAlign.center,
              style: GoogleFonts.poppins(
                fontSize: 32,
                fontWeight: FontWeight.w700,
                color: Colors.white,
                height: 1.2,
                letterSpacing: -0.5,
              ),
            ),
          ),

          const SizedBox(height: 20),

          // Enhanced description (unchanged)
          ShaderMask(
            shaderCallback: (bounds) => LinearGradient(
              colors: [
                darkSideTextColor.withValues(alpha: 0.85),
                lightSideSecondaryTextColor.withValues(alpha: 0.9),
              ],
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              stops: const [0.5, 0.5],
            ).createShader(bounds),
            child: Text(
              description,
              textAlign: TextAlign.center,
              style: GoogleFonts.poppins(
                fontSize: 17,
                color: Colors.white,
                height: 1.5,
                fontWeight: FontWeight.w400,
                letterSpacing: 0.2,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildImageContainer(
    bool isDarkMode,
    Color leftColor,
    Color rightColor,
  ) {
    return Container(
      height: 240,
      width: 240,
      decoration: BoxDecoration(
        shape: BoxShape.rectangle,
        borderRadius: BorderRadius.circular(20),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            rightColor.withValues(alpha: isDarkMode ? 0.08 : 0.03),
            leftColor.withValues(alpha: isDarkMode ? 0.12 : 0.05),
          ],
        ),
        border: Border.all(
          color: isDarkMode
              ? Colors.white.withValues(alpha: 0.1)
              : Colors.black.withValues(alpha: 0.05),
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: isDarkMode
                ? Colors.black.withValues(alpha: 0.3)
                : Colors.black.withValues(alpha: 0.08),
            blurRadius: isDarkMode ? 30 : 20,
            offset: const Offset(0, 10),
            spreadRadius: isDarkMode ? 2 : 0,
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Stack(
          fit: StackFit.expand,
          children: [
            // Image with shader mask for gradient effect
            ShaderMask(
              shaderCallback: (bounds) => LinearGradient(
                colors: [
                  rightColor.withValues(alpha: 0.3),
                  leftColor.withValues(alpha: 0.3),
                ],
                stops: const [0.3, 0.7],
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
              ).createShader(bounds),
              blendMode: BlendMode.overlay,
              child: Image.asset(
                imagePath!,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  // Fallback to gradient with icon if image fails
                  return Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          rightColor.withValues(alpha: isDarkMode ? 0.15 : 0.1),
                          leftColor.withValues(alpha: isDarkMode ? 0.25 : 0.15),
                        ],
                      ),
                    ),
                    child: Center(
                      child: ShaderMask(
                        shaderCallback: (bounds) => LinearGradient(
                          colors: [rightColor, leftColor],
                          stops: const [0.3, 0.7],
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                        ).createShader(bounds),
                        child: const FaIcon(
                          FontAwesomeIcons.dumbbell,
                          size: 64,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),

            // Subtle gradient overlay to maintain your aesthetic
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.transparent,
                    isDarkMode
                        ? Colors.black.withValues(alpha: 0.2)
                        : Colors.white.withValues(alpha: 0.1),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildIconContainer(
    bool isDarkMode,
    Color leftColor,
    Color rightColor,
  ) {
    return Container(
      height: 240,
      width: 240,
      decoration: BoxDecoration(
        shape: BoxShape.rectangle,
        borderRadius: BorderRadius.circular(20),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            rightColor.withValues(alpha: isDarkMode ? 0.08 : 0.03),
            leftColor.withValues(alpha: isDarkMode ? 0.12 : 0.05),
          ],
        ),
        border: Border.all(
          color: isDarkMode
              ? Colors.white.withValues(alpha: 0.1)
              : Colors.black.withValues(alpha: 0.05),
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: isDarkMode
                ? Colors.black.withValues(alpha: 0.3)
                : Colors.black.withValues(alpha: 0.08),
            blurRadius: isDarkMode ? 30 : 20,
            offset: const Offset(0, 10),
            spreadRadius: isDarkMode ? 2 : 0,
          ),
        ],
      ),
      child: Center(
        child: ShaderMask(
          shaderCallback: (bounds) => LinearGradient(
            colors: [rightColor, leftColor],
            stops: const [0.3, 0.7],
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
          ).createShader(bounds),
          child: FaIcon(
            icon!,
            size: 64,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
