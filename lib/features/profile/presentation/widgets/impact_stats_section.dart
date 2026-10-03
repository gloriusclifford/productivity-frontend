import 'package:flutter/material.dart';

import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_dimens.dart';
import '../../../../app/theme/app_text_styles.dart';
import 'profile_section_card.dart';

class ImpactStatsSection extends StatelessWidget {
  const ImpactStatsSection({
    super.key,
    required this.tasksComplete,
    required this.reflections,
    required this.mindfulDays,
  });

  final int tasksComplete;
  final int reflections;
  final int mindfulDays;

  @override
  Widget build(BuildContext context) {
    return ProfileSectionCard(
      title: 'Your little impact',
      subtitle: 'Progress you can be proud of.',
      child: Row(
        children: [
          Expanded(child: _StatTile(value: tasksComplete, label: 'Tasks complete')),
          const SizedBox(width: AppSpacing.md),
          Expanded(child: _StatTile(value: reflections, label: 'Reflections')),
          const SizedBox(width: AppSpacing.md),
          Expanded(child: _StatTile(value: mindfulDays, label: 'Mindful days')),
        ],
      ),
    );
  }
}

class _StatTile extends StatelessWidget {
  const _StatTile({required this.value, required this.label});

  final int value;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: AppSpacing.xl),
      decoration: BoxDecoration(
        color: AppColors.background,
        borderRadius: BorderRadius.circular(AppRadius.medium),
      ),
      child: Column(
        children: [
          Text('$value',
              style: AppTextStyles.bigNumber.copyWith(fontSize: 26)),
          const SizedBox(height: AppSpacing.sm),
          Text(
            label,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: AppTextStyles.micro.copyWith(fontSize: 11.5),
          ),
        ],
      ),
    );
  }
}