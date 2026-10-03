import 'package:flutter/material.dart';

class UserProfile {
  const UserProfile({
    required this.name,
    required this.email,
    required this.levelLabel,
    required this.currentXp,
    required this.nextLevelXp,
    required this.nextLevelLabel,
    required this.totalXp,
  });

  final String name;
  final String email;
  final String levelLabel;
  final int currentXp;
  final int nextLevelXp;
  final String nextLevelLabel;
  final int totalXp;

  double get xpProgress => (currentXp / nextLevelXp).clamp(0.0, 1.0);
}

class Milestone {
  const Milestone({
    required this.icon,
    required this.title,
    required this.description,
    required this.unlocked,
  });

  final IconData icon;
  final String title;
  final String description;
  final bool unlocked;
}