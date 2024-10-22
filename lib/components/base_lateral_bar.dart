import 'package:flutter/material.dart';
import 'package:star_beauty_app/themes/app_themes.dart';

class BaseLateralBar extends StatefulWidget {
  final String userType;
  final String userId;
  final bool isExpanded;
  final Function(String) onNavigate;

  const BaseLateralBar({
    super.key,
    required this.userType,
    required this.userId,
    required this.isExpanded,
    required this.onNavigate,
  });

  @override
  _BaseLateralBarState createState() => _BaseLateralBarState();
}

class _BaseLateralBarState extends State<BaseLateralBar> {
  bool isTrainingExpanded = false;
  bool isGPSExpanded = false;
  bool isEntertainmentExpanded = false;
  bool isSearchExpanded = false;

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.zero,
      children: [
        // Menu: Treinamento
        ListTile(
          leading: const Icon(Icons.video_library, color: roxo),
          title: widget.isExpanded ? const Text('Treinamento') : null,
          onTap: () {
            setState(() {
              isTrainingExpanded = !isTrainingExpanded;
            });
          },
        ),
        if (widget.isExpanded && isTrainingExpanded) ...[
          ListTile(
            title: const Padding(
              padding: EdgeInsets.only(left: 16.0),
              child: Text('Starflix'),
            ),
            onTap: () {
              widget.onNavigate('/training_videos/starflix');
            },
          ),
          ListTile(
            title: const Padding(
              padding: EdgeInsets.only(left: 16.0),
              child: Text('Meu Aprendizado'),
            ),
            onTap: () {
              widget.onNavigate('/training_videos/recent');
            },
          ),
        ],

        // Menu: GPS da Beleza
        ListTile(
          leading: const Icon(Icons.map, color: roxo),
          title: widget.isExpanded ? const Text('GPS da Beleza') : null,
          onTap: () {
            setState(() {
              isGPSExpanded = !isGPSExpanded;
            });
          },
        ),
        if (widget.isExpanded && isGPSExpanded) ...[
          ListTile(
            title: const Padding(
              padding: EdgeInsets.only(left: 16.0),
              child: Text('Análise SWOT'),
            ),
            onTap: () {
              widget.onNavigate('/swot_analysis');
            },
          ),
          ListTile(
            title: const Padding(
              padding: EdgeInsets.only(left: 16.0),
              child: Text('Painel de Objetivos'),
            ),
            onTap: () {
              widget.onNavigate('/goals_panel');
            },
          ),
          ListTile(
            title: const Padding(
              padding: EdgeInsets.only(left: 16.0),
              child: Text('Relatório Mensal'),
            ),
            onTap: () {
              widget.onNavigate('/monthly_report');
            },
          ),
          ListTile(
            title: const Padding(
              padding: EdgeInsets.only(left: 16.0),
              child: Text('Plano de Ação'),
            ),
            onTap: () {
              widget.onNavigate('/action_plan');
            },
          ),
          ListTile(
            title: const Padding(
              padding: EdgeInsets.only(left: 16.0),
              child: Text('Modelo de Negócio'),
            ),
            onTap: () {
              widget.onNavigate('/business_model');
            },
          ),
        ],

        // Menu: Entretenimento
        ListTile(
          leading: const Icon(Icons.movie, color: roxo),
          title: widget.isExpanded ? const Text('Entretenimento') : null,
          onTap: () {
            setState(() {
              isEntertainmentExpanded = !isEntertainmentExpanded;
            });
          },
        ),
        if (widget.isExpanded && isEntertainmentExpanded) ...[
          ListTile(
            title: const Padding(
              padding: EdgeInsets.only(left: 16.0),
              child: Text('TV Star Beauty'),
            ),
            onTap: () {
              widget.onNavigate('/entertainment/tv_star_beauty');
            },
          ),
          ListTile(
            title: const Padding(
              padding: EdgeInsets.only(left: 16.0),
              child: Text('News'),
            ),
            onTap: () {
              widget.onNavigate('/entertainment/news');
            },
          ),
          ListTile(
            title: const Padding(
              padding: EdgeInsets.only(left: 16.0),
              child: Text('Classificados'),
            ),
            onTap: () {
              widget.onNavigate('/entertainment/classifieds');
            },
          ),
        ],

        // Menu: Busca e Match
        ListTile(
          leading: const Icon(Icons.search, color: roxo),
          title: widget.isExpanded ? const Text('Busca e Match') : null,
          onTap: () {
            setState(() {
              isSearchExpanded = !isSearchExpanded;
            });
          },
        ),
        if (widget.isExpanded && isSearchExpanded) ...[
          ListTile(
            title: const Padding(
              padding: EdgeInsets.only(left: 16.0),
              child: Text('Filtrar'),
            ),
            onTap: () {
              widget.onNavigate('/search/filter');
            },
          ),
          ListTile(
            title: const Padding(
              padding: EdgeInsets.only(left: 16.0),
              child: Text('Visualizar Todos'),
            ),
            onTap: () {
              widget.onNavigate('/search/view_all');
            },
          ),
        ],
      ],
    );
  }
}
