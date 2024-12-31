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

  // Método para Container de Categoria
  static Widget category({
    required String title,
    required String backgroundImage,
    VoidCallback? onTap,
  }) {
    final ValueNotifier<bool> isHovered = ValueNotifier(false);

    return GestureDetector(
      onTap: onTap,
      child: MouseRegion(
        onEnter: (_) => isHovered.value = true,
        onExit: (_) => isHovered.value = false,
        child: Stack(
          children: [
            // Imagem de fundo com gradiente
            Container(
              height: 200,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                image: DecorationImage(
                  image: AssetImage(backgroundImage),
                  fit: BoxFit.cover,
                ),
              ),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  gradient: const LinearGradient(
                    colors: [Colors.black, Colors.transparent],
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                  ),
                ),
              ),
            ),
            // Texto com efeito de zoom fixado na parte inferior
            Positioned(
              bottom: 12.0, // Ajuste vertical para posicionar o texto
              left: 12.0, // Ajuste horizontal para afastar da borda
              child: ValueListenableBuilder<bool>(
                valueListenable: isHovered,
                builder: (context, hover, child) {
                  return AnimatedScale(
                    scale: hover ? 1.1 : 1.0, // Aplica o zoom no texto
                    duration: const Duration(milliseconds: 200),
                    child: CustomText(
                      text: title,
                      isTitle: true,
                      textColor: Colors.white,
                    ),
                  );
                },
              ),
            ),
          ],
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

// Método para Container Pai (Quadro do Trello)
  static Widget trelloBoard({
    required String title,
    required List<Widget> children,
    double height = 500, // Altura padrão
  }) {
    return Container(
      margin: const EdgeInsets.all(4.0),
      padding: const EdgeInsets.all(13.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        border: Border.all(
          color: const Color(0xFFC4C4C4),
          width: 1.0,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Título do Quadro
          Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: Text(
              title,
              style: const TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
          ),
          // Lista de containers filhos
          SizedBox(
            height: height, // Limite de altura
            child: ListView(
              physics: const BouncingScrollPhysics(),
              children: children,
            ),
          ),
        ],
      ),
    );
  }

// Método para Container Filho (Cartão do Trello)
  static Widget trelloCard({
    required String content,
    required Key key,
  }) {
    return Draggable<String>(
      data: content,
      feedback: Material(
        elevation: 6, // Elevação para destacar o feedback
        child: Container(
          padding: const EdgeInsets.all(12.0),
          width: 250, // Largura fixa para o feedback
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.2),
                blurRadius: 4,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Text(
            content,
            style: const TextStyle(fontSize: 16.0, color: Colors.black87),
          ),
        ),
      ),
      childWhenDragging: Container(
        padding: const EdgeInsets.all(12.0),
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.grey[300],
          borderRadius: BorderRadius.circular(8),
        ),
        child: Text(
          content,
          style: const TextStyle(fontSize: 16.0, color: Colors.black54),
        ),
      ),
      child: Container(
        padding: const EdgeInsets.all(12.0),
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Text(
          content,
          style: const TextStyle(fontSize: 16.0, color: Colors.black87),
        ),
      ),
    );
  }

  // Método auxiliar para construir os cartões
  static Widget _buildCard(String content, {bool isDragging = false}) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      padding: const EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        color: isDragging ? Colors.grey[300] : Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: const Color(0xFFC4C4C4),
          width: 1.0,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Text(
        content,
        style: const TextStyle(
          fontSize: 16.0,
          fontWeight: FontWeight.w500,
          color: Colors.black87,
        ),
      ),
    );
  }

  static Widget editableCard({
    required String content,
    required Key key,
    required ValueChanged<String> onUpdate,
    required Color lineColor,
    bool isEditing = false,
  }) {
    final TextEditingController controller =
        TextEditingController(text: content);
    final ValueNotifier<bool> isHovered = ValueNotifier(false);
    final ValueNotifier<bool> editing = ValueNotifier(isEditing);

    return MouseRegion(
      onEnter: (_) => isHovered.value = true,
      onExit: (_) => isHovered.value = false,
      child: Stack(
        children: [
          GestureDetector(
            onTap: () {
              if (!editing.value) {
                editing.value = true;
              }
            },
            child: Container(
              padding: const EdgeInsets.all(8.0),
              width: double.infinity,
              constraints: const BoxConstraints(minHeight: 50),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
                border: Border(
                  top: BorderSide(color: lineColor, width: 4),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 4,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: ValueListenableBuilder<bool>(
                valueListenable: editing,
                builder: (context, isEditing, child) {
                  if (isEditing) {
                    return TextField(
                      controller: controller,
                      onSubmitted: (value) {
                        onUpdate(value);
                        editing.value = false;
                      },
                      autofocus: true,
                      decoration: const InputDecoration(
                        hintText: 'Digite algo...',
                        border: InputBorder.none,
                      ),
                    );
                  } else {
                    return Text(
                      content.isNotEmpty ? content : 'Digite algo...',
                      style: const TextStyle(
                        fontSize: 16.0,
                        color: Colors.black87,
                      ),
                    );
                  }
                },
              ),
            ),
          ),
          ValueListenableBuilder<bool>(
            valueListenable: isHovered,
            builder: (context, hovered, child) {
              return Visibility(
                visible: hovered,
                child: Positioned(
                  top: 4,
                  right: 4,
                  child: GestureDetector(
                    onTap: () {
                      editing.value = true;
                    },
                    child: const Icon(
                      Icons.edit,
                      size: 18,
                      color: Colors.grey,
                    ),
                  ),
                ),
              );
            },
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
