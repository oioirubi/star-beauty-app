import 'package:flutter/material.dart';
import 'package:star_beauty_app/components/custom_container.dart';

class GpsDaBeleza extends StatelessWidget {
  const GpsDaBeleza({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // Container de Capa
        CustomContainer.cover(
          title: 'Descubra o Melhor da Beleza',
          backgroundImage: 'assets/images/imagesalao01.jpg',
        ),
        const SizedBox(height: 16.0),

        // Container Default
        CustomContainer.defaultContainer(
          title: 'Bem-vindo ao GPS da Beleza',
          content:
              'Explore as melhores categorias e conteúdos personalizados para você!',
        ),
        const SizedBox(height: 16.0),

        // Containers de Categoria
        Row(
          children: [
            Expanded(
              child: CustomContainer.category(
                title: 'Maquiagem',
                backgroundImage: 'assets/images/maquiagem.jpg',
                onTap: () {
                  print('Categoria Maquiagem clicada!');
                },
              ),
            ),
            const SizedBox(width: 8.0),
            Expanded(
              child: CustomContainer.category(
                title: 'Cabelos',
                backgroundImage: 'assets/images/cabelos.jpg',
                onTap: () {
                  print('Categoria Cabelos clicada!');
                },
              ),
            ),
          ],
        ),
        const SizedBox(height: 8.0),
        Row(
          children: [
            Expanded(
              child: CustomContainer.category(
                title: 'Pele',
                backgroundImage: 'assets/images/pele.jpg',
                onTap: () {
                  print('Categoria Pele clicada!');
                },
              ),
            ),
            const SizedBox(width: 8.0),
            Expanded(
              child: CustomContainer.category(
                title: 'Unhas',
                backgroundImage: 'assets/images/unhas.jpg',
                onTap: () {
                  print('Categoria Unhas clicada!');
                },
              ),
            ),
          ],
        ),
      ],
    );
  }
}
