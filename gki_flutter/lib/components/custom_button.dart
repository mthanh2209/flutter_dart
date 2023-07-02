import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final double? width;
  final double height;
  final String text;
  final Color color;
  final Color borderColor;
  final Color textColor;
  final double radius;

  const CustomButton({
    super.key,
    this.onPressed,
    this.width,
    this.height = 42.0,
    required this.text,
    this.color = Colors.blue,
    this.textColor = Colors.white,
    this.radius = 8.6,
    this.borderColor = Colors.blue,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: width,
        height: height,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: color,
          border: Border.all(color: borderColor, width: 0.86),
          borderRadius: BorderRadius.circular(radius),
        ),
        child: Text(text, style: TextStyle(color: textColor)),
      ),
    );
  }
}
