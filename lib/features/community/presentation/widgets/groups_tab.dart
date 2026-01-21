// lib/features/community/presentation/widgets/groups_tab.dart
import 'package:fitness/common/res/colors.dart';
import 'package:fitness/features/community/presentation/bloc/groups/groups_bloc.dart';
import 'package:fitness/features/community/presentation/widgets/group_card.dart';
import 'package:fitness/features/onboarding/presentation/bloc/onboarding_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

class GroupsTab extends StatefulWidget {
  const GroupsTab({super.key});

  @override
  State<GroupsTab> createState() => _GroupsTabState();
}

class _GroupsTabState extends State<GroupsTab>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    final onboardingState = context.read<OnboardingBloc>().state;
    if (onboardingState is OnboardingProfileLoaded) {
      context.read<GroupsBloc>().add(
            LoadRecommendedGroupsEvent(onboardingState.profile),
          );
    }
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return BlocBuilder<GroupsBloc, GroupsState>(
      builder: (context, state) {
        if (state is GroupsLoading) {
          return const Center(
            child: CircularProgressIndicator.adaptive(),
          );
        }

        if (state is GroupsError) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  FontAwesomeIcons.triangleExclamation,
                  size: 64,
                  color: AppColors.error,
                ),
                const SizedBox(height: 16),
                Text(
                  state.message,
                  style: const TextStyle(color: AppColors.textPrimaryDark),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    final onboardingState =
                        context.read<OnboardingBloc>().state;
                    if (onboardingState is OnboardingProfileLoaded) {
                      context.read<GroupsBloc>().add(
                            LoadRecommendedGroupsEvent(onboardingState.profile),
                          );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                  ),
                  child: const Text('Retry'),
                ),
              ],
            ),
          );
        }

        if (state is GroupsLoaded) {
          if (state.groups.isEmpty) {
            return _buildEmptyGroups();
          }

          return RefreshIndicator(
            onRefresh: () async {
              final onboardingState = context.read<OnboardingBloc>().state;
              if (onboardingState is OnboardingProfileLoaded) {
                context.read<GroupsBloc>().add(
                      LoadRecommendedGroupsEvent(onboardingState.profile),
                    );
              }
            },
            color: AppColors.primary,
            child: CustomScrollView(
              slivers: [
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Recommended for You',
                          style: GoogleFonts.poppins(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: AppColors.textPrimaryDark,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Based on your fitness goals and preferences',
                          style: GoogleFonts.poppins(
                            fontSize: 13,
                            color: AppColors.textPrimaryDark
                                .withValues(alpha: 0.6),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SliverPadding(
                  padding: const EdgeInsets.fromLTRB(16, 0, 16, 100),
                  sliver: SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (context, index) {
                        final group = state.groups[index];
                        return GroupCard(group: group)
                            .animate()
                            .fadeIn(
                              duration: 400.ms,
                              delay: Duration(milliseconds: index * 50),
                            )
                            .slideX(begin: 0.2, end: 0);
                      },
                      childCount: state.groups.length,
                    ),
                  ),
                ),
              ],
            ),
          );
        }

        return const SizedBox();
      },
    );
  }

  Widget _buildEmptyGroups() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(32),
            decoration: BoxDecoration(
              color: AppColors.primary.withValues(alpha: 0.1),
              shape: BoxShape.circle,
            ),
            child: const Icon(
              FontAwesomeIcons.userGroup,
              size: 64,
              color: AppColors.primary,
            ),
          ),
          const SizedBox(height: 24),
          Text(
            'No Groups Yet',
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
              'Complete your profile to get group recommendations',
              style: GoogleFonts.poppins(
                fontSize: 14,
                color: AppColors.textPrimaryDark.withValues(alpha: 0.7),
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ).animate().fadeIn(duration: 600.ms),
    );
  }
}
