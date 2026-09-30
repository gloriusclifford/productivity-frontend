import 'package:flutter/material.dart';

class TaskCard extends StatelessWidget {
  final String time;
  final String title;
  final String subtitle;
  final String tag;
  final Color tagColor;
  final Color tagTextColor;
  final Color primaryColor;

  const TaskCard({
    super.key,
    required this.time,
    required this.title,
    required this.subtitle,
    required this.tag,
    required this.tagColor,
    required this.tagTextColor,
    required this.primaryColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Color(0xFFFCDDEC),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.02),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Jam di Sebelah Kiri
          SizedBox(
            width: 45,
            child: Text(
              time,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 12,
                color: Color(0xFF1E2923),
                height: 1.3,
              ),
            ),
          ),
          const SizedBox(width: 8),

          // Detail Isi Tugas
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                    color: Color(0xFF1E2923),
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  subtitle,
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey[600],
                    height: 1.3,
                  ),
                ),
                const SizedBox(height: 12),

                // Avatar Group & Tag Lokasi/Platform
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      height: 24,
                      width: 60,
                      child: Stack(
                        children: [
                          CircleAvatar(
                            radius: 12,
                            backgroundColor: Colors.grey[300],
                            child: const Icon(Icons.person, size: 14, color: Colors.white),
                          ),
                          Positioned(
                            left: 16,
                            child: CircleAvatar(
                              radius: 12,
                              backgroundColor: primaryColor,
                              child: const Icon(Icons.person, size: 14, color: Colors.white),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: tagColor,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        tag,
                        style: TextStyle(
                          color: tagTextColor,
                          fontSize: 11,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}