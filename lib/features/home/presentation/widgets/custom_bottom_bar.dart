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
  Widget build(BuildContext context){
    return Container(
      margin: const EdgeInsets.fromLTRB(16, 0, 16, 16),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: Color(0xFF1F2123),
        borderRadius: BorderRadius.circular(32),
        boxShadow:[
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.15),
            blurRadius:20,
            offset: const Offset(0,8),
          ),
        ],
      ),
      child: SafeArea(
        top: false,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children:[
              _buildNavItem(
                icon: Icons.home_rounded,
                selectedIcons: Icons.home_rounded,
                label: 'Home',
                index :0,
              ),

              _buildNavItem(
                icon: Icons.calendar_month,
                selectedIcons: Icons.calendar_month_rounded,
                label: 'Schedules',
                index:1,
              ),

              Transform.translate(
                  offset: const Offset(0,-15),
                child:GestureDetector(
                  onTap: onCreateTap,
                  child: Container(
                    width:52,
                    height:52,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: PlanItColors.primary,
                      border: Border.all(
                        color: Colors.white,
                        width: 3.5,
                      ),
                    ),
                    child: const Icon(
                      Icons.add,
                      size: 30,
                      color: Color(0xFF1F2123),
                    ),
                  ),
                ),
              ),

              _buildNavItem(
                icon: Icons.article_rounded,
                selectedIcons: Icons.book_rounded,
                label: 'Journey',
                index:2,
              ),

              _buildNavItem(
                icon: Icons.person_rounded,
                selectedIcons: Icons.person_rounded,
                label: 'Profile',
                index: 3,
              ),
            ]
          ),
        ),
      );
  }

  Widget _buildNavItem({
    required IconData icon,
    required IconData selectedIcons,
    required String label,
    required int index
}){
    final isSelected = currentIndex == index;
    final activeColor = PlanItColors.sage;
    final inactiveColor = PlanItColors.secondary.withValues(alpha: 0.5);

    return InkWell(
      onTap: () => onTap(index),
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              isSelected ? selectedIcons:icon,
              size: 20,
              color: isSelected? activeColor:inactiveColor,
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: TextStyle(
                fontSize: 10,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
                color: isSelected? activeColor:inactiveColor,
              ),
            ),
            const SizedBox(height: 2),

            Container(

            )
          ],
        ),
      )
    );
  }
}