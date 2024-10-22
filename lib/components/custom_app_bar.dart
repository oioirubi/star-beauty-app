import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String? userName;
  final String? userPhotoUrl;
  final VoidCallback onLogout;
  final VoidCallback onEditProfile;
  final VoidCallback onSettings;

  const CustomAppBar({
    super.key,
    this.userName,
    this.userPhotoUrl,
    required this.onLogout,
    required this.onEditProfile,
    required this.onSettings,
  }) : preferredSize = const Size.fromHeight(kToolbarHeight);

  @override
  final Size preferredSize;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor:
          Theme.of(context).colorScheme.primary, // Definir a cor de fundo
      title: Row(
        children: [
          Icon(Icons.star, color: Theme.of(context).colorScheme.secondary),
          const SizedBox(width: 8),
          const Text('StarBeauty'),
        ],
      ),
      actions: [
        if (userName == null) ...[
          TextButton(
            onPressed: () {
              Navigator.pushNamed(context, '/login');
            },
            child: const Text('Login', style: TextStyle(color: Colors.white)),
          ),
          TextButton(
            onPressed: () {
              Navigator.pushNamed(context, '/signup');
            },
            child:
                const Text('Cadastrar', style: TextStyle(color: Colors.white)),
          ),
        ] else ...[
          Text('Olá, $userName', style: const TextStyle(color: Colors.white)),
          const SizedBox(width: 8),
          if (userPhotoUrl != null)
            CircleAvatar(
              backgroundImage: NetworkImage(userPhotoUrl!),
            )
          else
            const Icon(Icons.account_circle, color: Colors.white),
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
