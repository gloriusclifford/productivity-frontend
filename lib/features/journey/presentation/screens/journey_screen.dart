import 'dart:async';

import 'package:flutter/material.dart';

import 'package:productivity_app_frontend/app/theme/app_colors.dart';
import 'package:productivity_app_frontend/app/theme/app_dimens.dart';
import 'package:productivity_app_frontend/features/journey/domain/journey_models.dart';
import 'package:productivity_app_frontend/features/make_space/domain/make_space_models.dart';
import 'package:productivity_app_frontend/features/make_space/presentation/show_make_space_dialog.dart';
import 'package:productivity_app_frontend/features/journey/presentation/widgets/floating_toast_notifier.dart';
import 'package:productivity_app_frontend/features/journey/presentation/widgets/monthly_growth_card.dart';
import 'package:productivity_app_frontend/features/journey/presentation/widgets/mood_check_in_section.dart';
import 'package:productivity_app_frontend/features/journey/presentation/widgets/mood_history_section.dart';
import 'package:productivity_app_frontend/features/journey/presentation/widgets/reflection_pages_section.dart';

class JourneyScreen extends StatefulWidget {
  const JourneyScreen({super.key});

  @override
  State<JourneyScreen> createState() => _JourneyScreenState();
}

class _JourneyScreenState extends State<JourneyScreen> {
  static const _toastDuration = Duration(seconds: 3);
  static const _navClearance = 128.0;

  late final DateTime _today = DateTime.now().dateOnly;
  late final Map<DateTime, Mood> _moods = {
    _today.subtract(const Duration(days: 2)): Mood.okay,
  };
  List<Reflection> _reflections = [
    Reflection(
      date: DateTime(2026, 10, 8),
      mood: Mood.low,
      title: 'Pause & reflect',
      content: 'adada',
    ),
    Reflection(
      date: DateTime(2026, 10, 8),
      mood: Mood.okay,
      title: 'Set my intentions',
      content: 'adaada',
    ),
    Reflection(
      date: DateTime(2026, 9, 29),
      mood: Mood.wonderful,
      title: 'Finding joy in the little things',
      content: 'A slow morning, a warm coffee, and a conversation with a '
          'friend. Today reminded me that progress doesn\'t always need to '
          'be loud.',
    ),
    Reflection(
      date: DateTime(2026, 9, 28),
      mood: Mood.good,
      title: 'One step at a time',
      content: 'I made room to focus on what really matters. Proud of '
          'showing up for myself, even when the day felt busy.',
    ),
  ];

  Timer? _toastTimer;
  bool _toastVisible = false;

  Mood? get _todayMood => _moods[_today];

  List<DateTime> get _lastSevenDays => List.generate(
    7,
        (i) => _today.subtract(Duration(days: 6 - i)),
  );

  void _onMoodSelected(Mood mood) {
    setState(() {
      _moods[_today] = mood;
      _toastVisible = true;
    });
    _toastTimer?.cancel();
    _toastTimer = Timer(_toastDuration, _hideToast);
  }

  void _hideToast() {
    _toastTimer?.cancel();
    if (mounted) setState(() => _toastVisible = false);
  }

  /// Opens the "Make a little space" dialog on the reflection tab and appends
  /// the saved reflection to the local list.
  Future<void> _newReflection() async {
    final result = await showMakeSpaceDialog(
      context,
      entry: MakeSpaceEntry.chooser,
      initialTab: MakeSpaceTab.reflection,
    );

    if (result case final ReflectionSaved saved) {
      setState(() {
        _reflections = [
          Reflection(
            date: DateTime.now().dateOnly,
            mood: saved.mood.toMood(),
            title: saved.variant.title,
            content: saved.thoughts,
          ),
          ..._reflections,
        ];
      });
    }
  }

  @override
  void dispose() {
    _toastTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: AppColors.background,
      child: Stack(
        children: [
          SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(
              AppSpacing.screenH,
              AppSpacing.sm,
              AppSpacing.screenH,
              _navClearance,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                MoodCheckInSection(
                  selected: _todayMood,
                  onSelected: _onMoodSelected,
                ),
                const SizedBox(height: AppSpacing.xl),
                MonthlyGrowthCard(
                  reflections: _reflections.length,
                  moodCheckIns: _moods.length,
                  littleWins: 4,
                ),
                const SizedBox(height: AppSpacing.xl),
                MoodHistorySection(days: _lastSevenDays, moods: _moods),
                const SizedBox(height: AppSpacing.section),
                ReflectionPagesSection(
                  reflections: _reflections,
                  onNewReflection: _newReflection,
                ),
              ],
            ),
          ),
          FloatingToastNotifier(
            visible: _toastVisible,
            message: "Today's mood has been saved.",
            onClose: _hideToast,
          ),
        ],
      ),
    );
  }
}

extension on MoodLevel {
  Mood toMood() => switch (this) {
        MoodLevel.low => Mood.low,
        MoodLevel.off => Mood.off,
        MoodLevel.okay => Mood.okay,
        MoodLevel.good => Mood.good,
        MoodLevel.wonderful => Mood.wonderful,
      };
}