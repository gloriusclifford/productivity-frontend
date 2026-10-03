import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:productivity_app_frontend/app/theme/app_colors.dart';
import 'package:productivity_app_frontend/app/theme/app_dimens.dart';
import 'package:productivity_app_frontend/features/profile/domain/profile_models.dart';
import 'package:productivity_app_frontend/features/profile/presentation/widgets/impact_stats_section.dart';
import 'package:productivity_app_frontend/features/profile/presentation/widgets/level_next_chapter_card.dart';
import 'package:productivity_app_frontend/features/profile/presentation/widgets/milestones_grid_section.dart';
import 'package:productivity_app_frontend/features/profile/presentation/widgets/profile_header_card.dart';
import 'package:productivity_app_frontend/features/profile/presentation/widgets/profile_settings_section.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  static const _navClearance = 128.0;

  static const _profile = UserProfile(
    name: 'Alex Morgan',
    email: 'alex@example.com',
    levelLabel: 'Level 6 · Senior Strategist',
    currentXp: 140,
    nextLevelXp: 500,
    nextLevelLabel: 'Level 7 · Master Architect',
    totalXp: 2640,
  );

  static const _milestones = [
    Milestone(
      icon: Icons.local_florist_outlined,
      title: 'First bloom',
      description: 'Write your first reflection',
      unlocked: true,
    ),
    Milestone(
      icon: Icons.track_changes_rounded,
      title: 'Little achiever',
      description: 'Complete your first intention',
      unlocked: true,
    ),
    Milestone(
      icon: Icons.emoji_events_outlined,
      title: 'Master Planner',
      description: 'Reach level 5',
      unlocked: true,
    ),
    Milestone(
      icon: Icons.shield_outlined,
      title: 'Senior Strategist',
      description: 'Unlock at level 6',
      unlocked: true,
    ),
  ];

  bool _mindfulReminders = true;
  bool _reduceMotion = false;

  void _onToggle(ValueChanged<bool> setter, bool value) {
    HapticFeedback.selectionClick();
    setState(() => setter(value));
  }

  void _onAbout() {
  }

  void _onLogout() {
    Navigator.of(context, rootNavigator: true).pushNamedAndRemoveUntil(
      '/login',
          (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: AppColors.background,
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.fromLTRB(
          AppSpacing.screenH,
          AppSpacing.sm,
          AppSpacing.screenH,
          _navClearance,
        ),
        child: Column(
          children: [
            ProfileHeaderCard(
              profile: _profile,
              footer: const LevelNextChapterCard(profile: _profile),
            ),
            const SizedBox(height: AppSpacing.xl),
            const ImpactStatsSection(
              tasksComplete: 4,
              reflections: 4,
              mindfulDays: 3,
            ),
            const SizedBox(height: AppSpacing.xl),
            const MilestonesGridSection(milestones: _milestones),
            const SizedBox(height: AppSpacing.xl),
            ProfileSettingsSection(
              mindfulReminders: _mindfulReminders,
              reduceMotion: _reduceMotion,
              onMindfulRemindersChanged: (v) =>
                  _onToggle((x) => _mindfulReminders = x, v),
              onReduceMotionChanged: (v) =>
                  _onToggle((x) => _reduceMotion = x, v),
              onAboutTap: _onAbout,
              onLogoutTap: _onLogout,
            ),
          ],
        ),
      ),
    );
  }
}