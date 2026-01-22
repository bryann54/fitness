// lib/features/community/presentation/pages/community_home_page.dart
import 'package:auto_route/auto_route.dart';
import 'package:fitness/common/res/colors.dart';
import 'package:fitness/features/community/presentation/bloc/feed/feed_bloc.dart';
import 'package:fitness/features/community/presentation/bloc/feed/feed_state.dart';
import 'package:fitness/features/community/presentation/widgets/buddies_tab.dart';
import 'package:fitness/features/community/presentation/widgets/create_post_sheet.dart';
import 'package:fitness/features/community/presentation/widgets/groups_tab.dart';
import 'package:fitness/features/community/presentation/widgets/post_card.dart';
import 'package:fitness/features/notifications/presentation/widgets/empty_notifications_view.dart';
import 'package:fitness/features/onboarding/presentation/bloc/onboarding_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

@RoutePage()
class CommunityHomePage extends StatefulWidget {
  const CommunityHomePage({super.key});

  @override
  State<CommunityHomePage> createState() => _CommunityHomePageState();
}

class _CommunityHomePageState extends State<CommunityHomePage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);

    // Load feed with user profile
    final onboardingState = context.read<OnboardingBloc>().state;
    if (onboardingState is OnboardingProfileLoaded) {
      context.read<FeedBloc>().add(
            LoadFeedEvent(userProfile: onboardingState.profile),
          );
    }
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.cardDark,
      appBar: AppBar(
        backgroundColor: AppColors.cardDark,
        elevation: 0,
        title: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: AppColors.primary.withValues(alpha: 0.2),
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Icon(
                FontAwesomeIcons.userGroup,
                color: AppColors.primary,
                size: 20,
              ),
            ),
            const SizedBox(width: 12),
            // Animate only the title text for fade-in effect
            Text(
              "Community",
              style: GoogleFonts.acme(
                fontWeight: FontWeight.bold,
                fontSize: 24,
                color: AppColors.textPrimaryDark,
              ),
            ).animate().fadeIn(duration: 600.ms),
          ],
        ),
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: AppColors.primary,
          labelColor: AppColors.primary,
          unselectedLabelColor:
              AppColors.textPrimaryDark.withValues(alpha: 0.6),
          labelStyle: GoogleFonts.poppins(
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ),
          tabs: const [
            Tab(icon: Icon(FontAwesomeIcons.fire), text: 'Feed'),
            Tab(icon: Icon(FontAwesomeIcons.userGroup), text: 'Groups'),
            Tab(icon: Icon(FontAwesomeIcons.userPlus), text: 'Buddies'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildFeedTab(),
          _buildGroupsTab(),
          _buildBuddiesTab(),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          _showCreatePostDialog(context);
        },
        backgroundColor: AppColors.primary,
        icon: const Icon(FontAwesomeIcons.plus),
        label: const Text('Share'),
      ),
    );
  }

  Widget _buildFeedTab() {
    return BlocBuilder<FeedBloc, FeedState>(
      builder: (context, state) {
        if (state is FeedLoading) {
          return const Center(
            child: CircularProgressIndicator.adaptive(),
          );
        }

        if (state is FeedError) {
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
                      context.read<FeedBloc>().add(
                            LoadFeedEvent(userProfile: onboardingState.profile),
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

        if (state is FeedLoaded) {
          if (state.posts.isEmpty) {
            return EmptyProgressView();
          }

          return RefreshIndicator(
            onRefresh: () async {
              context.read<FeedBloc>().add(RefreshFeedEvent());
            },
            color: AppColors.primary,
            child: ListView.builder(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 100),
              itemCount: state.posts.length,
              itemBuilder: (context, index) {
                final post = state.posts[index];
                return PostCard(
                  post: post,
                  onLike: () {
                    final userId = context.read<OnboardingBloc>().state;
                    if (userId is OnboardingProfileLoaded) {
                      context.read<FeedBloc>().add(
                            LikePostEvent(
                              postId: post.id,
                              userId: userId.profile.uid,
                            ),
                          );
                    }
                  },
                ).animate().fadeIn(
                      duration: 400.ms,
                      delay: Duration(milliseconds: index * 50),
                    );
              },
            ),
          );
        }

        return const SizedBox();
      },
    );
  }

  Widget _buildGroupsTab() {
    return const GroupsTab();
  }

  Widget _buildBuddiesTab() {
    return const BuddiesTab();
  }

  void _showCreatePostDialog(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: AppColors.cardDark,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => const CreatePostSheet(),
    );
  }
}
