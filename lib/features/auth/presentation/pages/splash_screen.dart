import 'package:auto_route/auto_route.dart';
import 'package:fitness/features/auth/presentation/widgets/getstarted/intro_background.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:fitness/common/helpers/app_router.gr.dart';
import 'package:fitness/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:fitness/common/res/colors.dart';

@RoutePage()
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late Animation<double> _slideAnimation;

  bool _authCheckCompleted = false;
  bool _animationCompleted = false;

  @override
  void initState() {
    super.initState();
    _setupAnimations();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<AuthBloc>().add(AuthCheckStatus());
    });
  }

  void _setupAnimations() {
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 3800),
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: const Interval(0.0, 0.7, curve: Curves.easeOut),
      ),
    );

    _slideAnimation = Tween<double>(begin: 30.0, end: 0.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: const Interval(0.3, 1.0, curve: Curves.easeOutCubic),
      ),
    );

    _animationController.forward().then((_) {
      setState(() {
        _animationCompleted = true;
      });
      _tryNavigate();
    });
  }

  void _tryNavigate() {
    if (!mounted) return;

    if (_authCheckCompleted && _animationCompleted) {
      final currentAuthState = context.read<AuthBloc>().state;

      if (currentAuthState is AuthAuthenticated) {
        context.router.replace(const MainRoute());
      } else if (currentAuthState is AuthUnauthenticated) {
        context.router.replace(const GetStartedRoute());
      } else if (currentAuthState is AuthError) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              content:
                  Text('Authentication Error: ${currentAuthState.message}')),
        );
        context.router.replace(const GetStartedRoute());
      }
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness ==
        Brightness.dark; // Still useful for other elements

    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        setState(() {
          _authCheckCompleted = true;
        });
        _tryNavigate();
      },
      child: Scaffold(
        body: AnimatedBuilder(
          animation: _animationController,
          builder: (context, child) {
            return Stack(
              children: [
                const IntroBackground(imagePath: 'assets/bg1.jpg'),
                // Main content
                Center(
                  child: FadeTransition(
                    opacity: _fadeAnimation,
                    child: Transform.translate(
                      offset: Offset(0, _slideAnimation.value),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Hero(
                            tag: 'app_logo',
                            child: Container(
                              width: 120,
                              height: 120,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                boxShadow: [
                                  BoxShadow(
                                    color: AppColors.cardDark
                                        .withValues(alpha: 0.1),
                                    blurRadius: 20,
                                    offset: const Offset(0, 10),
                                  ),
                                ],
                                gradient: LinearGradient(
                                  colors: [
                                    AppColors.visualLightBackgroundHalf
                                        .withValues(alpha: 0.3),
                                    AppColors.visualDarkBackgroundHalf
                                        .withValues(alpha: 0.3),
                                  ],
                                  begin: Alignment.centerLeft,
                                  end: Alignment.centerRight,
                                  stops: const [0.5, 0.5],
                                ),
                              ),
                              padding: const EdgeInsets.all(3),
                              child: Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(17),
                                    color: AppColors.cardLight),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(17),
                                  child: Image.asset(
                                    'assets/fit.png',
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 32),
                          ShaderMask(
                            shaderCallback: (bounds) => LinearGradient(
                              colors: [
                                AppColors.visualLightBackgroundHalf,
                                AppColors.textPrimary,
                              ],
                              begin: Alignment.centerLeft,
                              end: Alignment.centerRight,
                              stops: const [0.5, 0.5],
                            ).createShader(bounds),
                            child: Text(
                              'fitness',
                              style: GoogleFonts.poppins(
                                fontSize: 32,
                                fontWeight: FontWeight.w700,
                                letterSpacing: -0.5,
                                color: AppColors.cardLight,
                              ),
                            ),
                          ),
                          const SizedBox(height: 8),
                          ShaderMask(
                            shaderCallback: (bounds) => LinearGradient(
                              colors: [
                                AppColors.cardLight,
                                AppColors.textSecondary,
                              ],
                              begin: Alignment.centerLeft,
                              end: Alignment.centerRight,
                              stops: const [0.55, 0.55],
                            ).createShader(bounds),
                            child: Text(
                              'Fitness for Everyone',
                              style: GoogleFonts.poppins(
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                letterSpacing: 0.5,
                                color: AppColors.visualLightBackgroundHalf,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                if (!_authCheckCompleted)
                  Positioned(
                    bottom: 60,
                    left: 0,
                    right: 0,
                    child: Center(
                      child: SizedBox(
                        width: 24,
                        height: 24,
                        child: CircularProgressIndicator.adaptive(
                          strokeWidth: 2,
                          valueColor: AlwaysStoppedAnimation<Color>(
                            isDark
                                ? AppColors.textLightDark
                                : AppColors.textLight,
                          ),
                        ),
                      ),
                    ),
                  ),
              ],
            );
          },
        ),
      ),
    );
  }
}
