import 'package:flutter/material.dart';

import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_dimens.dart';
import '../../../../app/theme/app_text_styles.dart';
import '../../domain/journey_models.dart';

class MoodCheckInSection extends StatelessWidget {
  const MoodCheckInSection({
    super.key,
    required this.selected,
    required this.onSelected,
  });

  final Mood? selected;
  final ValueChanged<Mood> onSelected;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(
        AppSpacing.xl,
        AppSpacing.xl + AppSpacing.xs,
        AppSpacing.xl,
        AppSpacing.xl,
      ),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(AppRadius.card),
        border: Border.all(color: AppColors.border),
        boxShadow: AppShadows.soft,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppSpacing.xs),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('A gentle check-in', style: AppTextStyles.sectionTitle),
                const SizedBox(height: AppSpacing.xs),
                Text('How does today feel?',
                    style: AppTextStyles.sectionSubtitle),
              ],
            ),
          ),
          const SizedBox(height: AppSpacing.xl),
          Row(
            children: [
              for (final mood in Mood.values)
                Expanded(
                  child: _MoodOption(
                    mood: mood,
                    isSelected: mood == selected,
                    onTap: () => onSelected(mood),
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }
}

class _MoodOption extends StatelessWidget {
  const _MoodOption({
    required this.mood,
    required this.isSelected,
    required this.onTap,
  });

  final Mood mood;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 220),
        curve: Curves.easeOutCubic,
        padding: const EdgeInsets.symmetric(vertical: AppSpacing.md),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.primarySoft : Colors.transparent,
          borderRadius: BorderRadius.circular(AppRadius.medium),
          border: Border.all(
            color: isSelected ? AppColors.primaryBorder : Colors.transparent,
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            AnimatedScale(
              duration: const Duration(milliseconds: 220),
              scale: isSelected ? 1.08 : 1,
              child: Text(mood.emoji, style: const TextStyle(fontSize: 28)),
            ),
            const SizedBox(height: AppSpacing.md),
            Text(
              mood.label,
              maxLines: 1,
              style: AppTextStyles.micro.copyWith(
                fontSize: 10,
                color: isSelected
                    ? AppColors.onPrimary
                    : AppColors.textPrimary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}