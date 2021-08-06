import 'package:flutter/material.dart';

class CircleDotWidget extends StatelessWidget {
  final bool isActive;
  final Color color;
  final Color borderColor;

  CircleDotWidget({Key? key,  required this.isActive, required this.color, required this.borderColor}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 150),
      margin: const EdgeInsets.symmetric(horizontal: 8),
      height: isActive ? 14 : 10,
      width: isActive ? 14 : 10,
      decoration: BoxDecoration(
          border: Border.all(width: 2.0, color: borderColor),
          color: color,
          shape: BoxShape.circle),
    );
  }
}
