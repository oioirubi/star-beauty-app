import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:star_beauty_app/themes/app_themes.dart';

class BaseLateralBar extends StatelessWidget {
  final bool isExpanded;
  final VoidCallback onToggleSidebar;

  const BaseLateralBar({
    super.key,
    required this.isExpanded,
    required this.onToggleSidebar,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: isExpanded ? 220 : 45, // Largura dinâmica
      color: Colors.black12.withOpacity(0.05), // Cor de fundo
      child: Column(
        children: [
          // Cabeçalho da barra lateral (com botão de expansão/retração)
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 1.0, vertical: 1.0),
            child: Row(
              mainAxisAlignment:
                  isExpanded ? MainAxisAlignment.end : MainAxisAlignment.center,
              children: [
                IconButton(
                  icon: Icon(
                    isExpanded ? Icons.arrow_back_ios : Icons.menu,
                    color: roxo,
                  ),
                  onPressed: onToggleSidebar,
                ),
              ],
            ),
          ),
          // Lista de itens do menu
          Expanded(
            child: ListView(
              children: [
                // Treinamento
                _buildMenuItem(
                  context,
                  icon: Icons.school, // Ícone de escola para treinamento
                  title: 'Treinamento',
                  route: '/treinamento',
                  showText: isExpanded,
                ),
                _buildMenuItem(
                  context,
                  icon: Icons.lightbulb, // Ícone de aprendizado
                  title: 'Meu aprendizado',
                  route: '/meu_aprendizado',
                  isSubItem: true,
                  showText: isExpanded,
                ),

                _buildMenuItem(
                  context,
                  icon: Icons.star, // Ícone de estrela para Starflix
                  title: 'Starflix',
                  route: '/starflix',
                  isSubItem: true,
                  showText: isExpanded,
                ),

                // GPS da Beleza
                _buildMenuItem(
                  context,
                  icon: Icons.map, // Ícone de mapa para GPS
                  title: 'GPS da Beleza',
                  route: '/gps_da_beleza',
                  showText: isExpanded,
                ),
                _buildMenuItem(
                  context,
                  icon: Icons.assessment, // Ícone de análise
                  title: 'Análize SWOT',
                  route: '/analise_swot',
                  isSubItem: true,
                  showText: isExpanded,
                ),
                _buildMenuItem(
                  context,
                  icon: Icons.bar_chart, // Ícone de relatório mensal
                  title: 'Relatório Mensal',
                  route: '/relatorio_mensal',
                  isSubItem: true,
                  showText: isExpanded,
                ),
                _buildMenuItem(
                  context,
                  icon: Icons.task, // Ícone de plano de ação
                  title: 'Plano de Ação',
                  route: '/plano_de_acao',
                  isSubItem: true,
                  showText: isExpanded,
                ),
                _buildMenuItem(
                  context,
                  icon: Icons.business, // Ícone de modelo de negócio
                  title: 'Modelo de negócio',
                  route: '/modelo_de_negocio',
                  isSubItem: true,
                  showText: isExpanded,
                ),

                // Entretenimento
                _buildMenuItem(
                  context,
                  icon: Icons.theater_comedy, // Ícone para entretenimento
                  title: 'Entretenimento',
                  route: '/entretenimento',
                  showText: isExpanded,
                ),
                _buildMenuItem(
                  context,
                  icon: Icons.newspaper, // Ícone para notícias
                  title: 'News',
                  route: '/news',
                  isSubItem: true,
                  showText: isExpanded,
                ),
                _buildMenuItem(
                  context,
                  icon: Icons.tv, // Ícone para TV Star Beauty
                  title: 'TV Star Beauty',
                  route: '/tv_star_beauty',
                  isSubItem: true,
                  showText: isExpanded,
                ),
                _buildMenuItem(
                  context,
                  icon: Icons.list_alt, // Ícone para classificados
                  title: 'Classificados',
                  route: '/classificados',
                  isSubItem: true,
                  showText: isExpanded,
                ),

                // Busca e Match
                _buildMenuItem(
                  context,
                  icon: Icons.search, // Ícone para busca e match
                  title: 'Busca e Match',
                  route: '/busca_e_match',
                  showText: isExpanded,
                ),
                _buildMenuItem(
                  context,
                  icon: Icons.format_list_bulleted, // Ícone para listagem
                  title: 'Listagem',
                  route: '/listagem',
                  isSubItem: true,
                  showText: isExpanded,
                ),
                _buildMenuItem(
                  context,
                  icon: Icons.favorite, // Ícone para meus matches
                  title: 'Meus matchs',
                  route: '/meus_matchs',
                  isSubItem: true,
                  showText: isExpanded,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Método para criar os itens do menu
  Widget _buildMenuItem(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String route,
    required bool showText,
    bool isSubItem = false,
  }) {
    final currentRoute = GoRouterState.of(context).uri.toString();
    final bool isActive = currentRoute == route;

    // Variável para controlar o hover
    ValueNotifier<bool> isHovered = ValueNotifier(false);

    return MouseRegion(
      onEnter: (_) => isHovered.value = !isActive, // Hover só se não for ativo
      onExit: (_) => isHovered.value = false,
      child: ValueListenableBuilder<bool>(
        valueListenable: isHovered,
        builder: (context, hovered, child) {
          return GestureDetector(
            onTap: () => context.go(route),
            child: Container(
              decoration: BoxDecoration(
                color: isActive
                    ? roxo.withOpacity(0.2) // Fundo para item ativo
                    : hovered
                        ? roxo.withOpacity(0.1) // Fundo ao passar o mouse
                        : Colors.transparent,
                borderRadius: BorderRadius.circular(0.0),
              ),
              padding: EdgeInsets.symmetric(
                vertical: 8.0,
                horizontal: showText
                    ? (isSubItem
                        ? 30.0
                        : 10.0) // Espaçamento extra para subitens
                    : 10.0, // Ícones alinhados ao retrair
              ),
              child: Row(
                mainAxisAlignment: showText
                    ? MainAxisAlignment.start
                    : MainAxisAlignment.start, // Centraliza ícones se retraído
                children: [
                  // Ícone sempre visível
                  Icon(
                    icon,
                    color: isActive ? roxo : roxo.withOpacity(0.7),
                  ),
                  // Texto visível apenas se a barra estiver expandida
                  if (showText)
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: Text(
                          title,
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: isActive ? Colors.black : Colors.black54,
                          ),
                          overflow:
                              TextOverflow.ellipsis, // Trunca o texto longo
                          maxLines: 1, // Limita a apenas uma linha
                        ),
                      ),
                    ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
