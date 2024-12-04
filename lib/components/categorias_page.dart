import 'package:flutter/material.dart';
import 'package:star_beauty_app/components/custom_text.dart';
import 'package:star_beauty_app/components/category_box.dart';

class CategoriasPage extends StatelessWidget {
  const CategoriasPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const CustomText(
          text: 'Bem-vindo ao Entretenimento!',
          isTitle: true,
        ),
        const SizedBox(height: 16),
        const CustomText(
          text:
              'Explore categorias e descubra conteúdos incríveis para sua experiência.',
        ),
        const SizedBox(height: 24),
        // O GridView cresce conforme o conteúdo
        GridView.count(
          crossAxisCount: 2, // Número de colunas no grid
          crossAxisSpacing: 16, // Espaço horizontal entre as caixas
          mainAxisSpacing: 16, // Espaço vertical entre as caixas
          shrinkWrap: true, // Faz o grid se ajustar ao tamanho do conteúdo
          physics:
              const NeverScrollableScrollPhysics(), // Remove a rolagem do grid
          children: [
            CategoryBox(
              title: 'Categoria 1',
              backgroundImage: 'assets/images/imagesalao01.jpg',
              onTap: () => print('Navegando para Categoria 1'),
            ),
            CategoryBox(
              title: 'Categoria 2',
              backgroundColor: Colors.blueAccent,
              onTap: () => print('Navegando para Categoria 2'),
            ),
            CategoryBox(
              title: 'Categoria 3',
              backgroundImage: 'assets/images/imagesalao02.jpg',
              onTap: () => print('Navegando para Categoria 3'),
            ),
            CategoryBox(
              title: 'Categoria 4',
              backgroundColor: Colors.green,
              onTap: () => print('Navegando para Categoria 4'),
            ),
          ],
        ),
      ],
    );
  }
}
