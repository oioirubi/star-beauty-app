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
    return AnimatedContainer(
      duration: const Duration(milliseconds: 250), // Duração da animação
      width: isExpanded ? 250 : 50, // Largura da barra expandida/retraída
      height:
          double.infinity, // Altura total da barra (verticalmente ajustável)
      color: Colors.black12.withOpacity(0.05), // Cor de fundo da barra lateral
      child: Column(
        children: [
          // Cabeçalho da barra lateral
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 6.0, vertical: 6.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
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
          // Menus e submenus sempre abertos
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
                  icon: Icons.video_library, // Ícone de vídeos
                  title: 'Vídeos recentes',
                  route: '/videos_recentes',
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
                  title: 'Meus matches',
                  route: '/meus matches',
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
    required bool showText, // Controla se o texto deve ser exibido
    Color backgroundColor = Colors.transparent, // Cor de fundo padrão
    Color hoverColor = Colors.blue, // Cor ao passar o mouse
    Color textColor = Colors.black, // Cor do texto
    Color iconColor = roxo, // Cor do ícone
    bool isSubItem = false, // Define se é um subitem
  }) {
    return StatefulBuilder(
      builder: (BuildContext context, StateSetter setState) {
        // Define estado local para hover
        bool isHovered = false;

        return MouseRegion(
          onEnter: (_) => setState(() => isHovered = true), // Ativa hover
          onExit: (_) => setState(() => isHovered = false), // Desativa hover
          child: GestureDetector(
            onTap: () => context.go(route), // Navegação
            child: AnimatedContainer(
              duration:
                  const Duration(milliseconds: 200), // Suaviza a transição
              decoration: BoxDecoration(
                color: isHovered ? hoverColor : backgroundColor, // Cor dinâmica
              ),
              padding:
                  const EdgeInsets.symmetric(vertical: 8.0, horizontal: 10.0),
              child: Row(
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                      left: showText ? (isSubItem ? 35.0 : 15.0) : 5.0,
                    ),
                    child: SizedBox(
                      width: 30,
                      height: 30,
                      child: Icon(
                        icon,
                        color: iconColor,
                      ),
                    ),
                  ),
                  if (showText)
                    Expanded(
                      child: AnimatedOpacity(
                        opacity: showText ? 1.0 : 0.0,
                        duration: const Duration(milliseconds: 250),
                        child: Padding(
                          padding: const EdgeInsets.only(left: 5.0),
                          child: Text(
                            title,
                            style: TextStyle(
                              color: textColor,
                              letterSpacing: 1,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
