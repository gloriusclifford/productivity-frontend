import 'package:flutter/material.dart';
import 'package:productivity_app_frontend/app/theme/app_theme.dart';
import 'package:productivity_app_frontend/core/widgets/app_top_bar.dart';
import 'package:productivity_app_frontend/features/home/presentation/widgets/custom_bottom_bar.dart';
import 'package:productivity_app_frontend/features/home/presentation/screens/home_screen.dart';
import 'package:productivity_app_frontend/features/make_space/domain/make_space_models.dart';
import 'package:productivity_app_frontend/features/make_space/presentation/show_make_space_dialog.dart';
import 'package:productivity_app_frontend/features/schedule/presentation/screens/schedule_screen.dart';
import 'package:productivity_app_frontend/features/journey/presentation/screens/journey_screen.dart';
import 'package:productivity_app_frontend/features/profile/presentation/screens/profile_screen.dart';

class MainWrapper extends StatefulWidget {
  const MainWrapper({super.key});

  @override
  State<MainWrapper> createState() => _MainWrapperState();
}

class _MainWrapperState extends State<MainWrapper> {
  int _currentIndex = 0;

  final List<Widget> _pages = const [
    HomeScreen(),
    ScheduleScreen(),
    JourneyScreen(),
    ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppTopBar(
        streakLabel: '3 mindful days',
        hasUnreadNotifications: true,
        onNotificationTap: (){},
      ),
      backgroundColor: PlanItColors.background,
      body: IndexedStack(
        index: _currentIndex,
        children: _pages,
      ),
      bottomNavigationBar: CustomBottomNavbar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        onCreateTap: () {
          // Tombol "+" membuka dialog "Make a little space" (chooser).
          showMakeSpaceDialog(context, entry: MakeSpaceEntry.chooser);
        },
      ),
    );
  }
}