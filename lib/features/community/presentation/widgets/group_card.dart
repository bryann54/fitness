import 'package:cached_network_image/cached_network_image.dart';
import 'package:fitness/common/res/colors.dart';
import 'package:fitness/features/community/data/models/community_group_model.dart';
import 'package:fitness/features/community/presentation/bloc/groups/groups_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

class GroupCard extends StatelessWidget {
  final CommunityGroupModel group;

  const GroupCard({super.key, required this.group});

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
          // Group image
          ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
            child: CachedNetworkImage(
              imageUrl: group.imageUrl,
              height: 150,
              width: double.infinity,
              fit: BoxFit.cover,
              placeholder: (context, url) => Container(
                color: AppColors.textLightDark.withValues(alpha: 0.2),
                child: const Center(
                  child: CircularProgressIndicator(color: AppColors.primary),
                ),
              ),
              errorWidget: (context, url, error) => Container(
                color: AppColors.textLightDark.withValues(alpha: 0.2),
                child: const Icon(
                  FontAwesomeIcons.userGroup,
                  size: 48,
                  color: AppColors.primary,
                ),
              ),
            ),
          ),

          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Group name and type badge
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        group.name,
                        style: GoogleFonts.poppins(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: AppColors.textPrimaryDark,
                        ),
                      ),
                    ),
                    _buildGroupTypeBadge(group.groupType),
                  ],
                ),
                const SizedBox(height: 8),

                // Description
                Text(
                  group.description,
                  style: GoogleFonts.poppins(
                    fontSize: 13,
                    color: AppColors.textPrimaryDark.withValues(alpha: 0.7),
                    height: 1.4,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 16),

                // Stats row
                Row(
                  children: [
                    Icon(
                      FontAwesomeIcons.users,
                      size: 14,
                      color: AppColors.textPrimaryDark.withValues(alpha: 0.6),
                    ),
                    const SizedBox(width: 6),
                    Text(
                      '${group.memberCount} members',
                      style: GoogleFonts.poppins(
                        fontSize: 12,
                        color: AppColors.textPrimaryDark.withValues(alpha: 0.6),
                      ),
                    ),
                    const Spacer(),
                    ElevatedButton(
                      onPressed: () {
                        // TODO: Join group
                        context
                            .read<GroupsBloc>()
                            .add(JoinGroupEvent(group.id));
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primary,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 24,
                          vertical: 10,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      child: Text(
                        'Join',
                        style: GoogleFonts.poppins(
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildGroupTypeBadge(GroupType type) {
    IconData icon;
    Color color;
    String label;

    switch (type) {
      case GroupType.goal:
        icon = FontAwesomeIcons.bullseye;
        color = Colors.orange;
        label = 'Goal';
        break;
      case GroupType.workout:
        icon = FontAwesomeIcons.dumbbell;
        color = Colors.blue;
        label = 'Workout';
        break;
      case GroupType.experience:
        icon = FontAwesomeIcons.graduationCap;
        color = Colors.purple;
        label = 'Level';
        break;
      case GroupType.general:
        icon = FontAwesomeIcons.star;
        color = Colors.amber;
        label = 'General';
        break;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.2),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 12, color: color),
          const SizedBox(width: 4),
          Text(
            label,
            style: GoogleFonts.poppins(
              fontSize: 10,
              fontWeight: FontWeight.w600,
              color: color,
            ),
          ),
        ],
      ),
    );
  }
}
