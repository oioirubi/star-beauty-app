import 'package:flutter/material.dart';
import 'base_lateral_bar.dart';
import '../components/custom_app_bar.dart';
import '../global_state.dart';

class BaseScreen extends StatefulWidget {
  final Widget child;
  final String userType;
  final String userId;
  final String? userName;
  final String? userPhotoUrl;

  const BaseScreen({
    Key? key,
    required this.child,
    required this.userType,
    required this.userId,
    this.userName,
    this.userPhotoUrl,
  }) : super(key: key);

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

  void _onEditProfile(BuildContext context) {
    print('Editar Perfil');
  }

  void _onSettings(BuildContext context) {
    print('Configurações');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        userName: widget.userName,
        userPhotoUrl: widget.userPhotoUrl,
        onLogout: () => _onLogout(context),
        onEditProfile: () => _onEditProfile(context),
        onSettings: () => _onSettings(context),
      ),
      body: Row(
        children: [
          AnimatedContainer(
            duration: Duration(milliseconds: 250),
            width: _isSidebarExpanded ? 250 : 70,
            color: Colors.transparent,
            child: Column(
              children: [
                // Header com o botão de retração e o título "Menu"
                Container(
                  padding:
                      EdgeInsets.symmetric(horizontal: 8.0, vertical: 16.0),
                  color: Colors.blueAccent,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Texto "Menu" à esquerda quando expandido
                      if (_isSidebarExpanded)
                        Text(
                          'Menu',
                          style: TextStyle(color: Colors.white, fontSize: 24),
                        ),
                      // Ícone de retração à direita
                      IconButton(
                        icon: Icon(
                          _isSidebarExpanded
                              ? Icons.arrow_back_ios
                              : Icons.menu,
                          color: Colors.white,
                        ),
                        onPressed: _toggleSidebar,
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: BaseLateralBar(
                    userType: widget.userType,
                    userId: widget.userId,
                    isExpanded: _isSidebarExpanded,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: widget.child,
          ),
        ],
      ),
    );
  }
}
