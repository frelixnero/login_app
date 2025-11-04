import 'package:flutter/material.dart';

class MyTextField extends StatelessWidget {
  final String hintText;
  final TextEditingController controller;
  final bool obscureText;
  final Widget? preIcon;
  final void Function()? onTap;
  final void Function(String)? onChanged;

  const MyTextField({
    super.key,
    required this.hintText,
    required this.controller,
    required this.preIcon,
    this.obscureText = false,
    this.onTap,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 0),
      child: TextField(
        controller: controller,
        onTap: onTap,
        onChanged: onChanged,

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
