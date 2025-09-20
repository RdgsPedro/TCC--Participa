import 'package:flutter/material.dart';

class SignInButton extends StatelessWidget {
  final void Function()? onTap;
  final String imageIcon;

  const SignInButton({super.key, this.onTap, required this.imageIcon});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(25),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.secondary,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Theme.of(context).colorScheme.secondary),
        ),
        child: Image.asset(imageIcon, height: 32, fit: BoxFit.contain),
      ),
    );
  }
}
