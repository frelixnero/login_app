import 'package:flutter/material.dart';

class MyIconBtn extends StatelessWidget {
  final IconData icon;
  final VoidCallback onPressed;
  final double height;
  final double width;

  const MyIconBtn({
    super.key,
    required this.icon,
    required this.onPressed,
    required this.height,
    required this.width,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Theme.of(context).colorScheme.primaryContainer,
      ),
      child: IconButton(
        icon: Icon(icon),
        onPressed: onPressed,
        color: Theme.of(context).colorScheme.primary,
      ),
    );
  }
}
