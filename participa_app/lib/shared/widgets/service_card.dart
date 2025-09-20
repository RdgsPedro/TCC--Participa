import 'package:flutter/material.dart';

class ServiceCard extends StatelessWidget {
  const ServiceCard({
    super.key,
    required this.icon,
    required this.label,
    this.pageRedirection,
    this.onTap,
  });

  final IconData icon;
  final String label;
  final String? pageRedirection;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        double maxW = constraints.maxWidth;

        double iconSize = maxW * 0.12;
        double fontSize = maxW * 0.08;
        if (fontSize < 12) fontSize = 12;
        if (fontSize > 18) fontSize = 18;

        return ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Theme.of(context).colorScheme.tertiary,
            side: BorderSide(
              color: Theme.of(context).colorScheme.onPrimary,
              width: 2,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
          ),
          onPressed: () => onTap,
          child: Row(
            children: [
              Container(
                width: iconSize + 25,
                height: iconSize + 25,
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.onPrimary,
                  shape: BoxShape.circle,
                ),
                child: Icon(icon, color: Colors.white, size: iconSize),
              ),
              const SizedBox(width: 5),
              Flexible(
                child: Text(
                  label,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: fontSize,
                    fontWeight: FontWeight.w500,
                    color: Theme.of(context).colorScheme.onPrimary,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
