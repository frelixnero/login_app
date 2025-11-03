import 'dart:async';
import 'package:flutter/material.dart';

class ReflexButton extends StatefulWidget {
  final VoidCallback onTap;
  final String title;
  final IconData btnIcon;

  const ReflexButton({
    Key? key,
    required this.onTap,
    required this.title,
    required this.btnIcon,
  }) : super(key: key);

  @override
  _ReflexButtonState createState() => _ReflexButtonState();
}

class _ReflexButtonState extends State<ReflexButton> {
  bool _isInverted = false;

  void _handleTap() {
    setState(() => _isInverted = true);

    // Call the ReflexButton function
    widget.onTap();

    // Revert colors after 1.5 seconds
    Future.delayed(Duration(seconds: 2), () {
      if (mounted) {
        setState(() => _isInverted = false);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _handleTap,
      child: Container(
        height: 60,
        margin: EdgeInsets.only(left: 10),
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          color:
              _isInverted
                  ? Theme.of(context).colorScheme.onPrimary
                  : Theme.of(context).colorScheme.primaryContainer,
          border: Border.all(
            color: const Color.fromARGB(255, 255, 255, 255),
            width: 1,
          ),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              widget.btnIcon,
              color:
                  _isInverted
                      ? Theme.of(context).colorScheme.primaryContainer
                      : Theme.of(context).colorScheme.onSecondary,
            ),
            SizedBox(width: 5),
            Text(
              widget.title,
              style: TextStyle(
                color:
                    _isInverted
                        ? Theme.of(context).colorScheme.primaryContainer
                        : Theme.of(context).colorScheme.onSecondary,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
