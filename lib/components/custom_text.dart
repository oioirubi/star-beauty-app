import 'package:flutter/material.dart';

class CustomText extends StatelessWidget {
  final String text;
  final bool isTitle;
  final Color? textColor;

  const CustomText({
    super.key,
    required this.text,
    this.isTitle = false,
    this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontSize: isTitle ? 20 : 18,
        fontWeight: isTitle ? FontWeight.bold : FontWeight.w600,
        color: textColor ?? (isTitle ? Colors.black87 : Colors.black54),
      ),
    );
  }
}
