import 'package:flutter/material.dart';

// ignore: must_be_immutable
class TextIconBtn extends StatelessWidget {
  final String buttonText;
  final Function()? onTap;
  double marginHorizontal = 10;
  final Color borderColor;
  final double borderWidth;
  final Color? containerColor;
  final String imagePath;
  final double height;
  final double width;
  TextIconBtn({
    super.key,
    required this.buttonText,
    required this.onTap,
    this.marginHorizontal = 10,
    required this.borderColor,
    required this.borderWidth,
    required this.containerColor,
    required this.imagePath,
    this.height = 50,
    required this.width,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: height,
        width: double.infinity,
        decoration: BoxDecoration(
          color: containerColor,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: borderColor, width: borderWidth),
        ),
        padding: EdgeInsets.all(10),
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                buttonText,
                style: TextStyle(
                  color: Theme.of(context).colorScheme.onSecondary,

                  fontSize: 22,
                ),
              ),
              SizedBox(width: 5),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: Colors.transparent,
                ),
                child: Image.asset(imagePath, height: height, width: width),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
