import 'dart:ui';

import 'package:flutter/material.dart';

class DateStripSelector extends StatelessWidget{
  final List<Map<String, String >> dates;
  final int selectedIndex;
  final ValueChanged<int>onDateSelected;
  final Color activeColor;

  const DateStripSelector({
    super.key,
    required this.dates,
    required this.selectedIndex,
    required this.onDateSelected,
    this.activeColor = const Color(0xFFEBA834),
});

  @override
  Widget build(BuildContext context){
    return SizedBox(
      height: 70,
      child: ListView.builder(
        scrollDirection:  Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: dates.length,
        itemBuilder: (context, index){
          final item = dates [index];
          final isSelected = index == selectedIndex;

          return GestureDetector(
            onTap: () =>  onDateSelected(index),
            child: Container(
              width: 46,
              margin: const EdgeInsets.symmetric(horizontal:  4),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    item['day']!,
                    style: TextStyle(
                      fontSize: 13,
                      color: isSelected ? Colors.black: Colors.grey[500],
                      fontWeight: isSelected? FontWeight.w600 : FontWeight.normal,
                    ),
                  ),

                  const SizedBox(height: 8),
                  Container(
                    width: 36,
                    height: 36,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: isSelected ? activeColor : Colors.transparent,
                      shape: BoxShape.circle,
                    ),
                    child: Text(
                      item['date']!,
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: isSelected ? Colors.white : Colors.black87,
                      ),
                    )
                  )
                ]
              )
            ),
          );
        }
      )
    );
  }
}