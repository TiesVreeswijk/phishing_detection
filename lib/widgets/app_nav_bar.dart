import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

class AppNavBar extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;

  const AppNavBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final items = <_NavBarItemData>[
      _NavBarItemData(icon: Icons.home_rounded, label: 'HOME'),
      _NavBarItemData(icon: Icons.cloud_upload_rounded, label: 'UPLOAD'),
      _NavBarItemData(icon: Icons.history_rounded, label: 'HISTORY'),
      _NavBarItemData(icon: Icons.insert_chart_outlined_rounded, label: 'ANALYSIS'),
    ];

    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFFF7F8FA),
        border: const Border(
          top: BorderSide(
            color: Color(0xFFE6EAF0),
            width: 1,
          ),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 8,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      padding: const EdgeInsets.fromLTRB(12, 10, 12, 18),
      child: SafeArea(
        top: false,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: List.generate(items.length, (index) {
            final item = items[index];
            final isSelected = currentIndex == index;

            return Expanded(
              child: GestureDetector(
                onTap: () => onTap(index),
                behavior: HitTestBehavior.opaque,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      width: 38,
                      height: 38,
                      decoration: BoxDecoration(
                        color: isSelected
                            ? AppColors.navActiveBg
                            : Colors.transparent,
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        item.icon,
                        size: 20,
                        color: isSelected
                            ? AppColors.navActiveIcon
                            : AppColors.navIcon,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      item.label,
                      style: TextStyle(
                        fontSize: 10,
                        letterSpacing: 0.4,
                        fontWeight: FontWeight.w700,
                        color: isSelected
                            ? AppColors.navActiveIcon
                            : AppColors.navIcon,
                      ),
                    ),
                  ],
                ),
              ),
            );
          }),
        ),
      ),
    );
  }
}

class _NavBarItemData {
  final IconData icon;
  final String label;

  _NavBarItemData({
    required this.icon,
    required this.label,
  });
}