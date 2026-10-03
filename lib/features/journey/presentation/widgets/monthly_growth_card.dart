import 'package:flutter/material.dart';

import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_dimens.dart';
import '../../../../app/theme/app_text_styles.dart';

class MonthlyGrowthCard extends StatelessWidget {
  const MonthlyGrowthCard({
    super.key,
    required this.reflections,
    required this.moodCheckIns,
    required this.littleWins,
  });

  final int reflections;
  final int moodCheckIns;
  final int littleWins;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(AppSpacing.xl + AppSpacing.xs),
      decoration: BoxDecoration(
        color: AppColors.primarySoft,
        borderRadius: BorderRadius.circular(AppRadius.card),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("This month's growth", style: AppTextStyles.cardTitle),
              const Icon(
                Icons.eco_outlined,
                size: 20,
                color: AppColors.primaryDark,
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.xl),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _Stat(value: reflections, label: 'Reflections'),
              _Stat(value: moodCheckIns, label: 'Mood check-ins'),
              _Stat(value: littleWins, label: 'Little wins'),
            ],
          ),
        ],
      ),
    );
  }
}

class _Stat extends StatelessWidget {
  const _Stat({required this.value, required this.label});

  final int value;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '$value',
            style: AppTextStyles.bigNumber.copyWith(fontSize: 30),
          ),
          const SizedBox(height: AppSpacing.sm),
          Text(
            label,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: AppTextStyles.micro.copyWith(
              fontSize: 12,
              color: AppColors.onPrimarySoft,
            ),
          ),
        ],
      ),
    );
  }
}