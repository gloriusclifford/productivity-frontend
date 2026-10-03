import 'package:flutter/material.dart';

import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_dimens.dart';
import '../../../../app/theme/app_text_styles.dart';
import 'profile_section_card.dart';

class ProfileSettingsSection extends StatelessWidget {
  const ProfileSettingsSection({
    super.key,
    required this.mindfulReminders,
    required this.reduceMotion,
    required this.onMindfulRemindersChanged,
    required this.onReduceMotionChanged,
    required this.onAboutTap,
    required this.onLogoutTap,
  });

  final bool mindfulReminders;
  final bool reduceMotion;
  final ValueChanged<bool> onMindfulRemindersChanged;
  final ValueChanged<bool> onReduceMotionChanged;
  final VoidCallback onAboutTap;
  final VoidCallback onLogoutTap;

  @override
  Widget build(BuildContext context) {
    return ProfileSectionCard(
      title: 'Make yourself at home',
      subtitle: 'Your space, your pace.',
      padding: const EdgeInsets.fromLTRB(
        AppSpacing.xl + AppSpacing.xs,
        AppSpacing.xl + AppSpacing.xs,
        AppSpacing.xl + AppSpacing.xs,
        AppSpacing.sm,
      ),
      child: Column(
        children: [
          _SettingRow(
            icon: Icons.notifications_none_rounded,
            title: 'Mindful reminders',
            subtitle: 'In-app encouragement and reminders',
            trailing: _GreenSwitch(
              value: mindfulReminders,
              onChanged: onMindfulRemindersChanged,
            ),
            onTap: () => onMindfulRemindersChanged(!mindfulReminders),
          ),
          const _RowDivider(),
          _SettingRow(
            icon: Icons.tune_rounded,
            title: 'Reduce motion',
            subtitle: 'A quieter, calmer experience',
            trailing: _GreenSwitch(
              value: reduceMotion,
              onChanged: onReduceMotionChanged,
            ),
            onTap: () => onReduceMotionChanged(!reduceMotion),
          ),
          const _RowDivider(),
          _SettingRow(
            icon: Icons.help_outline_rounded,
            title: 'About your mindful space',
            trailing: const Icon(Icons.chevron_right_rounded,
                size: 20, color: AppColors.textSecondary),
            onTap: onAboutTap,
          ),
          const _RowDivider(),
          _SettingRow(
            icon: Icons.logout_rounded,
            title: 'Logout',
            color: AppColors.flame,
            onTap: onLogoutTap,
          ),
        ],
      ),
    );
  }
}

class _SettingRow extends StatelessWidget {
  const _SettingRow({
    required this.icon,
    required this.title,
    this.subtitle,
    this.trailing,
    this.color,
    this.onTap,
  });

  final IconData icon;
  final String title;
  final String? subtitle;
  final Widget? trailing;
  final Color? color;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final tint = color ?? AppColors.textPrimary;
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(AppRadius.medium),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: AppSpacing.lg),
        child: Row(
          children: [
            Icon(icon, size: 20, color: color ?? AppColors.textSecondary),
            const SizedBox(width: AppSpacing.lg),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: AppTextStyles.label.copyWith(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: tint,
                    ),
                  ),
                  if (subtitle != null) ...[
                    const SizedBox(height: 2),
                    Text(subtitle!,
                        style: AppTextStyles.micro.copyWith(fontSize: 12)),
                  ],
                ],
              ),
            ),
            if (trailing != null) trailing!,
          ],
        ),
      ),
    );
  }
}

class _GreenSwitch extends StatelessWidget {
  const _GreenSwitch({required this.value, required this.onChanged});

  final bool value;
  final ValueChanged<bool> onChanged;

  @override
  Widget build(BuildContext context) {
    return Transform.scale(
      scale: 0.9,
      child: Switch(
        value: value,
        onChanged: onChanged,
        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        activeThumbColor: Colors.white,
        activeTrackColor: AppColors.primary,
        inactiveThumbColor: Colors.white,
        inactiveTrackColor: AppColors.track,
        trackOutlineColor: const WidgetStatePropertyAll(Colors.transparent),
      ),
    );
  }
}

class _RowDivider extends StatelessWidget {
  const _RowDivider();

  @override
  Widget build(BuildContext context) =>
      const Divider(height: 1, thickness: 1, color: AppColors.border);
}