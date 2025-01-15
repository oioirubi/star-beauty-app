import 'package:flutter/material.dart';
import 'barra_lateral.dart';
import 'custom_app_bar.dart';

class CustomizableBaseScreen extends StatefulWidget {
  final Widget child;
  final Widget? cover;
  final bool showSidebar;
  final bool isLoading;
  final String? userName;
  final String? userPhotoUrl;
  final String? containerTitle; // Título opcional do container
  final double maxContentWidth;

  const CustomizableBaseScreen({
    super.key,
    required this.child,
    this.cover,
    this.showSidebar = true,
    this.isLoading = false,
    this.userName,
    this.userPhotoUrl,
    this.containerTitle,
    this.maxContentWidth = 1080.0,
  });

  @override
  _CustomizableBaseScreenState createState() => _CustomizableBaseScreenState();
}

class _CustomizableBaseScreenState extends State<CustomizableBaseScreen> {
  bool _isSidebarExpanded = true;

  void _toggleSidebar() {
    setState(() {
      _isSidebarExpanded = !_isSidebarExpanded;
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    // Padding dinâmico para responsividade
    final contentPadding = EdgeInsets.symmetric(
      horizontal: screenWidth > 1080
          ? 60.0
          : screenWidth < 850
              ? 50.0
              : 60.0 * (screenWidth - 850) / (1080 - 850),
      vertical: 50.0,
    );

    return Scaffold(
      appBar: CustomAppBar(
        userName: widget.userName ?? "Usuário",
        userPhotoUrl: widget.userPhotoUrl,
        onLogout: () {},
        onEditProfile: () {},
        onSettings: () {},
        onNotifications: () {},
        onMessages: () {},
      ),
      body: Row(
        children: [
          if (widget.showSidebar)
            SizedBox(
              width: _isSidebarExpanded ? 220.0 : 45.0,
              child: BaseLateralBar(
                isExpanded: _isSidebarExpanded,
                onToggleSidebar: _toggleSidebar,
              ),
            ),
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: contentPadding, // Aplica o padding dinâmico
                child: Align(
                  alignment: Alignment.topCenter, // Começa do topo
                  child: Container(
                    constraints: BoxConstraints(
                      maxWidth: widget.maxContentWidth,
                      minHeight: 0, // Garante altura da tela
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (widget.cover != null)
                          Padding(
                            padding: const EdgeInsets.only(bottom: 16.0),
                            child: widget.cover!,
                          ),
                        if (widget.isLoading)
                          const Center(
                            child: CircularProgressIndicator(),
                          )
                        else
                          widget.child, // Conteúdo dinâmico
                      ],
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
