import 'package:flutter/material.dart';
import 'package:star_beauty_app/components/custom_text.dart';
import 'package:star_beauty_app/components/category_model.dart';
import 'package:go_router/go_router.dart';

class Entretenimento extends StatelessWidget {
  const Entretenimento({
    super.key,
    required String title,
    required String description,
    required List<CategoryModel> categories,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        // Largura disponível para o grid
        final screenWidth = constraints.maxWidth;

        // Limites do tamanho dos itens no grid
        const double minItemSize = 200.0;
        const double maxItemSize = 250.0;

        // Cálculo dinâmico do tamanho dos itens
        double itemSize;
        if (screenWidth < 1080) {
          // Interpolação gradual entre minItemSize e maxItemSize
          itemSize = minItemSize +
              ((screenWidth - 0) / (1080 - 0)) * (maxItemSize - minItemSize);
          itemSize =
              itemSize.clamp(minItemSize, maxItemSize); // Garante os limites
        } else {
          itemSize = maxItemSize; // Tamanho fixo para telas maiores
        }

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Adicionando a capa
            CategoryModel(
              title: 'Entretenimento',
              backgroundImage:
                  'assets/images/imagesalao04.jpg', // Imagem da capa
              onTap: () => print('Capa clicada!'),
              isCover: true, // Define como capa
            ),
            const SizedBox(height: 40), // Espaçamento entre a capa e o conteúdo

            // Texto introdutório
            const CustomText(
              text: 'Relaxe e inspire-se com conteúdos exclusivos',
              isTitle: true,
            ),
            const SizedBox(height: 16),
            const CustomText(
              text:
                  'A beleza também é sobre diversão e criatividade. Aqui você pode explorar vídeos, dicas e histórias inspiradoras para se desconectar e se inspirar.',
            ),
            const SizedBox(height: 24),

            // Grid de categorias
            GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: (screenWidth ~/ itemSize)
                    .clamp(1, 4), // Define dinamicamente o número de colunas
                crossAxisSpacing: 16, // Espaço horizontal entre os itens
                mainAxisSpacing: 16, // Espaço vertical entre os itens
                childAspectRatio: 1, // Itens quadrados (1:1)
              ),
              shrinkWrap: true, // Faz o grid se ajustar ao tamanho do conteúdo
              physics:
                  const NeverScrollableScrollPhysics(), // Remove a rolagem do grid
              itemCount: 3, // Quantidade de categorias
              itemBuilder: (context, index) {
                // Exemplo de categorias
                final categories = [
                  CategoryModel(
                    title: ' News',
                    backgroundImage: 'assets/images/imagemcategoria02.jpg',
                    onTap: () {
                      context.go('/news'); // Navega para a rota usando GoRouter
                    },
                  ),
                  CategoryModel(
                    title: ' TV Star Beauty',
                    backgroundImage: 'assets/images/imagemcategoria11.jpg',
                    onTap: () {
                      context.go(
                          '/tv_star_beauty'); // Navega para a rota usando GoRouter
                    },
                  ),
                  CategoryModel(
                    title: ' Classificados',
                    backgroundImage: 'assets/images/imagesalao02.jpg',
                    onTap: () {
                      context.go(
                          '/classificados'); // Navega para a rota usando GoRouter
                    },
                  ),
                  CategoryModel(
                    title: 'Categoria 4',
                    backgroundColor: Colors.green,
                    onTap: () {
                      context.go('/news'); // Navega para a rota usando GoRouter
                    },
                  ),
                ];

                return SizedBox(
                  width: itemSize,
                  height: itemSize,
                  child: categories[index], // Categoria correspondente
                );
              },
            ),
          ],
        );
      },
    );
  }
}
