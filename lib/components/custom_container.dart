import 'package:flutter/material.dart';
import 'package:star_beauty_app/components/custom_text.dart';

class CustomContainer extends StatelessWidget {
  final Widget? child;
  final String? title;
  final Color backgroundColor;
  final bool hasGradient;
  final String? backgroundImage;
  final double borderRadius;
  final EdgeInsets contentPadding;
  final Color borderColor;
  final double borderWidth;
  final double elevation;
  final VoidCallback? onTap;

  const CustomContainer({
    super.key,
    this.child,
    this.title,
    this.backgroundColor = Colors.white,
    this.hasGradient = false,
    this.backgroundImage,
    this.borderRadius = 15.0,
    this.contentPadding = const EdgeInsets.all(16.0),
    this.borderColor = const Color(0xFFC4C4C4),
    this.borderWidth = 1.0,
    this.elevation = 4.0,
    this.onTap,
  });

  // Método para Container de Categoria
  static Widget category({
    required String title,
    required String backgroundImage,
    VoidCallback? onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: MouseRegion(
        onEnter: (_) {},
        onExit: (_) {},
        child: Container(
          height: 200,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            image: DecorationImage(
              image: AssetImage(backgroundImage),
              fit: BoxFit.cover,
            ),
          ),
          child: Stack(
            children: [
              // Gradiente
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  gradient: const LinearGradient(
                    colors: [Colors.black, Colors.transparent],
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                  ),
                ),
              ),
              // Título
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Align(
                  alignment: Alignment.bottomLeft,
                  child: CustomText(
                    text: title,
                    isTitle: true,
                    textColor: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Método para Container de Capa
  static Widget cover({
    required String title,
    required String backgroundImage,
  }) {
    return Container(
      height: 300, // Altura ajustada
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        image: DecorationImage(
          image: AssetImage(backgroundImage),
          fit: BoxFit.cover,
        ),
      ),
      child: Stack(
        children: [
          // Gradiente
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              gradient: const LinearGradient(
                colors: [Colors.black, Colors.transparent],
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
              ),
            ),
          ),
          // Título
          Center(
            child: CustomText(
              text: title,
              isBigTitle: true,
              textColor: Colors.white,
            ),
          ),
        ],
      ),
    );
  }

  // Método para Container Padrão (default)
  static Widget defaultContainer({
    required String title,
    required String content,
    EdgeInsets? padding,
  }) {
    return Container(
      padding: padding ?? const EdgeInsets.all(30.0), // Padding padrão
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        border: Border.all(
          color: const Color(0xFFC4C4C4),
          width: 1.0,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomText(
            text: title,
            isTitle: true,
          ),
          const SizedBox(height: 8.0),
          CustomText(
            text: content,
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: elevation,
      borderRadius: BorderRadius.circular(borderRadius),
      child: Container(
        padding: contentPadding,
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(borderRadius),
          border: Border.all(
            color: borderColor,
            width: borderWidth,
          ),
        ),
        child: child,
      ),
    );
  }
}
