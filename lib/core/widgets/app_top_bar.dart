import 'package:flutter/material.dart';

import 'package:productivity_app_frontend/app/theme/app_colors.dart';
import 'package:productivity_app_frontend/app/theme/app_dimens.dart';
import 'package:productivity_app_frontend/app/theme/app_text_styles.dart';

/// Top Bar independen berisi Brand Mark (Logo PlanIt), Streak Chip, dan Lonceng Notifikasi.
class AppTopBar extends StatelessWidget implements PreferredSizeWidget {
  const AppTopBar({
    super.key,
    required this.streakLabel,
    this.hasUnreadNotifications = false,
    this.onNotificationTap,
  });

  final String streakLabel;
  final bool hasUnreadNotifications;
  final VoidCallback? onNotificationTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.screenH,
        vertical: 12,
      ),
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(color: AppColors.border)),
      ),
      child: SafeArea(
        bottom: false,
        child: Row(
          children: [
            const _BrandMark(),
            const Spacer(),
            _StreakChip(label: streakLabel),
            const SizedBox(width: 14),
            _NotificationBell(
              showDot: hasUnreadNotifications,
              onTap: onNotificationTap,
            ),
          ],
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(64);
}

class _BrandMark extends StatelessWidget {
  const _BrandMark();

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 32,
          height: 32,
          decoration: BoxDecoration(
            color: AppColors.primarySoft,
            borderRadius: BorderRadius.circular(10),
          ),
          child: const Icon(
            Icons.eco_outlined,
            size: 18,
            color: AppColors.primaryDark,
          ),
        ),
        const SizedBox(width: 10),
        Text.rich(
          TextSpan(
            text: 'PlanIt',
            children: [
              TextSpan(
                text: '.',
                style: AppTextStyles.brand.copyWith(color: AppColors.primary),
              ),
            ],
          ),
          style: AppTextStyles.brand,
        ),
      ],
    );
  }
}

class _StreakChip extends StatelessWidget {
  const _StreakChip({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
      decoration: BoxDecoration(
        color: AppColors.streakBackground,
        borderRadius: BorderRadius.circular(AppRadius.pill),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(
            Icons.local_fire_department_outlined,
            size: 16,
            color: AppColors.flame,
          ),
          const SizedBox(width: 6),
          Text(
            label,
            style: AppTextStyles.label.copyWith(color: AppColors.streakText),
          ),
        ],
      ),
    );
  }
}

class _NotificationBell extends StatelessWidget {
  const _NotificationBell({required this.showDot, this.onTap});

  final bool showDot;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return InkResponse(
      onTap: onTap,
      radius: 22,
      child: Padding(
        padding: const EdgeInsets.all(4),
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            const Icon(
              Icons.notifications_none_rounded,
              size: 24,
              color: AppColors.textPrimary,
            ),
            if (showDot)
              Positioned(
                right: 2,
                top: 1,
                child: Container(
                  width: 8,
                  height: 8,
                  decoration: BoxDecoration(
                    color: AppColors.notificationDot,
                    shape: BoxShape.circle,
                    border: Border.all(color: AppColors.background, width: 1.5),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}