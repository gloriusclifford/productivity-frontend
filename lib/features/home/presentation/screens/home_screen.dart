import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:productivity_app_frontend/features/home/presentation/widgets/custom_bottom_bar.dart';
import '../widgets/home_header.dart';
import '../widgets/date_strip_selector.dart';
import '../widgets/section_header.dart';
import '../widgets/my_journal_card.dart';
import '../widgets/quick_journal_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 3;

  final List<Map<String, String>> _dates = [
    {'day': 'Mon', 'date': '7'},
    {'day': 'Tue', 'date': '8'},
    {'day': 'Wed', 'date': '9'},
    {'day': 'Thu', 'date': '10'},
    {'day': 'Fri', 'date': '11'},
    {'day': 'Sat', 'date': '12'},
    {'day': 'Sun', 'date': '13'},
  ];

  @override
  Widget build(BuildContext context){
    return Scaffold(
      backgroundColor: const Color(0xFFF6F5F2),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //1
              const HomeHeader(name: "Admin", avatarUrl: 'https://i.pravatar.cc/150?img=47'),
              const SizedBox(height: 20),
              //2
              DateStripSelector(
                  dates: _dates,
                  selectedIndex: _selectedIndex,
                  onDateSelected: (index){
                    setState(() {
                      _selectedIndex = index;
                    });
                  },
              ),
              const SizedBox(height: 20),
              //3
              SectionHeader(
                title: 'My Schedules',
                onSeeAllTap: (){}),
              const SizedBox(height: 12),
              SizedBox(
                height: 210,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  children: const [
                    MyJournalCard(
                      title: "Let's start your day",
                      subtitle: 'Begin with a mindful morning reflections.',
                      backgroundColor: Color(0xFFF9DC85),
                    ),
                    SideJournalCard(
                        title: 'Evening',
                        backgroundColor: Color(0xFFE5DECE)
                    ),
                  ],
                ),
              ),
              const SizedBox(height:24),
              //4
              SectionHeader(
                title: 'Quick Journal',
                onSeeAllTap:(){}),
              const SizedBox(height: 13),
              SizedBox(
                height: 155,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  children: const [
                    QuickJournalCard(
                      title: 'Pause & reflect 📝',
                      subtitle: 'What are you grateful for today?',
                      backgroundColor: Color(0xFFFCE3DB),
                      tags: ['Today', 'Personal'],
                    ),
                    QuickJournalCard(
                      title: 'Set Intentions 🌼',
                      subtitle: 'How do you want to feel?',
                      backgroundColor: Color(0xFFEBE3FA),
                      tags: ['Today', 'Family'],
                    ),
                    QuickJournalCard(
                      title: 'Emotions 💭',
                      subtitle: 'Let it flow...',
                      backgroundColor: Color(0xFFFFF3CD),
                      tags: ['Today'],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}