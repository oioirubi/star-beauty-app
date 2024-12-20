import 'package:flutter/material.dart';

class CustomText extends StatelessWidget {
  final String text;
  final bool isTitle;
  final bool isBigTitle;
  final Color? textColor;
  final double? letterSpacing; // Novo parâmetro opcional para espaçamento

  const CustomText({
    super.key,
    required this.text,
    this.isTitle = false,
    this.isBigTitle = false,
    this.textColor,
    this.letterSpacing, // Inicializa o parâmetro
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontSize: isBigTitle ? 24.0 : (isTitle ? 20.0 : 18.0),
        fontWeight: isBigTitle
            ? FontWeight.bold
            : (isTitle ? FontWeight.bold : FontWeight.w600),
        color: textColor ??
            (isBigTitle
                ? Colors.black
                : (isTitle ? Colors.black87 : Colors.black54)),
        letterSpacing: letterSpacing ?? 0.0, // Aplica o espaçamento
      ),
    );
  }
}
