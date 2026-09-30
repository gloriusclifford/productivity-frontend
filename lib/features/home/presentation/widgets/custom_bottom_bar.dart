import 'package:flutter/material.dart';
import 'package:productivity_app_frontend/app/theme/app_theme.dart';

class CustomBottomNavbar extends StatelessWidget{
  final int currentIndex;
  final Function(int) onTap;
  final VoidCallback? onCreateTap;

  const CustomBottomNavbar({
    super.key,
    required this.currentIndex,
    required this.onTap,
    this.onCreateTap,
});

  @override
  Widget build(BuildContext){
    return Container(
      decoration: BoxDecoration(
        color: PlanItColors.background,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(28)),
        boxShadow:[
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius:16,
            offset: const Offset(0,-4),
          ),
        ],
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children:[
              _buildNavItem(
                icon: Icons.home_rounded,
                label: 'Home',
                index :0,
              ),

              _buildNavItem(
                icon: Icons.calendar_month,
                label: 'Schedules',
                index:1,
              ),

              GestureDetector(
                onTap: onCreateTap,
                child: Container(
                  width:44,
                  height:44,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.add,
                    size: 26,
                  ),
                ),
              ),

              _buildNavItem(
                icon: Icons.article_rounded,
                label: 'Journey',
                index:2,
              ),

              _buildNavItem(
                icon: Icons.person_rounded,
                label: 'Profile',
                index: 3,
              ),
            ]
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem({
    required IconData icon,
    required String label,
    required int index
}){
    final isSelected = currentIndex == index;

    return InkWell(
      onTap: () => onTap(index),
      borderRadius: BorderRadius.circular(16),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 22),
            const SizedBox(height: 4),
            Text(
              label,
              style: TextStyle(
                fontSize: 10,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
              ),
            ),
          ],
        ),
      )
    );
  }
}