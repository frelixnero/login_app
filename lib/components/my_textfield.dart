import 'package:flutter/material.dart';

class MyTextField extends StatelessWidget {
  final String hintText;
  final TextEditingController controller;
  final bool obscureText;
  final Widget? preIcon;
  const MyTextField({
    super.key,
    required this.hintText,
    required this.controller,
    required this.preIcon,
    this.obscureText = false,
  });

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 0),
      child: TextField(
        controller: controller,

        obscureText: obscureText,
        cursorColor: Theme.of(context).colorScheme.tertiary,
        decoration: InputDecoration(
          prefixIcon: preIcon,
          hintText: hintText,
          hintStyle: TextStyle(color: Theme.of(context).colorScheme.secondary),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(
              color: Theme.of(context).colorScheme.secondary,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(
              color: Theme.of(context).colorScheme.tertiary,
            ),
          ),
          fillColor: Theme.of(context).colorScheme.surface,
          filled: true,
        ),
      ),
    );
  }
}
