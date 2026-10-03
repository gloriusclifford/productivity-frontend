import 'package:flutter/material.dart';

import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_dimens.dart';
import '../../../../app/theme/app_text_styles.dart';
import '../../domain/profile_models.dart';
import 'profile_section_card.dart';

class MilestonesGridSection extends StatelessWidget {
  const MilestonesGridSection({super.key, required this.milestones});

  final List<Milestone> milestones;

  static const _columns = 2;

  @override
  Widget build(BuildContext context) {
    final rows = <Widget>[];
    for (var i = 0; i < milestones.length; i += _columns) {
      final slice = milestones.skip(i).take(_columns).toList();
      rows.add(
        IntrinsicHeight(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              for (var j = 0; j < _columns; j++) ...[
                if (j > 0) const SizedBox(width: AppSpacing.md),
                Expanded(
                  child: j < slice.length
                      ? MilestoneCard(milestone: slice[j])
                      : const SizedBox.shrink(),
                ),
              ],
            ],
          ),
        ),
      );
      if (i + _columns < milestones.length) {
        rows.add(const SizedBox(height: AppSpacing.md));
      }
    }

    return ProfileSectionCard(
      title: 'A growing collection',
      subtitle: 'Milestones along your mindful journey.',
      child: Column(children: rows),
    );
  }
}

class MilestoneCard extends StatelessWidget {
  const MilestoneCard({super.key, required this.milestone});

  final Milestone milestone;

  @override
  Widget build(BuildContext context) {
    final unlocked = milestone.unlocked;
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.md,
        vertical: AppSpacing.xl,
      ),
      decoration: BoxDecoration(
        color: unlocked
            ? AppColors.primarySoft.withAlpha(110)
            : AppColors.background,
        borderRadius: BorderRadius.circular(AppRadius.medium),
        border: Border.all(
          color: unlocked ? AppColors.primaryBorder : AppColors.border,
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            width: 52,
            height: 52,
            decoration: BoxDecoration(
              color: unlocked ? AppColors.primarySoft : AppColors.track,
              shape: BoxShape.circle,
            ),
            child: Icon(
              milestone.icon,
              size: 24,
              color: unlocked ? AppColors.primaryDark : AppColors.mutedText,
            ),
          ),
          const SizedBox(height: AppSpacing.md),
          Text(
            milestone.title,
            textAlign: TextAlign.center,
            style: AppTextStyles.label.copyWith(fontSize: 14),
          ),
          const SizedBox(height: AppSpacing.sm),
          Text(
            milestone.description,
            textAlign: TextAlign.center,
            style: AppTextStyles.micro.copyWith(fontSize: 11.5, height: 1.4),
          ),
          const Spacer(),
          if (unlocked) ...[
            const SizedBox(height: AppSpacing.md),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.check, size: 12, color: AppColors.textPrimary),
                const SizedBox(width: AppSpacing.xs),
                Text('UNLOCKED',
                    style: AppTextStyles.tag.copyWith(fontSize: 9.5)),
              ],
            ),
          ],
        ],
      ),
    );
  }
}