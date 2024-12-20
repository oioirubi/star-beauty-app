import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:star_beauty_app/global_state/firebase_auth_notifier.dart';
import 'barra_lateral.dart';
import 'custom_app_bar.dart';
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

  @override
  Widget build(BuildContext context) {
    final authNotifier = Provider.of<FirebaseAuthNotifier>(context);

    // Estado de carregamento
    if (authNotifier.isLoading) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    // Usuário não autenticado
    if (authNotifier.currentUser == null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        GoRouter.of(context).go('/login');
      });
      return const SizedBox(); // Retorna um widget vazio durante o redirecionamento
    }

    // Dados do usuário logado
    final userName = authNotifier.currentUser!.displayName ?? 'Usuário';
    final userPhotoUrl = authNotifier.currentUser!.photoURL;

    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    final padding = MediaQuery.of(context).padding;

    // Calcula o padding dinâmico baseado no tamanho da tela
    final contentPadding = EdgeInsets.symmetric(
      horizontal: screenWidth > 1080
          ? 60.0 // Padding máximo em telas bem largas
          : screenWidth < 850
              ? 0.0 // Sem padding em telas estreitas
              : 60.0 *
                  (screenWidth - 850) /
                  (1080 - 850), // Interpolação gradual
      vertical: 30.0,
    );

    return Scaffold(
      appBar: CustomAppBar(
        userName: userName,
        userPhotoUrl: userPhotoUrl,
        onLogout: () {
          authNotifier.currentUser = null; // Limpa o usuário atual
          GoRouter.of(context).go('/login');
        },
        onEditProfile: () => print('Editar Perfil'),
        onSettings: () => print('Configurações'),
        onNotifications: () => print('Notificações'),
        onMessages: () => print('Mensagens'),
      ),
      body: Row(
        children: [
          // Barra lateral
          SizedBox(
            width: _isSidebarExpanded ? 220.0 : 45.0, // Largura fixa
            child: BaseLateralBar(
              isExpanded: _isSidebarExpanded,
              onToggleSidebar: _toggleSidebar,
            ),
          ),
          // Conteúdo principal fixo
          Flexible(
            child: SingleChildScrollView(
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(36.0),
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                      maxWidth: 1080.0, // Largura máxima do container
                      minHeight: screenHeight - padding.top - padding.bottom,
                    ),
                    child: CustomContainer(
                      title: widget.containerTitle,
                      child: Padding(
                        padding: contentPadding,
                        child: Align(
                          alignment: Alignment.topCenter,
                          child: ConstrainedBox(
                            constraints: const BoxConstraints(
                              maxWidth: 1080.0, // Largura máxima do conteúdo
                            ),
                            child: widget.child, // Conteúdo dinâmico da rota
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
