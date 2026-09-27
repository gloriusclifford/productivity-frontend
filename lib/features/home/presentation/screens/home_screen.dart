import 'package:flutter/material.dart';
import '../widgets/date_selector.dart';
import '../widgets/section_header.dart';
import '../widgets/task_card.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    const primaryColor = Color(0xFF436B5C);
    const backgroundColor = Color(0xFFF3F5F3);

    return Scaffold(
      backgroundColor: backgroundColor,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text('Today', style: TextStyle(color: Colors.grey, fontSize: 14)),
                      SizedBox(height: 2),
                      Text(
                        'Oct 24, Tue',
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF1E2923),
                        ),
                      ),
                    ],
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.04),
                          blurRadius: 8,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: IconButton(
                      icon: const Icon(Icons.notifications_outlined, size: 22),
                      onPressed: () {},
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),

              // Reusable Date Selector
              const DateSelector(primaryColor: primaryColor),
              const SizedBox(height: 24),

              // Section Morning
              const SectionHeader(title: '☀️ Morning'),
              const SizedBox(height: 12),
              TaskCard(
                time: '9:00\nAM',
                title: 'Design System Sync',
                subtitle: 'Reviewing the new sage palette and typography components.',
                tag: 'Zoom',
                tagColor: Colors.blue[50]!,
                tagTextColor: Colors.blue[700]!,
                primaryColor: primaryColor,
              ),
              const SizedBox(height: 12),
              TaskCard(
                time: '11:30\nAM',
                title: 'Greenhouse Visit',
                subtitle: 'Site inspection for the botanical garden project.',
                tag: 'Brooklyn',
                tagColor: Colors.purple[50]!,
                tagTextColor: Colors.purple[700]!,
                primaryColor: primaryColor,
              ),
              const SizedBox(height: 24),

              // Section Afternoon
              const SectionHeader(title: '🌤️ Afternoon'),
              const SizedBox(height: 12),
              TaskCard(
                time: '2:00\nPM',
                title: 'Client Workshop',
                subtitle: 'Discovery phase kickoff meeting with stakeholders.',
                tag: '# Room 402',
                tagColor: Colors.orange[50]!,
                tagTextColor: Colors.orange[800]!,
                primaryColor: primaryColor,
              ),
              const SizedBox(height: 80),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: primaryColor,
        elevation: 4,
        shape: const CircleBorder(),
        child: const Icon(Icons.add, color: Colors.white, size: 28),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, -2),
            ),
          ],
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                IconButton(
                  icon: const Icon(Icons.home_filled, color: primaryColor),
                  onPressed: () {},
                ),
                IconButton(
                  icon: Icon(Icons.calendar_month, color: Colors.grey[400]),
                  onPressed: () {},
                ),
                IconButton(
                  icon: Icon(Icons.folder_outlined, color: Colors.grey[400]),
                  onPressed: () {},
                ),
                IconButton(
                  icon: Icon(Icons.person_outline, color: Colors.grey[400]),
                  onPressed: () {},
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}