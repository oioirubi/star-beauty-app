import 'package:flutter/material.dart';
import '../global_state.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String? userName;
  final String? userPhotoUrl;
  final VoidCallback onLogout;
  final VoidCallback onEditProfile;
  final VoidCallback onSettings;

  CustomAppBar({
    Key? key,
    this.userName,
    this.userPhotoUrl,
    required this.onLogout,
    required this.onEditProfile,
    required this.onSettings,
  })  : preferredSize = const Size.fromHeight(kToolbarHeight),
        super(key: key);

  @override
  final Size preferredSize;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.blueAccent, // Definir a cor de fundo
      title: Row(
        children: [
          Icon(Icons.star, color: Colors.yellow),
          SizedBox(width: 8),
          Text('StarBeauty'),
        ],
      ),
      actions: [
        if (userName == null) ...[
          TextButton(
            onPressed: () {
              Navigator.pushNamed(context, '/login');
            },
            child: Text('Login', style: TextStyle(color: Colors.white)),
          ),
          TextButton(
            onPressed: () {
              Navigator.pushNamed(context, '/signup');
            },
            child: Text('Cadastrar', style: TextStyle(color: Colors.white)),
          ),
        ] else ...[
          Text('Olá, $userName', style: TextStyle(color: Colors.white)),
          SizedBox(width: 8),
          if (userPhotoUrl != null)
            CircleAvatar(
              backgroundImage: NetworkImage(userPhotoUrl!),
            )
          else
            Icon(Icons.account_circle, color: Colors.white),
          PopupMenuButton<String>(
            onSelected: (String result) {
              switch (result) {
                case 'settings':
                  onSettings();
                  break;
                case 'edit_profile':
                  onEditProfile();
                  break;
                case 'logout':
                  onLogout();
                  break;
              }
            },
            itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
              const PopupMenuItem<String>(
                value: 'settings',
                child: Text('Configurações'),
              ),
              const PopupMenuItem<String>(
                value: 'edit_profile',
                child: Text('Editar Perfil'),
              ),
              const PopupMenuItem<String>(
                value: 'logout',
                child: Text('Sair'),
              ),
            ],
          ),
        ],
      ],
    );
  }
}
