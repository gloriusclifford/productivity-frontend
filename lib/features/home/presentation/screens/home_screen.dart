import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:productivity_app_frontend/app/theme/app_colors.dart';
import 'package:productivity_app_frontend/app/theme/app_dimens.dart';
import 'package:productivity_app_frontend/core/utils/date_x.dart';
import 'package:productivity_app_frontend/features/home/presentation/widgets/calendar_picker_section.dart';
import 'package:productivity_app_frontend/features/home/presentation/widgets/daily_rhythm_section.dart';
import 'package:productivity_app_frontend/features/home/presentation/widgets/header_section.dart';
import 'package:productivity_app_frontend/features/home/presentation/widgets/little_wins_card.dart';
import 'package:productivity_app_frontend/features/home/presentation/widgets/moment_grid_section.dart';
import 'package:productivity_app_frontend/features/home/presentation/widgets/mood_selector_card.dart';
import 'package:productivity_app_frontend/features/home/presentation/widgets/my_journal_card.dart';
import 'package:productivity_app_frontend/features/make_space/domain/make_space_models.dart';
import 'package:productivity_app_frontend/features/make_space/presentation/show_make_space_dialog.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late DateTime _selectedDate;
  late DateTime _weekStart;
  int? _selectedMood;

  @override
  void initState() {
    super.initState();
    _selectedDate = DateTime.now().dateOnly;
    _weekStart = _selectedDate.startOfWeek;
  }

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

  Future<void> _openMakeSpace({
    required MakeSpaceEntry entry,
    MakeSpaceTab initialTab = MakeSpaceTab.intention,
  }) {
    return showMakeSpaceDialog(
      context,
      entry: entry,
      initialTab: initialTab,
      date: _selectedDate,
    );
  }

  @override
  Widget build(BuildContext context) {
    // Bottom bar melayang di atas konten, jadi beri ruang di akhir scroll.
    final bottomSpace = MediaQuery.paddingOf(context).bottom + 120;

    return Scaffold(
      backgroundColor: AppColors.background,
      extendBody: true,
      body: SafeArea(
        bottom: false,
        child: SingleChildScrollView(
          padding: EdgeInsets.only(bottom: bottomSpace),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              HeaderSection(
                userName: 'Alex',
                streakLabel: '3 mindful days',
                level: 6,
                rankTitle: 'Senior Strategist',
                currentXp: 10,
                targetXp: 500,
                hasUnreadNotifications: true,
                onNotificationTap: () {},
                onSearchTap: () {},
                onAvatarTap: () {},
                onLevelTap: () {},
              ),
              Padding(
                padding:
                const EdgeInsets.symmetric(horizontal: AppSpacing.screenH),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const SizedBox(height: 36),
                    CalendarPickerSection(
                      weekStart: _weekStart,
                      selectedDate: _selectedDate,
                      onDateSelected: _selectDate,
                      onPreviousWeek: () => _shiftWeek(-1),
                      onNextWeek: () => _shiftWeek(1),
                      onTodayTap: _goToToday,
                    ),
                    const SizedBox(height: 28),
                    MyJournalCard(
                      label: 'Your daily reflection',
                      title: "Let's start your day.",
                      description:
                      "A clear mind begins with a little pause. What's on your mind today?",
                      buttonLabel: 'Open my journal',
                      onButtonTap: () => _openMakeSpace(
                        entry: MakeSpaceEntry.chooser,
                        initialTab: MakeSpaceTab.reflection,
                      ),
                    ),
                    const SizedBox(height: 20),
                    // TODO: completed/total dari agenda pada _selectedDate.
                    const LittleWinsCard(
                      completed: 0,
                      total: 0,
                      xpEarned: 0,
                    ),
                    const SizedBox(height: 36),
                    MomentGridSection(
                      title: 'A moment for yourself',
                      subtitle: 'Check in. Breathe out. Begin again.',
                      items: [
                        MomentCardData(
                          icon: Icons.coffee_outlined,
                          title: 'Pause & reflect',
                          description: 'A little gratitude goes a long way.',
                          tag: 'Mindful moment · 3 min',
                          palette: MomentPalette.sunshine,
                          onTap: () => _openMakeSpace(
                            entry: MakeSpaceEntry.pauseAndReflect,
                          ),
                        ),
                        MomentCardData(
                          icon: Icons.eco_outlined,
                          title: 'Set intentions',
                          description: 'Give your day a gentle direction.',
                          tag: 'Daily practice · 2 min',
                          palette: MomentPalette.sage,
                          onTap: () => _openMakeSpace(
                            entry: MakeSpaceEntry.setIntentions,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    MoodSelectorCard(
                      selectedValue: _selectedMood,
                      onSelected: (option) {
                        setState(() => _selectedMood = option.value);
                        // TODO: panggil POST /moods dengan mood_score = option.value.
                      },
                    ),
                    const SizedBox(height: 32),
                    DailyRhythmSection(
                      title: 'Your daily rhythm',
                      subtitle:
                      '${DateFormat('EEE').format(_selectedDate)}, one small step at a time.',
                      // TODO: isi items dari agenda pada _selectedDate.
                      items: const [],
                      onViewAll: () {},
                      onAddTap: () => _openMakeSpace(
                        entry: MakeSpaceEntry.chooser,
                        initialTab: MakeSpaceTab.intention,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}