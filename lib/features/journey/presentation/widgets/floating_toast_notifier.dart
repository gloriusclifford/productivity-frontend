import 'package:flutter/material.dart';

import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_dimens.dart';
import '../../../../app/theme/app_text_styles.dart';

class FloatingToastNotifier extends StatelessWidget {
  const FloatingToastNotifier({
    super.key,
    required this.visible,
    required this.message,
    required this.onClose,
    this.bottomOffset = 112,
  });

  final bool visible;
  final String message;
  final VoidCallback onClose;
  final double bottomOffset;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: AppSpacing.screenH,
      right: AppSpacing.screenH,
      bottom: bottomOffset,
      child: IgnorePointer(
        ignoring: !visible,
        child: AnimatedSlide(
          duration: const Duration(milliseconds: 280),
          curve: Curves.easeOutCubic,
          offset: visible ? Offset.zero : const Offset(0, 0.4),
          child: AnimatedOpacity(
            duration: const Duration(milliseconds: 220),
            opacity: visible ? 1 : 0,
            child: Center(child: _ToastBody(message: message, onClose: onClose)),
          ),
        ),
      ),
    );
  }
}

class _ToastBody extends StatelessWidget {
  const _ToastBody({required this.message, required this.onClose});

  final String message;
  final VoidCallback onClose;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(
        AppSpacing.md,
        AppSpacing.sm + 2,
        AppSpacing.md,
        AppSpacing.sm + 2,
      ),
      decoration: BoxDecoration(
        color: AppColors.primarySoft,
        borderRadius: BorderRadius.circular(AppRadius.medium),
        border: Border.all(color: AppColors.primaryBorder),
        boxShadow: AppShadows.soft,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 28,
            height: 28,
            decoration: const BoxDecoration(
              color: AppColors.iconBubble,
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.eco_outlined,
                size: 16, color: AppColors.primaryDark),
          ),
          const SizedBox(width: AppSpacing.md),
          Flexible(
            child: Text(
              message,
              style: AppTextStyles.caption.copyWith(
                color: AppColors.onPrimary,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          const SizedBox(width: AppSpacing.md),
          GestureDetector(
            onTap: onClose,
            behavior: HitTestBehavior.opaque,
            child: const Padding(
              padding: EdgeInsets.all(AppSpacing.xs),
              child: Icon(Icons.close, size: 16, color: AppColors.onPrimary),
            ),
          ),
        ],
      ),
    );
  }
}