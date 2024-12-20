import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:star_beauty_app/components/custom_container.dart';
import 'package:star_beauty_app/components/custom_text.dart';

class UserHome extends StatelessWidget {
  const UserHome({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Capa
          _buildCover(),

          const SizedBox(height: 32),

          // Texto introdutório
          const CustomText(
            text: 'Seja bem-vindo(a) à Star Beauty!',
            isBigTitle: true,
            textColor: Colors.black87,
          ),
          const SizedBox(height: 12),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.0),
            child: CustomText(
              text:
                  'Estamos aqui para transformar a forma como você conecta, cresce e gerencia sua carreira ou negócio no universo da beleza.',
              textColor: Colors.black54,
            ),
          ),
          const SizedBox(height: 32),

          // Grid de Containers
          _buildGrid(context),
        ],
      ),
    );
  }

  // Capa com texto "Olá!"
  Widget _buildCover() {
    return CustomContainer.cover(
        backgroundImage: 'assets/images/imagesalao04.jpg', title: 'Olá');
  }

  // Grid de Containers com navegação
  Widget _buildGrid(BuildContext context) {
    final List<Map<String, dynamic>> items = [
      {
        'title': 'News',
        'image': 'assets/images/imagesalao01.jpg',
        'route': '/news',
      },
      {
        'title': 'TV Star Beauty',
        'image': 'assets/images/imagesalao02.jpg',
        'route': '/tv_star_beauty',
      },
      {
        'title': 'Classificados',
        'image': 'assets/images/imagesalao03.jpg',
        'route': '/classificados',
      },
      {
        'title': 'Categoria 4',
        'image': 'assets/images/imagesalao04.jpg',
        'route': '/news',
      },
    ];

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
          childAspectRatio: 1.0,
        ),
        itemCount: items.length,
        itemBuilder: (context, index) {
          return CustomContainer.category(
            title: items[index]['title'],
            backgroundImage: items[index]['image'],
            onTap: () {
              context.go(items[index]['route']);
            },
          );
        },
      ),
    );
  }
}
