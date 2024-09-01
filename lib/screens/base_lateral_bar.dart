import 'package:flutter/material.dart';

class BaseLateralBar extends StatefulWidget {
  final String userType;
  final String userId;
  final bool isExpanded;

  const BaseLateralBar({
    Key? key,
    required this.userType,
    required this.userId,
    required this.isExpanded,
  }) : super(key: key);

  @override
  _BaseLateralBarState createState() => _BaseLateralBarState();
}

class _BaseLateralBarState extends State<BaseLateralBar> {
  // Estados para controlar a expansão de cada item
  bool isTrainingExpanded = false;
  bool isGPSExpanded = false;
  bool isEntertainmentExpanded = false;
  bool isSearchExpanded = false;

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.zero,
      children: [
        ListTile(
          leading: Icon(Icons.video_library, color: Colors.black),
          title: widget.isExpanded ? Text('Treinamento') : null,
          onTap: () {
            setState(() {
              isTrainingExpanded = !isTrainingExpanded;
            });
          },
        ),
        if (widget.isExpanded && isTrainingExpanded) ...[
          ListTile(
            title: Padding(
              padding: const EdgeInsets.only(left: 16.0),
              child: Text('Vídeo 1'),
            ),
            onTap: () {
              Navigator.pushNamed(context, '/training_videos');
            },
          ),
          ListTile(
            title: Padding(
              padding: const EdgeInsets.only(left: 16.0),
              child: Text('Vídeo 2'),
            ),
            onTap: () {
              Navigator.pushNamed(context, '/training_videos');
            },
          ),
        ],
        ListTile(
          leading: Icon(Icons.map, color: Colors.black),
          title: widget.isExpanded ? Text('GPS da Beleza') : null,
          onTap: () {
            setState(() {
              isGPSExpanded = !isGPSExpanded;
            });
          },
        ),
        if (widget.isExpanded && isGPSExpanded) ...[
          ListTile(
            title: Padding(
              padding: const EdgeInsets.only(left: 16.0),
              child: Text('Análise SWOT'),
            ),
            onTap: () {
              Navigator.pushNamed(context, '/swot_analysis');
            },
          ),
          ListTile(
            title: Padding(
              padding: const EdgeInsets.only(left: 16.0),
              child: Text('Painel de Objetivos'),
            ),
            onTap: () {
              Navigator.pushNamed(context, '/objectives_panel');
            },
          ),
          ListTile(
            title: Padding(
              padding: const EdgeInsets.only(left: 16.0),
              child: Text('Relatório Mensal'),
            ),
            onTap: () {
              Navigator.pushNamed(context, '/monthly_report');
            },
          ),
          ListTile(
            title: Padding(
              padding: const EdgeInsets.only(left: 16.0),
              child: Text('Plano de Ação'),
            ),
            onTap: () {
              Navigator.pushNamed(context, '/action_plan');
            },
          ),
          ListTile(
            title: Padding(
              padding: const EdgeInsets.only(left: 16.0),
              child: Text('Modelo de Negócio'),
            ),
            onTap: () {
              Navigator.pushNamed(context, '/business_model');
            },
          ),
        ],
        ListTile(
          leading: Icon(Icons.movie, color: Colors.black),
          title: widget.isExpanded ? Text('Entretenimento') : null,
          onTap: () {
            setState(() {
              isEntertainmentExpanded = !isEntertainmentExpanded;
            });
          },
        ),
        if (widget.isExpanded && isEntertainmentExpanded) ...[
          ListTile(
            title: Padding(
              padding: const EdgeInsets.only(left: 16.0),
              child: Text('Vídeo de Inovações'),
            ),
            onTap: () {
              Navigator.pushNamed(context, '/entertainment');
            },
          ),
          ListTile(
            title: Padding(
              padding: const EdgeInsets.only(left: 16.0),
              child: Text('Comunidade'),
            ),
            onTap: () {
              Navigator.pushNamed(context, '/entertainment');
            },
          ),
        ],
        ListTile(
          leading: Icon(Icons.search, color: Colors.black),
          title: widget.isExpanded ? Text('Busca e Match') : null,
          onTap: () {
            setState(() {
              isSearchExpanded = !isSearchExpanded;
            });
          },
        ),
        if (widget.isExpanded && isSearchExpanded) ...[
          ListTile(
            title: Padding(
              padding: const EdgeInsets.only(left: 16.0),
              child: Text('Filtrar'),
            ),
            onTap: () {
              Navigator.pushNamed(context, '/match');
            },
          ),
          ListTile(
            title: Padding(
              padding: const EdgeInsets.only(left: 16.0),
              child: Text('Visualizar Todos'),
            ),
            onTap: () {
              Navigator.pushNamed(context, '/match');
            },
          ),
        ],
      ],
    );
  }
}
