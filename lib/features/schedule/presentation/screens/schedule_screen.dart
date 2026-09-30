import 'package:flutter/material.dart';
import 'package:productivity_app_frontend/app/theme/app_theme.dart';

class ScheduleScreen extends StatelessWidget {
  const ScheduleScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: PlanItColors.background,
      body: SafeArea(
        child: Center(
          child: Text(
            'Schedules Screen 📅',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}