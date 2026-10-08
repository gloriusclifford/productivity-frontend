import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:productivity_app_frontend/app/theme/app_colors.dart';
import 'package:productivity_app_frontend/app/theme/app_dimens.dart';
import 'package:productivity_app_frontend/app/theme/app_text_styles.dart';
import 'package:productivity_app_frontend/core/utils/date_x.dart';
import 'package:productivity_app_frontend/features/make_space/domain/make_space_models.dart';
import 'package:productivity_app_frontend/features/make_space/presentation/show_make_space_dialog.dart';
import 'package:productivity_app_frontend/features/schedule/domain/intention.dart';
import 'package:productivity_app_frontend/features/schedule/presentation/widgets/add_intention_button.dart';
import 'package:productivity_app_frontend/features/schedule/presentation/widgets/intention_card_tile.dart';
import 'package:productivity_app_frontend/features/schedule/presentation/widgets/intention_header_section.dart';
import 'package:productivity_app_frontend/features/schedule/presentation/widgets/schedule_calendar_picker.dart';
import 'package:productivity_app_frontend/features/schedule/presentation/widgets/show_up_card.dart';
import 'package:productivity_app_frontend/features/schedule/presentation/widgets/xp_floating_toast.dart';

/// Layar Schedule. Hanya berisi body; bottom nav dipasang oleh parent/shell
/// (atau tambahkan `bottomNavigationBar:` pada Scaffold di bawah).
class ScheduleScreen extends StatefulWidget {
  const ScheduleScreen({
    super.key,
    this.onXpChanged,
    this.onNewIntentionTap,
  });

  /// Dipanggil setiap total XP yang diperoleh berubah (nilai = total XP).
  final ValueChanged<int>? onXpChanged;

  /// Dipanggil saat tombol "+ New intention" ditekan.
  final VoidCallback? onNewIntentionTap;

  @override
  State<ScheduleScreen> createState() => _ScheduleScreenState();
}

class _ScheduleScreenState extends State<ScheduleScreen> {
  /// Ruang di akhir scroll agar konten tidak tertutup bottom nav melayang.
  static const double _bottomNavClearance = 136;

  final _timeFormat = DateFormat('HH:mm');

  late DateTime _selectedDate;
  late DateTime _weekStart;
  late List<Intention> _intentions;
  late int _earnedXp;
  IntentionFilter _filter = IntentionFilter.all;

  @override
  void initState() {
    super.initState();
    _selectedDate = DateTime.now().dateOnly;
    _weekStart = _selectedDate.startOfWeek;
    // TODO: ganti data contoh ini dengan data dari repository/API (GET /agendas).
    _intentions = _sampleIntentions(_selectedDate);
    _earnedXp = _intentions
        .where((i) => i.isCompleted)
        .fold(0, (sum, i) => sum + i.xp);
  }

  // ---- State handlers -------------------------------------------------------

  void _selectDate(DateTime date) =>
      setState(() => _selectedDate = date.dateOnly);

  void _shiftWeek(int weeks) => setState(() {
    _weekStart = _weekStart.addDays(7 * weeks);
    _selectedDate = _selectedDate.addDays(7 * weeks);
  });

  void _goToToday() => setState(() {
    _selectedDate = DateTime.now().dateOnly;
    _weekStart = _selectedDate.startOfWeek;
  });

  void _toggleIntention(Intention target) {
    final isNowCompleted = !target.isCompleted;

    setState(() {
      _intentions = [
        for (final item in _intentions)
          if (item.id == target.id)
            item.copyWith(isCompleted: isNowCompleted)
          else
            item,
      ];
      _earnedXp += isNowCompleted ? target.xp : -target.xp;
    });

    widget.onXpChanged?.call(_earnedXp);

    if (isNowCompleted) {
      XPFloatingToast.show(
        context,
        message: '+${target.xp} XP earned. A little step, a little growth!',
      );
    }
  }

  /// Opens the "Make a little space" dialog on the intention tab and appends
  /// the created intention to the local list.
  Future<void> _newIntention() async {
    final result = await showMakeSpaceDialog(
      context,
      entry: MakeSpaceEntry.chooser,
      initialTab: MakeSpaceTab.intention,
      date: _selectedDate,
    );

    if (result case final IntentionCreated intention) {
      setState(() {
        _intentions = [
          ..._intentions,
          Intention(
            id: 'intention-${DateTime.now().microsecondsSinceEpoch}',
            title: intention.title,
            category: intention.category.toIntentionCategory(),
            scheduledAt: intention.scheduledAt,
            xp: intention.xp,
          ),
        ];
      });
    }
  }

  // ---- Derived data ---------------------------------------------------------

  List<Intention> get _intentionsOfSelectedDay => _intentions
      .where((i) => i.scheduledAt.isSameDay(_selectedDate))
      .toList()
    ..sort((a, b) => a.scheduledAt.compareTo(b.scheduledAt));

  String _progressMessage({required int done, required int total}) {
    if (total == 0) return 'A clear day. Make room for an intention.';
    if (done == 0) return 'Nothing checked off yet. One small step is enough.';
    if (done == total) return 'Every intention complete. You showed up!';
    final noun = done == 1 ? 'intention' : 'intentions';
    return "$done $noun complete. That's progress.";
  }

  String _emptyMessage({required bool dayHasItems}) {
    if (!dayHasItems) return 'A clear day. Make room for an intention.';
    return switch (_filter) {
      IntentionFilter.todo => 'Everything is done. Lovely work.',
      IntentionFilter.completed =>
      'Nothing completed yet. One small step is enough.',
      IntentionFilter.all => '',
    };
  }

  // ---- Build ----------------------------------------------------------------

  @override
  Widget build(BuildContext context) {
    final dayItems = _intentionsOfSelectedDay;
    final visibleItems = dayItems.where(_filter.accepts).toList();
    final doneCount = dayItems.where((i) => i.isCompleted).length;
    final totalCount = dayItems.length;
    final progress = totalCount == 0 ? 0.0 : doneCount / totalCount;
    final bottomSpace =
        MediaQuery.paddingOf(context).bottom + _bottomNavClearance;

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        bottom: false,
        child: SingleChildScrollView(
          padding: EdgeInsets.fromLTRB(
            AppSpacing.screenH,
            AppSpacing.lg,
            AppSpacing.screenH,
            bottomSpace,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              ScheduleCalendarPicker(
                weekStart: _weekStart,
                selectedDate: _selectedDate,
                onDateSelected: _selectDate,
                onPreviousWeek: () => _shiftWeek(-1),
                onNextWeek: () => _shiftWeek(1),
                onTodayTap: _goToToday,
              ),
              const SizedBox(height: AppSpacing.section),
              IntentionHeaderSection(
                completedCount: doneCount,
                totalCount: totalCount,
                selectedFilter: _filter,
                onFilterChanged: (filter) => setState(() => _filter = filter),
              ),
              const SizedBox(height: 22),
              if (visibleItems.isEmpty)
                _EmptyIntentions(
                  message: _emptyMessage(dayHasItems: dayItems.isNotEmpty),
                )
              else
                for (var i = 0; i < visibleItems.length; i++) ...[
                  if (i > 0) const SizedBox(height: AppSpacing.lg),
                  IntentionCardTile(
                    key: ValueKey(visibleItems[i].id),
                    title: visibleItems[i].title,
                    category: visibleItems[i].category,
                    timeLabel: _timeFormat.format(visibleItems[i].scheduledAt),
                    xp: visibleItems[i].xp,
                    isCompleted: visibleItems[i].isCompleted,
                    onToggle: () => _toggleIntention(visibleItems[i]),
                  ),
                ],
              const SizedBox(height: 28),
              Align(
                alignment: Alignment.centerLeft,
                child: AddIntentionButton(
                  onPressed: widget.onNewIntentionTap ?? _newIntention,
                ),
              ),
              const SizedBox(height: 24),
              ShowUpCard(
                progress: progress,
                message: _progressMessage(done: doneCount, total: totalCount),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _EmptyIntentions extends StatelessWidget {
  const _EmptyIntentions({required this.message});

  final String message;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 28),
      child: Text(
        message,
        textAlign: TextAlign.center,
        style: AppTextStyles.caption
            .copyWith(fontSize: 12, color: AppColors.mutedText),
      ),
    );
  }
}

List<Intention> _sampleIntentions(DateTime day) {
  DateTime at(int hour, int minute) =>
      DateTime(day.year, day.month, day.day, hour, minute);

  return [
    Intention(
      id: 'intention-1',
      title: 'A little morning movement',
      category: IntentionCategory.wellbeing,
      scheduledAt: at(8, 0),
      xp: 30,
      isCompleted: true,
    ),
    Intention(
      id: 'intention-2',
      title: 'Read 10 pages of a book',
      category: IntentionCategory.personal,
      scheduledAt: at(10, 0),
      xp: 50,
    ),
    Intention(
      id: 'intention-3',
      title: 'Make space for deep work',
      category: IntentionCategory.work,
      scheduledAt: at(11, 30),
      xp: 80,
    ),
    Intention(
      id: 'intention-4',
      title: 'An evening walk, unplugged',
      category: IntentionCategory.wellbeing,
      scheduledAt: at(17, 0),
      xp: 40,
    ),
  ];
}

extension on SpaceCategory {
  IntentionCategory toIntentionCategory() => switch (this) {
        SpaceCategory.personal => IntentionCategory.personal,
        SpaceCategory.work => IntentionCategory.work,
        SpaceCategory.wellbeing => IntentionCategory.wellbeing,
      };
}