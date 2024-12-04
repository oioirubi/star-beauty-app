import 'package:flutter/material.dart';
import 'package:star_beauty_app/components/custom_text.dart';

class CategoryBox extends StatefulWidget {
  final String title; // Título da categoria
  final Color? backgroundColor; // Cor de fundo
  final String? backgroundImage; // Caminho para imagem local
  final VoidCallback onTap; // Função ao clicar

  const CategoryBox({
    super.key,
    required this.title,
    this.backgroundColor,
    this.backgroundImage,
    required this.onTap,
  });

  @override
  _CategoryBoxState createState() => _CategoryBoxState();
}

class _CategoryBoxState extends State<CategoryBox> {
  bool _isHovered = false; // Verifica se o mouse está sobre a caixa

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: MouseRegion(
        onEnter: (_) => setState(() => _isHovered = true),
        onExit: (_) => setState(() => _isHovered = false),
        child: Stack(
          children: [
            // Fundo (imagem ou cor)
            Container(
              decoration: BoxDecoration(
                color: widget.backgroundImage == null
                    ? widget.backgroundColor ?? Colors.grey[300] // Cor de fundo
                    : null, // Se houver imagem, ignore a cor
                borderRadius: BorderRadius.circular(12.0),
                image: widget.backgroundImage != null
                    ? DecorationImage(
                        image: AssetImage(widget.backgroundImage!),
                        fit: BoxFit.cover,
                      )
                    : null, // Use a imagem se definida
              ),
            ),
            // Gradiente no fundo do texto
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.vertical(
                    bottom: Radius.circular(12.0),
                  ),
                  gradient: LinearGradient(
                    colors: [
                      Colors.black, // Preto na base
                      Colors.transparent // Transparente no topo
                    ],
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                  ),
                ),
                height: 80.0, // Altura do gradiente
              ),
            ),
            // Texto na parte inferior
            Align(
              alignment: Alignment.bottomLeft,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: AnimatedScale(
                  scale: _isHovered ? 1.1 : 1.0,
                  duration: const Duration(milliseconds: 200),
                  child: CustomText(
                    text: widget.title,
                    isTitle: true,
                    textColor: Colors
                        .grey[300], // Certifique-se de passar Colors.white aqui
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
