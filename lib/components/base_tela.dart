import 'package:flutter/material.dart';
import 'barra_lateral.dart';
import 'custom_app_bar.dart';
import '../global_state.dart';
import 'package:star_beauty_app/components/custom_container.dart';

class BaseScreen extends StatefulWidget {
  final String userType;
  final String userId;
  final Widget child; // Conteúdo dinâmico da rota
  final String? containerTitle; // Título dinâmico do container

  const BaseScreen({
    super.key,
    required this.userType,
    required this.userId,
    required this.child,
    this.containerTitle,
  });

  @override
  _BaseScreenState createState() => _BaseScreenState();
}

class _BaseScreenState extends State<BaseScreen> {
  bool _isSidebarExpanded = true;

  void _toggleSidebar() {
    setState(() {
      _isSidebarExpanded = !_isSidebarExpanded;
    });
  }

  void _onLogout(BuildContext context) {
    GlobalState.userName = null;
    GlobalState.userPhotoUrl = null;
    Navigator.pushNamed(context, '/login');
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    final padding = MediaQuery.of(context).padding;

    // Calcula o padding dinâmico baseado no tamanho da tela, de forma gradual
    final contentPadding = EdgeInsets.symmetric(
      horizontal: screenWidth > 1080
          ? 60.0 // Padding máximo em telas bem largas
          : screenWidth < 850
              ? 0.0 // Sem padding em telas estreitas
              : 60.0 *
                  (screenWidth - 850) /
                  (1080 - 850), // Interpolação gradual
      vertical: 0.0, // Padding vertical fixo
    );

    return Scaffold(
      appBar: CustomAppBar(
        userName: GlobalState.userName,
        userPhotoUrl: GlobalState.userPhotoUrl,
        onLogout: () => _onLogout(context),
        onEditProfile: () => print('Editar Perfil'),
        onSettings: () => print('Configurações'),
      ),
      body: Row(
        children: [
          // Barra lateral
          SizedBox(
            width: _isSidebarExpanded ? 200.0 : 50.0, // Largura fixa
            child: BaseLateralBar(
              isExpanded: _isSidebarExpanded,
              onToggleSidebar: _toggleSidebar,
            ),
          ),
          // Conteúdo principal fixo
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(36.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Center(
                      child: ConstrainedBox(
                        constraints: BoxConstraints(
                          maxWidth: 1080.0, // Largura máxima do container
                          minHeight: screenHeight -
                              padding.top -
                              padding.bottom, // Altura mínima do container
                        ),
                        child: CustomContainer(
                          title: widget.containerTitle,
                          child: Padding(
                            padding: contentPadding,
                            child: Align(
                              alignment: Alignment.topCenter,
                              child: ConstrainedBox(
                                constraints: const BoxConstraints(
                                  maxWidth: 768.0, // Largura máxima do conteúdo
                                ),
                                child:
                                    widget.child, // Conteúdo dinâmico da rota
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
