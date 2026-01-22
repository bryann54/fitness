// lib/features/community/presentation/widgets/buddies_tab.dart
import 'package:fitness/common/res/colors.dart';
import 'package:fitness/features/community/presentation/bloc/buddies/buddies_bloc.dart';
import 'package:fitness/features/community/presentation/bloc/buddies/buddies_state.dart';
import 'package:fitness/features/community/presentation/widgets/buddy_card.dart';
import 'package:fitness/features/onboarding/presentation/bloc/onboarding_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

enum BuddiesTabType { suggested, myBuddies, requests }

class BuddiesTab extends StatefulWidget {
  const BuddiesTab({super.key});

  @override
  State<BuddiesTab> createState() => _BuddiesTabState();
}

class _BuddiesTabState extends State<BuddiesTab>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  BuddiesTabType _selectedTab = BuddiesTabType.suggested;

  @override
  void initState() {
    super.initState();
    _loadSuggestedBuddies();
  }

  void _loadSuggestedBuddies() {
    final onboardingState = context.read<OnboardingBloc>().state;
    if (onboardingState is OnboardingProfileLoaded) {
      context.read<BuddiesBloc>().add(
            LoadSuggestedBuddiesEvent(onboardingState.profile),
          );
    }
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return CustomScrollView(
      slivers: [
        // Header
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: AppColors.primary.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Icon(
                        FontAwesomeIcons.userGroup,
                        color: AppColors.primary,
                        size: 24,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Find Your Workout Buddy',
                            style: GoogleFonts.poppins(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: AppColors.textPrimaryDark,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            'Connect with people who share your goals',
                            style: GoogleFonts.poppins(
                              fontSize: 13,
                              color: AppColors.textPrimaryDark
                                  .withValues(alpha: 0.6),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),

        // Tab selector
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  _buildTabButton(
                    'Suggested',
                    BuddiesTabType.suggested,
                    FontAwesomeIcons.lightbulb,
                  ),
                  const SizedBox(width: 12),
                  _buildTabButton(
                    'My Buddies',
                    BuddiesTabType.myBuddies,
                    FontAwesomeIcons.userGroup,
                  ),
                  const SizedBox(width: 12),
                  _buildTabButton(
                    'Requests',
                    BuddiesTabType.requests,
                    FontAwesomeIcons.inbox,
                  ),
                ],
              ),
            ),
          ),
        ),

        const SliverToBoxAdapter(
          child: SizedBox(height: 20),
        ),

        // Content based on selected tab
        _buildTabContent(),
      ],
    );
  }

  Widget _buildTabButton(String label, BuddiesTabType type, IconData icon) {
    final isActive = _selectedTab == type;

    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedTab = type;
        });

        // Load data based on tab
        switch (type) {
          case BuddiesTabType.suggested:
            _loadSuggestedBuddies();
            break;
          case BuddiesTabType.myBuddies:
            context.read<BuddiesBloc>().add(LoadMyBuddiesEvent());
            break;
          case BuddiesTabType.requests:
            // TODO: Load requests
            break;
        }
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        decoration: BoxDecoration(
          color: isActive
              ? AppColors.primary
              : AppColors.textLightDark.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(20),
          border: isActive
              ? null
              : Border.all(
                  color: AppColors.textPrimaryDark.withValues(alpha: 0.2),
                ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              size: 14,
              color: isActive
                  ? Colors.white
                  : AppColors.textPrimaryDark.withValues(alpha: 0.6),
            ),
            const SizedBox(width: 8),
            Text(
              label,
              style: GoogleFonts.poppins(
                fontSize: 13,
                fontWeight: isActive ? FontWeight.w600 : FontWeight.normal,
                color: isActive
                    ? Colors.white
                    : AppColors.textPrimaryDark.withValues(alpha: 0.6),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTabContent() {
    return BlocBuilder<BuddiesBloc, BuddiesState>(
      builder: (context, state) {
        if (state is BuddiesLoading) {
          return const SliverFillRemaining(
            child: Center(
              child:
                  CircularProgressIndicator.adaptive(),
            ),
          );
        }

        if (state is BuddiesError) {
          return SliverFillRemaining(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    FontAwesomeIcons.triangleExclamation,
                    size: 64,
                    color: AppColors.error,
                  ),
                  const SizedBox(height: 16),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 40),
                    child: Text(
                      state.message,
                      style: GoogleFonts.poppins(
                        color: AppColors.textPrimaryDark,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: _loadSuggestedBuddies,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                    ),
                    child: const Text('Retry'),
                  ),
                ],
              ),
            ),
          );
        }

        if (state is SuggestedBuddiesLoaded) {
          if (state.buddies.isEmpty) {
            return _buildEmptyState(
              icon: FontAwesomeIcons.userGroup,
              title: 'No Suggestions Yet',
              subtitle:
                  'Complete your profile to get buddy recommendations based on your fitness goals',
            );
          }

          return _buildBuddiesList(state.buddies);
        }

        if (state is MyBuddiesLoaded) {
          if (state.connections.isEmpty) {
            return _buildEmptyState(
              icon: FontAwesomeIcons.userGroup,
              title: 'No Buddies Yet',
              subtitle:
                  'Connect with suggested buddies to start your fitness journey together',
            );
          }

          return _buildConnectionsList(state.connections);
        }

        // Initial or requests state
        return _buildEmptyState(
          icon: FontAwesomeIcons.inbox,
          title: 'No Requests',
          subtitle: 'Buddy requests will appear here',
        );
      },
    );
  }

  Widget _buildBuddiesList(List buddies) {
    return SliverPadding(
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 100),
      sliver: SliverList(
        delegate: SliverChildBuilderDelegate(
          (context, index) {
            final profile = buddies[index];
            return BuddyCard(
              profile: profile,
              onConnect: () {
                context.read<BuddiesBloc>().add(
                      ConnectWithBuddyEvent(
                        userId: profile.uid,
                        userName: 'User ${profile.uid.substring(0, 8)}',
                        photoUrl: null,
                      ),
                    );

                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      'Connected with buddy!',
                      style: GoogleFonts.poppins(),
                    ),
                    backgroundColor: Colors.green,
                    behavior: SnackBarBehavior.floating,
                    action: SnackBarAction(
                      label: 'View',
                      textColor: Colors.white,
                      onPressed: () {
                        setState(() {
                          _selectedTab = BuddiesTabType.myBuddies;
                        });
                        context.read<BuddiesBloc>().add(LoadMyBuddiesEvent());
                      },
                    ),
                  ),
                );
              },
            ).animate().fadeIn(
                  duration: 400.ms,
                  delay: Duration(milliseconds: index * 50),
                );
          },
          childCount: buddies.length,
        ),
      ),
    );
  }

  Widget _buildConnectionsList(List connections) {
    return SliverPadding(
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 100),
      sliver: SliverList(
        delegate: SliverChildBuilderDelegate(
          (context, index) {
            final connection = connections[index];
            return Container(
              margin: const EdgeInsets.only(bottom: 16),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppColors.textLightDark.withValues(alpha: 0.05),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: AppColors.textPrimaryDark.withValues(alpha: 0.1),
                ),
              ),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 32,
                    backgroundColor: AppColors.primary.withValues(alpha: 0.2),
                    child: Text(
                      connection.connectedUserName[0].toUpperCase(),
                      style: GoogleFonts.poppins(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: AppColors.primary,
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          connection.connectedUserName,
                          style: GoogleFonts.poppins(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: AppColors.textPrimaryDark,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'Connected',
                          style: GoogleFonts.poppins(
                            fontSize: 12,
                            color: Colors.green,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      // TODO: View profile or message
                    },
                    icon: const Icon(
                      FontAwesomeIcons.message,
                      color: AppColors.primary,
                      size: 20,
                    ),
                  ),
                ],
              ),
            ).animate().fadeIn(
                  duration: 400.ms,
                  delay: Duration(milliseconds: index * 50),
                );
          },
          childCount: connections.length,
        ),
      ),
    );
  }

  Widget _buildEmptyState({
    required IconData icon,
    required String title,
    required String subtitle,
  }) {
    return SliverFillRemaining(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(32),
              decoration: BoxDecoration(
                color: AppColors.primary.withValues(alpha: 0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(
                icon,
                size: 64,
                color: AppColors.primary,
              ),
            ),
            const SizedBox(height: 24),
            Text(
              title,
              style: GoogleFonts.poppins(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: AppColors.textPrimaryDark,
              ),
            ),
            const SizedBox(height: 12),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: Text(
                subtitle,
                style: GoogleFonts.poppins(
                  fontSize: 14,
                  color: AppColors.textPrimaryDark.withValues(alpha: 0.7),
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ).animate().fadeIn(duration: 600.ms),
      ),
    );
  }
}
