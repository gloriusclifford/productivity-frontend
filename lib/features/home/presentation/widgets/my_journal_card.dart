import 'package:flutter/material.dart';

class MyJournalCard extends StatelessWidget{
  final String title;
  final String subtitle;
  final Color backgroundColor;

  const MyJournalCard({
    super.key,
    required this.title,
    required this.subtitle,
    required this.backgroundColor,
});

  @override
  Widget build(BuildContext context){
    return Container(
      width: 250,
      margin: const EdgeInsets.only(right: 12),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(20)
      ),
      child: Stack(
        children: [
          Padding(
            padding:const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF2C2C2C),
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  subtitle,
                  style: const TextStyle(
                    fontSize: 12,
                    color: Color(0xFF5A5A5A),
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: ClipRRect(
              borderRadius: const BorderRadius.vertical(bottom: Radius.circular(20)),
              child: Container(
                height: 120,
                color: Colors.orange.shade200,
                child: const Icon(
                  Icons.wb_sunny_rounded,
                  size: 60,
                  color: Colors.orange,
                )
              ),
            ),
          ),
        ],
      ),
    );
  }
}
class SideJournalCard extends StatelessWidget {
  final String title;
  final Color backgroundColor;

  const SideJournalCard({
    super.key,
    required this.title,
    required this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 80,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Center(
        child: RotatedBox(
          quarterTurns: 3,
          child: Text(
            title,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Color(0xFF4A4A4A),
            ),
          ),
        ),
      ),
    );
  }
}