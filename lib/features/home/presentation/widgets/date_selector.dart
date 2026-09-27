import 'package:flutter/material.dart';

class DateSelector extends StatelessWidget {
  final Color primaryColor;

  const DateSelector({
    super.key,
    required this.primaryColor,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 70,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: 5,
        separatorBuilder: (context, index) => const SizedBox(width: 12),
        itemBuilder: (context, index) {
          final days = ['MON', 'TUE', 'WED', 'THU', 'FRI'];
          final dates = ['23', '24', '25', '26', '27'];
          final isSelected = index == 1; // TUE 24 dipilih

          return Container(
            width: 52,
            decoration: BoxDecoration(
              color: Colors.transparent,
              border: isSelected
                  ? Border.all(color: primaryColor, width: 2)
                  : null,
              borderRadius: BorderRadius.circular(26),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  days[index],
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                    color: isSelected ? primaryColor : Colors.grey[500],
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  dates[index],
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: isSelected ? primaryColor : const Color(0xFF1E2923),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}