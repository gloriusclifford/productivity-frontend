import 'package:flutter/material.dart';

import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_dimens.dart';
import '../../../../app/theme/app_text_styles.dart';
import '../../domain/profile_models.dart';

class LevelNextChapterCard extends StatelessWidget {
  const LevelNextChapterCard({super.key, required this.profile});

  final UserProfile profile;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Growing into your next chapter',
                style: AppTextStyles.label.copyWith(
                    fontSize: 14, fontWeight: FontWeight.w500)),
            const Icon(Icons.bolt_outlined, size: 20, color: AppColors.xpGold),
          ],
        ),
        const SizedBox(height: AppSpacing.lg),
        _XpBar(progress: profile.xpProgress),
        const SizedBox(height: AppSpacing.md),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('${profile.currentXp} / ${profile.nextLevelXp} XP',
                style: AppTextStyles.micro.copyWith(fontSize: 12)),
            Text(profile.nextLevelLabel,
                style: AppTextStyles.micro.copyWith(fontSize: 12)),
          ],
        ),
        const SizedBox(height: AppSpacing.lg),
        Text.rich(
          TextSpan(
            style: AppTextStyles.caption,
            children: [
              TextSpan(
                text: '${_formatThousands(profile.totalXp)} XP',
                style: AppTextStyles.caption.copyWith(
                  color: AppColors.textPrimary,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const TextSpan(text: ' earned, one little step at a time.'),
            ],
          ),
        ),
      ],
    );
  }

  static String _formatThousands(int n) => n.toString().replaceAllMapped(
    RegExp(r'\B(?=(\d{3})+(?!\d))'),
        (_) => ',',
  );
}

class _XpBar extends StatelessWidget {
  const _XpBar({required this.progress});

  final double progress;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(AppRadius.pill),
      child: SizedBox(
        height: 6,
        child: TweenAnimationBuilder<double>(
          tween: Tween(begin: 0, end: progress),
          duration: const Duration(milliseconds: 700),
          curve: Curves.easeOutCubic,
          builder: (_, value, __) => LinearProgressIndicator(
            value: value,
            minHeight: 6,
            backgroundColor: AppColors.track,
            valueColor: const AlwaysStoppedAnimation(AppColors.primary),
          ),
        ),
      ),
    );
  }
}