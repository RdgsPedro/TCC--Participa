import 'package:flutter/material.dart';

class CustomNavBar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onItemTapped;
  final VoidCallback onCenterButtonTap;

  const CustomNavBar({
    super.key,
    required this.currentIndex,
    required this.onItemTapped,
    required this.onCenterButtonTap,
  });

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      shape: const CircularNotchedRectangle(),
      notchMargin: 8.0,
      color: Theme.of(context).colorScheme.primary,
      elevation: 10,
      child: SizedBox(
        height: 70,
        child: Row(
          children: [
            Expanded(child: _buildNavItem(context, Icons.home, "Início", 0)),
            Expanded(
              child: _buildNavItem(context, Icons.newspaper, "Notícias", 1),
            ),

            SizedBox(
              width: 80,
              child: GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: onCenterButtonTap,
                child: const SizedBox.expand(),
              ),
            ),

            Expanded(
              child: _buildNavItem(context, Icons.sensors, "Transmissão", 3),
            ),
            Expanded(
              child: _buildNavItem(context, Icons.waving_hand, "Pautas", 4),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNavItem(
    BuildContext context,
    IconData icon,
    String label,
    int index,
  ) {
    final isSelected = index == currentIndex;

    final screenWidth = MediaQuery.of(context).size.width;
    final scale = (screenWidth / 400).clamp(0.85, 1.25);

    final iconSize = (isSelected ? 28.0 : 24.0) * scale;
    final baseFontSize = 10.0 * scale;

    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () => onItemTapped(index),
      child: SizedBox(
        height: 70,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              color: isSelected ? Colors.white : Colors.white70,
              size: iconSize,
            ),
            const SizedBox(height: 4),

            SizedBox(
              height: 16,
              child: FittedBox(
                fit: BoxFit.scaleDown,
                child: Text(
                  label,
                  maxLines: 1,
                  style: TextStyle(
                    fontSize: baseFontSize,
                    fontWeight: isSelected
                        ? FontWeight.bold
                        : FontWeight.normal,
                    color: isSelected ? Colors.white : Colors.white70,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 4),
            AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              width: isSelected ? 20 : 0,
              height: 3,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
