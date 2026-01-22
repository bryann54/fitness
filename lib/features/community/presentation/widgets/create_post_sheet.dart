// lib/features/community/presentation/widgets/create_post_sheet.dart
import 'package:fitness/common/res/colors.dart';
import 'package:fitness/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:fitness/features/community/data/models/community_post_model.dart';
import 'package:fitness/features/community/presentation/bloc/feed/feed_bloc.dart';
import 'package:fitness/features/onboarding/presentation/bloc/onboarding_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:uuid/uuid.dart';

class CreatePostSheet extends StatefulWidget {
  const CreatePostSheet({super.key});

  @override
  State<CreatePostSheet> createState() => _CreatePostSheetState();
}

class _CreatePostSheetState extends State<CreatePostSheet> {
  final TextEditingController _contentController = TextEditingController();
  PostType _selectedType = PostType.motivation;
  bool _isLoading = false;

  @override
  void dispose() {
    _contentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
        top: 20,
        left: 20,
        right: 20,
      ),
      decoration: const BoxDecoration(
        color: AppColors.cardDark,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Drag handle
            Center(
              child: Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: AppColors.textPrimaryDark.withValues(alpha: 0.3),
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
            const SizedBox(height: 20),

            // Title
            Text(
              'Share Your Journey',
              style: GoogleFonts.poppins(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: AppColors.textPrimaryDark,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'What\'s on your mind?',
              style: GoogleFonts.poppins(
                fontSize: 14,
                color: AppColors.textPrimaryDark.withValues(alpha: 0.7),
              ),
            ),
            const SizedBox(height: 24),

            // Post type selector
            _buildPostTypeSelector(),
            const SizedBox(height: 20),

            // Content input
            TextField(
              controller: _contentController,
              maxLines: 5,
              maxLength: 500,
              style: GoogleFonts.poppins(
                color: AppColors.textPrimaryDark,
                fontSize: 14,
              ),
              decoration: InputDecoration(
                hintText: _getHintText(),
                hintStyle: GoogleFonts.poppins(
                  color: AppColors.textPrimaryDark.withValues(alpha: 0.4),
                ),
                filled: true,
                fillColor: AppColors.textLightDark.withValues(alpha: 0.1),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
                counterStyle: GoogleFonts.poppins(
                  fontSize: 12,
                  color: AppColors.textPrimaryDark.withValues(alpha: 0.5),
                ),
              ),
            ),
            const SizedBox(height: 24),

            // Action buttons
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () => Navigator.pop(context),
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      side: BorderSide(
                        color: AppColors.textPrimaryDark.withValues(alpha: 0.3),
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: Text(
                      'Cancel',
                      style: GoogleFonts.poppins(
                        color: AppColors.textPrimaryDark,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton(
                    onPressed: _isLoading ? null : _handlePost,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: _isLoading
                        ? const SizedBox(
                            height: 20,
                            width: 20,
                            child: CircularProgressIndicator.adaptive(
                              
                              strokeWidth: 2,
                            ),
                          )
                        : Text(
                            'Post',
                            style: GoogleFonts.poppins(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildPostTypeSelector() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Post Type',
          style: GoogleFonts.poppins(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: AppColors.textPrimaryDark,
          ),
        ),
        const SizedBox(height: 12),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: PostType.values.map((type) {
            final isSelected = _selectedType == type;
            final icon = _getPostTypeIcon(type);
            final color = _getPostTypeColor(type);

            return ChoiceChip(
              label: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    icon,
                    size: 16,
                    color: isSelected ? Colors.white : color,
                  ),
                  const SizedBox(width: 6),
                  Text(
                    type.toString().split('.').last,
                    style: GoogleFonts.poppins(fontSize: 12),
                  ),
                ],
              ),
              selected: isSelected,
              onSelected: (selected) {
                setState(() {
                  _selectedType = type;
                });
              },
              selectedColor: color,
              backgroundColor: color.withValues(alpha: 0.1),
              labelStyle: GoogleFonts.poppins(
                color: isSelected ? Colors.white : color,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              showCheckmark: false,
            );
          }).toList(),
        ),
      ],
    );
  }

  String _getHintText() {
    switch (_selectedType) {
      case PostType.workout:
        return 'Share your workout experience...';
      case PostType.progress:
        return 'Share your progress update...';
      case PostType.achievement:
        return 'Celebrate your achievement...';
      case PostType.motivation:
        return 'Share some motivation...';
      case PostType.question:
        return 'Ask the community...';
    }
  }

  IconData _getPostTypeIcon(PostType type) {
    switch (type) {
      case PostType.workout:
        return FontAwesomeIcons.dumbbell;
      case PostType.progress:
        return FontAwesomeIcons.chartLine;
      case PostType.achievement:
        return FontAwesomeIcons.trophy;
      case PostType.motivation:
        return FontAwesomeIcons.fire;
      case PostType.question:
        return FontAwesomeIcons.circleQuestion;
    }
  }

  Color _getPostTypeColor(PostType type) {
    switch (type) {
      case PostType.workout:
        return Colors.orange;
      case PostType.progress:
        return Colors.green;
      case PostType.achievement:
        return Colors.amber;
      case PostType.motivation:
        return Colors.red;
      case PostType.question:
        return Colors.blue;
    }
  }

  Future<void> _handlePost() async {
    if (_contentController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Please write something',
            style: GoogleFonts.poppins(),
          ),
          backgroundColor: AppColors.error,
        ),
      );
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      final authState = context.read<AuthBloc>().state;
      final onboardingState = context.read<OnboardingBloc>().state;

      if (authState is! AuthAuthenticated ||
          onboardingState is! OnboardingProfileLoaded) {
        throw Exception('User not authenticated');
      }

      final user = authState.user;
      final profile = onboardingState.profile;

      final post = CommunityPostModel(
        id: const Uuid().v4(),
        userId: user.uid,
        userName: user.displayName ?? 'User',
        userPhotoUrl: user.photoUrl,
        postType: _selectedType,
        content: _contentController.text.trim(),
        mediaUrls: const [],
        createdAt: DateTime.now(),
        userGender: profile.gender,
        userFitnessGoal: profile.primaryGoal.toString(),
        userExperience: profile.experience.toString(),
        userWorkoutPreferences: profile.workoutPreferences,
      );

      context.read<FeedBloc>().add(CreatePostEvent(post));

      Navigator.pop(context);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Post shared successfully!',
            style: GoogleFonts.poppins(),
          ),
          backgroundColor: Colors.green,
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Failed to create post: $e',
            style: GoogleFonts.poppins(),
          ),
          backgroundColor: AppColors.error,
        ),
      );
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }
}
