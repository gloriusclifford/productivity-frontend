import 'package:flutter/material.dart';

import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_dimens.dart';
import '../../../../app/theme/app_text_styles.dart';
import '../../domain/journey_models.dart';

class MoodHistorySection extends StatelessWidget {
  const MoodHistorySection({
    super.key,
    required this.days,
    required this.moods,
  });
  final List<DateTime> days;
  final Map<DateTime, Mood> moods;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(AppSpacing.xl),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(AppRadius.card),
        border: Border.all(color: AppColors.border),
        boxShadow: AppShadows.soft,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Your mood, over time',
                        style: AppTextStyles.sectionTitle),
                    const SizedBox(height: AppSpacing.sm),
                    Text('Every feeling is part of the journey.',
                        style: AppTextStyles.sectionSubtitle),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: AppSpacing.xs),
                child: Text('Last 7 days', style: AppTextStyles.caption),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.xl + AppSpacing.xs),
          Row(
            children: [
              for (var i = 0; i < days.length; i++) ...[
                if (i > 0) const SizedBox(width: AppSpacing.sm - 2),
                Expanded(
                  child: _DayChip(
                    day: days[i],
                    mood: moods[days[i].dateOnly],
                  ),
                ),
              ],
            ],
          ),
        ],
      ),
    );
  }
}

class _DayChip extends StatelessWidget {
  const _DayChip({required this.day, required this.mood});

  final DateTime day;
  final Mood? mood;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      decoration: BoxDecoration(
        color: AppColors.background,
        borderRadius: BorderRadius.circular(AppRadius.pill),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: 24,
            child: Center(
              child: AnimatedSwitcher(
                duration: const Duration(milliseconds: 250),
                transitionBuilder: (child, anim) =>
                    ScaleTransition(scale: anim, child: child),
                child: mood != null
                    ? Text(mood!.emoji,
                    key: ValueKey(mood),
                    style: const TextStyle(fontSize: 20))
                    : Text('•',
                    key: const ValueKey('empty'),
                    style: AppTextStyles.caption
                        .copyWith(color: AppColors.textPrimary)),
              ),
            ),
          ),
          const SizedBox(height: AppSpacing.md),
          Text(
            day.weekdayShort,
            style: AppTextStyles.micro.copyWith(fontSize: 11),
          ),
        ],
      ),
    );
  }
}