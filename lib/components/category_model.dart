import 'package:flutter/material.dart';
import 'package:star_beauty_app/components/custom_text.dart';

class CategoryModel extends StatefulWidget {
  final String title; // Título da categoria
  final Color? backgroundColor; // Cor de fundo
  final String? backgroundImage; // Caminho para imagem local
  final VoidCallback onTap; // Função ao clicar
  final bool isCover; // Indica se é uma capa (novo parâmetro)

  const CategoryModel({
    super.key,
    required this.title,
    this.backgroundColor,
    this.backgroundImage,
    required this.onTap,
    this.isCover = false, // Padrão: não é uma capa
  });

  @override
  _CategoryModelState createState() => _CategoryModelState();
}

class _CategoryModelState extends State<CategoryModel> {
  bool _isHovered = false; // Verifica se o mouse está sobre a caixa

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: MouseRegion(
        onEnter: (_) => setState(() => _isHovered = true),
        onExit: (_) => setState(() => _isHovered = false),
        child: SizedBox(
          height: widget.isCover ? 250.0 : null, // Altura fixa para capa
          child: ClipRRect(
            borderRadius: BorderRadius.circular(
                widget.isCover ? 12.0 : 12.0), // Cantos arredondados
            child: Container(
              decoration: BoxDecoration(
                color: widget.backgroundImage == null
                    ? widget.backgroundColor ?? Colors.grey[300]
                    : null,
                image: widget.backgroundImage != null
                    ? DecorationImage(
                        image: AssetImage(widget.backgroundImage!),
                        fit: BoxFit.cover,
                      )
                    : null,
              ),
              child: Stack(
                children: [
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
                      height: 130.0, // Altura do gradiente
                    ),
                  ),
                  // Texto para capa com bigTitle
                  if (widget.isCover)
                    Align(
                      alignment: Alignment.bottomLeft,
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: CustomText(
                          text: widget.title,
                          isBigTitle: true, // Aplica o bigTitle
                          textColor: Colors.white,
                        ),
                      ),
                    ),
                  // Texto normal para categorias
                  if (!widget.isCover)
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
                            textColor: Colors.white,
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
