import 'package:flutter/material.dart';

class CustomText extends StatelessWidget {
  final String text;
  final bool isTitle;
  final bool isBigTitle;
  final Color? textColor;

  const CustomText({
    super.key,
    required this.text,
    this.isTitle = false,
    this.isBigTitle = false,
    this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontSize: isBigTitle
            ? 24.0 // Tamanho maior para bigTitle
            : (isTitle
                ? 20.0
                : 18.0), // Estilo padrão para títulos ou texto normal
        fontWeight: isBigTitle
            ? FontWeight.bold // Fonte mais pesada para bigTitle
            : (isTitle ? FontWeight.bold : FontWeight.w600),
        color: textColor ??
            (isBigTitle
                ? Colors.black
                : (isTitle ? Colors.black87 : Colors.black54)),
      ),
    );
  }
}
