// lib/features/community/presentation/widgets/post_card.dart
import 'package:cached_network_image/cached_network_image.dart';
import 'package:fitness/common/res/colors.dart';
import 'package:fitness/common/utils/date_utils.dart';
import 'package:fitness/features/community/data/models/community_post_model.dart';
import 'package:fitness/features/community/presentation/widgets/comments_sheet.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

class PostCard extends StatelessWidget {
  final CommunityPostModel post;
  final VoidCallback onLike;
  final String? currentUserId;
  final VoidCallback? onDelete;

  const PostCard({
    super.key,
    required this.post,
    required this.onLike,
    this.currentUserId,
    this.onDelete,
  });

  bool get isOwnPost => currentUserId != null && post.userId == currentUserId;
  bool get isLiked =>
      currentUserId != null && post.likedBy.contains(currentUserId);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: AppColors.textLightDark.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: AppColors.textPrimaryDark.withValues(alpha: 0.1),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildHeader(context),
          _buildContent(),
          if (post.mediaUrls.isNotEmpty) _buildMedia(),
          if (post.workoutName != null) _buildWorkoutInfo(),
          if (post.weightChange != null) _buildProgressInfo(),
          if (post.achievementBadge != null) _buildAchievementInfo(),
          _buildActions(context),
        ],
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          CircleAvatar(
            radius: 24,
            backgroundColor: AppColors.primary.withValues(alpha: 0.2),
            backgroundImage: post.userPhotoUrl != null
                ? CachedNetworkImageProvider(post.userPhotoUrl!)
                : null,
            child: post.userPhotoUrl == null
                ? Text(
                    post.userName[0].toUpperCase(),
                    style: GoogleFonts.poppins(
                      color: AppColors.primary,
                      fontWeight: FontWeight.bold,
                    ),
                  )
                : null,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  post.userName,
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: AppColors.textPrimaryDark,
                  ),
                ),
                Text(
                  formatDateObj(post.createdAt),
                  style: GoogleFonts.poppins(
                    fontSize: 12,
                    color: AppColors.textPrimaryDark.withValues(alpha: 0.6),
                  ),
                ),
              ],
            ),
          ),
          _buildPostTypeChip(),
          if (isOwnPost) ...[
            const SizedBox(width: 8),
            PopupMenuButton(
              icon: Icon(
                FontAwesomeIcons.ellipsisVertical,
                size: 18,
                color: AppColors.textPrimaryDark.withValues(alpha: 0.6),
              ),
              itemBuilder: (context) => [
                PopupMenuItem(
                  onTap: () {
                    Future.delayed(
                      const Duration(milliseconds: 100),
                      () => _showDeleteConfirmation(context),
                    );
                  },
                  child: Row(
                    children: [
                      const Icon(
                        FontAwesomeIcons.trashCan,
                        size: 16,
                        color: AppColors.error,
                      ),
                      const SizedBox(width: 12),
                      Text(
                        'Delete Post',
                        style: GoogleFonts.poppins(
                          color: AppColors.error,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildPostTypeChip() {
    IconData icon;
    Color color;

    switch (post.postType) {
      case PostType.workout:
        icon = FontAwesomeIcons.dumbbell;
        color = Colors.orange;
        break;
      case PostType.progress:
        icon = FontAwesomeIcons.chartLine;
        color = Colors.green;
        break;
      case PostType.achievement:
        icon = FontAwesomeIcons.trophy;
        color = Colors.amber;
        break;
      case PostType.motivation:
        icon = FontAwesomeIcons.fire;
        color = Colors.red;
        break;
      case PostType.question:
        icon = FontAwesomeIcons.circleQuestion;
        color = Colors.blue;
        break;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.2),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 14, color: color),
          const SizedBox(width: 6),
          Text(
            post.postType.toString().split('.').last,
            style: GoogleFonts.poppins(
              fontSize: 11,
              fontWeight: FontWeight.w600,
              color: color,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContent() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Text(
        post.content,
        style: GoogleFonts.poppins(
          fontSize: 14,
          color: AppColors.textPrimaryDark,
          height: 1.5,
        ),
      ),
    );
  }

  Widget _buildMedia() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: CachedNetworkImage(
          imageUrl: post.mediaUrls.first,
          width: double.infinity,
          height: 200,
          fit: BoxFit.cover,
          placeholder: (context, url) => Container(
            color: AppColors.textLightDark.withValues(alpha: 0.2),
            child: const Center(
              child: CircularProgressIndicator(color: AppColors.primary),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildWorkoutInfo() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.primary.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: AppColors.primary.withValues(alpha: 0.3),
        ),
      ),
      child: Row(
        children: [
          const Icon(
            FontAwesomeIcons.dumbbell,
            size: 16,
            color: AppColors.primary,
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              post.workoutName!,
              style: GoogleFonts.poppins(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: AppColors.primary,
              ),
            ),
          ),
          if (post.duration != null) ...[
            const Icon(
              FontAwesomeIcons.clock,
              size: 14,
              color: AppColors.primary,
            ),
            const SizedBox(width: 4),
            Text(
              '${post.duration} min',
              style: GoogleFonts.poppins(
                fontSize: 12,
                color: AppColors.primary,
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildProgressInfo() {
    final isPositive = post.weightChange! < 0;
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.green.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: Colors.green.withValues(alpha: 0.3),
        ),
      ),
      child: Row(
        children: [
          Icon(
            isPositive ? FontAwesomeIcons.arrowDown : FontAwesomeIcons.arrowUp,
            size: 16,
            color: Colors.green,
          ),
          const SizedBox(width: 8),
          Text(
            'Weight: ${post.weightChange!.abs().toStringAsFixed(1)}kg ${isPositive ? "lost" : "gained"}',
            style: GoogleFonts.poppins(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: Colors.green,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAchievementInfo() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.amber.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: Colors.amber.withValues(alpha: 0.3),
        ),
      ),
      child: Row(
        children: [
          Text(
            post.achievementBadge!,
            style: const TextStyle(fontSize: 24),
          ),
          const SizedBox(width: 12),
          Text(
            'Achievement Unlocked!',
            style: GoogleFonts.poppins(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: Colors.amber[700],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActions(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          _buildActionButton(
            icon:
                isLiked ? FontAwesomeIcons.solidHeart : FontAwesomeIcons.heart,
            label: '${post.likes}',
            isActive: isLiked,
            onTap: onLike,
          ),
          const SizedBox(width: 20),
          _buildActionButton(
            icon: FontAwesomeIcons.comment,
            label: '${post.comments}',
            isActive: false,
            onTap: () => _showCommentsSheet(context),
          ),
          const Spacer(),
          _buildActionButton(
            icon: FontAwesomeIcons.shareNodes,
            label: 'Share',
            isActive: false,
            onTap: () {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    'Share feature coming soon!',
                    style: GoogleFonts.poppins(),
                  ),
                  backgroundColor: AppColors.primary,
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildActionButton({
    required IconData icon,
    required String label,
    required bool isActive,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        child: Row(
          children: [
            Icon(
              icon,
              size: 18,
              color: isActive
                  ? AppColors.primary
                  : AppColors.textPrimaryDark.withValues(alpha: 0.6),
            ),
            const SizedBox(width: 6),
            Text(
              label,
              style: GoogleFonts.poppins(
                fontSize: 13,
                fontWeight: isActive ? FontWeight.w600 : FontWeight.normal,
                color: isActive
                    ? AppColors.primary
                    : AppColors.textPrimaryDark.withValues(alpha: 0.6),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showCommentsSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => CommentsSheet(
        postId: post.id,
        initialCommentCount: post.comments,
      ),
    );
  }

  void _showDeleteConfirmation(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: AppColors.cardDark,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        title: Text(
          'Delete Post',
          style: GoogleFonts.poppins(
            fontWeight: FontWeight.bold,
            color: AppColors.textPrimaryDark,
          ),
        ),
        content: Text(
          'Are you sure you want to delete this post? This action cannot be undone.',
          style: GoogleFonts.poppins(
            color: AppColors.textPrimaryDark,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              'Cancel',
              style: GoogleFonts.poppins(
                color: AppColors.textPrimaryDark.withValues(alpha: 0.7),
              ),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              if (onDelete != null) {
                onDelete!();
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.error,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: Text(
              'Delete',
              style: GoogleFonts.poppins(
                color: Colors.white,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
