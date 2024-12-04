import 'package:flutter/material.dart';
import 'barra_lateral.dart';
import 'custom_app_bar.dart';
import '../global_state.dart';

class BaseScreen extends StatefulWidget {
  final String userType;
  final String userId;
  final Widget child; // Conteúdo dinâmico da rota

  const BaseScreen({
    super.key,
    required this.userType,
    required this.userId,
    required this.child,
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
          AnimatedContainer(
            duration: const Duration(milliseconds: 250),
            width: _isSidebarExpanded ? 250 : 70,
            child: BaseLateralBar(
              isExpanded: _isSidebarExpanded,
              onToggleSidebar: _toggleSidebar,
            ),
          ),
          // Conteúdo dinâmico
          Expanded(child: widget.child),
        ],
      ),
    );
  }
}
