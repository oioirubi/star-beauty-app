import 'package:flutter/material.dart';
import 'base_lateral_bar.dart';
import 'custom_app_bar.dart';
import '../global_state.dart';
import 'package:star_beauty_app/themes/app_themes.dart';

class BaseScreen extends StatefulWidget {
  final String userType;
  final String userId;
  final String? userName;
  final String? userPhotoUrl;

  const BaseScreen({
    super.key,
    required this.userType,
    required this.userId,
    this.userName,
    this.userPhotoUrl,
    required Center child,
  });

  @override
  _BaseScreenState createState() => _BaseScreenState();
}

class _BaseScreenState extends State<BaseScreen> {
  bool _isSidebarExpanded = true;
  final GlobalKey<NavigatorState> _navigatorKey = GlobalKey<NavigatorState>();

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

  void _navigateTo(String routeName) {
    _navigatorKey.currentState?.pushReplacementNamed(routeName);
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
            duration: const Duration(milliseconds: 250),
            width: _isSidebarExpanded ? 250 : 70,
            color: Colors.transparent,
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 8.0, vertical: 16.0),
                  color: roxo,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      if (_isSidebarExpanded)
                        const Text(
                          'Menu',
                          style: TextStyle(color: Colors.white, fontSize: 24),
                        ),
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
                    onNavigate: _navigateTo, // Passa a função de navegação
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Navigator(
              key: _navigatorKey,
              onGenerateRoute: (settings) {
                WidgetBuilder builder;
                switch (settings.name) {
                  case '/training_videos':
                    builder = (BuildContext _) =>
                        const Center(child: Text('Treinamento'));
                    break;
                  case '/swot_analysis':
                    builder = (BuildContext _) =>
                        const Center(child: Text('Análise SWOT'));
                    break;
                  // Adicione todas as suas outras rotas aqui...
                  default:
                    builder = (BuildContext _) =>
                        const Center(child: Text('Selecione uma opção'));
                }
                return MaterialPageRoute(builder: builder);
              },
            ),
          ),
        ],
      ),
    );
  }
}
