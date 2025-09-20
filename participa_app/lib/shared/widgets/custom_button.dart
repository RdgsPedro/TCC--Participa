import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final void Function()? onTap;
  final String text;
  final Color boxColor;
  final Color borderColor;
  final Color fontColor;

  const CustomButton({
    super.key,
    this.onTap,
    required this.text,
    required this.boxColor,
    required this.borderColor,
    required this.fontColor,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 18),
        decoration: BoxDecoration(
          color: boxColor,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: borderColor, width: 2),
        ),
        child: Center(
          child: Text(
            text,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
              color: fontColor,
            ),
          ),
        ),
      ),
    );
  }
}
