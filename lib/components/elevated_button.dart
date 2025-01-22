import 'package:flutter/material.dart';

class MyElevatedbutton extends StatelessWidget {
  final Function()? onPressed;
  final ButtonStyle? style;
  final Widget? child;

  const MyElevatedbutton(
      {super.key,
      required this.onPressed,
      required this.style,
      required this.child});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: style,
      child: child,
    );
  }
}
