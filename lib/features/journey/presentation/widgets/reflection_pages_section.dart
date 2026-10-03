import 'package:flutter/material.dart';

import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_dimens.dart';
import '../../../../app/theme/app_text_styles.dart';
import '../../domain/journey_models.dart';

class ReflectionPagesSection extends StatelessWidget {
  const ReflectionPagesSection({
    super.key,
    required this.reflections,
    required this.onNewReflection,
    this.onReflectionTap,
  });

  final List<Reflection> reflections;
  final VoidCallback onNewReflection;
  final ValueChanged<Reflection>? onReflectionTap;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Pages of your journey',
                      style: AppTextStyles.sectionTitle
                          .copyWith(fontSize: 22)),
                  const SizedBox(height: AppSpacing.sm),
                  Text('Little moments worth remembering.',
                      style: AppTextStyles.sectionSubtitle),
                ],
              ),
            ),
            _NewReflectionButton(onTap: onNewReflection),
          ],
        ),
        const SizedBox(height: AppSpacing.xl),
        for (var i = 0; i < reflections.length; i++) ...[
          if (i > 0) const SizedBox(height: AppSpacing.lg),
          ReflectionCardTile(
            reflection: reflections[i],
            onTap: onReflectionTap == null
                ? null
                : () => onReflectionTap!(reflections[i]),
          ),
        ],
      ],
    );
  }
}

class _NewReflectionButton extends StatelessWidget {
  const _NewReflectionButton({required this.onTap});

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(AppRadius.pill),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: AppSpacing.xs),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.add, size: 16, color: AppColors.textPrimary),
            const SizedBox(width: AppSpacing.sm),
            Text('New reflection', style: AppTextStyles.label),
          ],
        ),
      ),
    );
  }
}

class ReflectionCardTile extends StatelessWidget {
  const ReflectionCardTile({super.key, required this.reflection, this.onTap});

  final Reflection reflection;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.surface,
      borderRadius: BorderRadius.circular(AppRadius.card),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(AppRadius.card),
        child: Ink(
          width: double.infinity,
          padding: const EdgeInsets.all(AppSpacing.xl),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(AppRadius.card),
            border: Border.all(color: AppColors.border),
            boxShadow: AppShadows.soft,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _DateBadge(label: reflection.date.shortDate),
                  Text(reflection.mood.emoji,
                      style: const TextStyle(fontSize: 22)),
                ],
              ),
              const SizedBox(height: AppSpacing.lg),
              Text(reflection.title, style: AppTextStyles.cardTitle),
              const SizedBox(height: AppSpacing.md),
              Text(
                reflection.content,
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
                style: AppTextStyles.body
                    .copyWith(color: AppColors.textSecondary),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _DateBadge extends StatelessWidget {
  const _DateBadge({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.md,
        vertical: AppSpacing.xs + 2,
      ),
      decoration: BoxDecoration(
        color: AppColors.streakBackground,
        borderRadius: BorderRadius.circular(AppRadius.pill),
      ),
      child: Text(label, style: AppTextStyles.micro.copyWith(fontSize: 12)),
    );
  }
}