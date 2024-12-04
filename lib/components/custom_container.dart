import 'package:flutter/material.dart';
import 'package:star_beauty_app/components/custom_text.dart';

class CustomContainer extends StatelessWidget {
  final String? title; // Título opcional do container
  final String? content; // Conteúdo opcional
  final Color backgroundColor; // Cor de fundo
  final double borderRadius; // Raio das bordas
  final double elevation; // Intensidade da sombra
  final Color borderColor; // Cor da borda
  final double borderWidth; // Largura da borda
  final Widget? child; // Widget filho (child)
  final EdgeInsets contentPadding; // Espaçamento interno do conteúdo

  const CustomContainer({
    super.key,
    this.title,
    this.content,
    this.backgroundColor = Colors.white,
    this.borderRadius = 15.0,
    this.elevation = 4.0,
    this.borderColor = const Color(0xFFC4C4C4),
    this.borderWidth = 1.0,
    this.child,
    this.contentPadding = const EdgeInsets.all(40.0),
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 4.0,
      borderRadius: BorderRadius.circular(15.0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15.0),
          border: Border.all(
            color: const Color(0xFFC4C4C4),
            width: 1.0,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(40.0),
          child: Column(
            mainAxisSize: MainAxisSize.min, // Ajusta ao conteúdo
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (title != null)
                CustomText(
                  text: title!,
                  isTitle: true,
                ),
              if (title != null) const SizedBox(height: 16),
              if (child != null) child!,
            ],
          ),
        ),
      ),
    );
  }
}
