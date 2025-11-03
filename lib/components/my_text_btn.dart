import 'package:flutter/material.dart';

// ignore: must_be_immutable
class MyButton extends StatelessWidget {
  final String buttonText;
  final Function()? onTap;
  double marginHorizontal = 10;
  MyButton({
    super.key,
    required this.buttonText,
    required this.onTap,
    this.marginHorizontal = 10,
  });

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.primaryContainer,
          borderRadius: BorderRadius.circular(12),
        ),
        padding: EdgeInsets.all(20),
        margin: EdgeInsets.symmetric(horizontal: marginHorizontal),
        child: Center(
          child: Text(
            buttonText,
            style: TextStyle(
              color: Theme.of(context).colorScheme.primary,
              fontWeight: FontWeight.bold,
              fontSize: 22,
            ),
          ),
        ),
      ),
    );
  }
}
