import 'dart:async';
import 'package:flutter/material.dart';
import 'package:login_app/util/responsive.dart' show Responsive;
import 'package:provider/provider.dart';

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
    final responsiveProvider = Provider.of<Responsive>(context);
    return GestureDetector(
      onTap: _handleTap,
      child: Container(
        height:
            responsiveProvider.isTextLarge(context)
                ? 67
                : responsiveProvider.isTextEnormous(context)
                ? 80
                : 54,
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
