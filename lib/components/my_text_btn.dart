import 'dart:async';
import 'package:flutter/material.dart';

class MyTextBtn extends StatefulWidget {
  final VoidCallback onTap;
  final String title;

  const MyTextBtn({Key? key, required this.onTap, required this.title})
    : super(key: key);

  @override
  _MyTextBtnState createState() => _MyTextBtnState();
}

class _MyTextBtnState extends State<MyTextBtn> {
  bool _isInverted = false;

  void _handleTap() {
    setState(() => _isInverted = true);

    // Call the MyTextBtn function
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
            Text(
              widget.title,
              style: TextStyle(
                color:
                    _isInverted
                        ? Theme.of(context).colorScheme.primaryContainer
                        : Theme.of(context).colorScheme.primary,
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
