import 'package:flutter/material.dart';
import 'package:star_beauty_app/components/custom_text.dart';
import 'package:star_beauty_app/components/category_model.dart';
import 'package:go_router/go_router.dart';

class BuscaEMatch extends StatelessWidget {
  const BuscaEMatch({
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
              title: 'Busca e Match',
              backgroundImage:
                  'assets/images/imagesalao04.jpg', // Imagem da capa
              onTap: () => print('Capa clicada!'),
              isCover: true, // Define como capa
            ),
            const SizedBox(height: 40), // Espaçamento entre a capa e o conteúdo

            // Texto introdutório
            const CustomText(
              text: 'Encontre ou seja encontrado com facilidade',
              isTitle: true,
            ),
            const SizedBox(height: 16),
            const CustomText(
              text:
                  'Seja você um profissional da beleza ou proprietário(a) de um estabelecimento, nossa funcionalidade de "match" conecta quem busca oportunidades a quem precisa delas. Filtre por especialidade, localização e muito mais para encontrar a parceria ideal.',
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
              itemCount: 4, // Quantidade de categorias
              itemBuilder: (context, index) {
                // Exemplo de categorias
                final categories = [
                  CategoryModel(
                    title: ' Meus Matchs',
                    backgroundColor: Colors.deepPurple,
                    onTap: () {
                      context.go(
                          '/meus_matchs'); // Navega para a rota usando GoRouter
                    },
                  ),
                  CategoryModel(
                    title: ' Encontrar parceiros',
                    backgroundColor: Colors.blueAccent,
                    onTap: () {
                      context.go(
                          '/listagem'); // Navega para a rota usando GoRouter
                    },
                  ),
                  CategoryModel(
                    title: ' Editar meu perfil',
                    backgroundImage: 'assets/images/imagesalao02.jpg',
                    onTap: () {
                      context.go(
                          '/match_cadastro'); // Navega para a rota usando GoRouter
                    },
                  ),
                  CategoryModel(
                    title: ' Conversas',
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
