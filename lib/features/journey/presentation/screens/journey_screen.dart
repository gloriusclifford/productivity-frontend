import 'package:flutter/material.dart';
import 'package:productivity_app_frontend/app/theme/app_theme.dart';

class JourneyScreen extends StatelessWidget {
  const JourneyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: PlanItColors.background,
      body: SafeArea(
        child: Center(
          child: Text(
            'Journey Screen 📖',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
        ),
      ),
    );
  }
}