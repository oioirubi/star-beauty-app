import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String? userName;
  final String? userPhotoUrl;
  final VoidCallback onLogout;
  final VoidCallback onEditProfile;
  final VoidCallback onSettings;
  final VoidCallback onNotifications;
  final VoidCallback onMessages;

  const CustomAppBar({
    super.key,
    this.userName,
    this.userPhotoUrl,
    required this.onLogout,
    required this.onEditProfile,
    required this.onSettings,
    required this.onNotifications,
    required this.onMessages,
  }) : preferredSize = const Size.fromHeight(kToolbarHeight);

  @override
  final Size preferredSize;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Theme.of(context).colorScheme.primary,
      title: Row(
        children: [
          Icon(Icons.star, color: Theme.of(context).colorScheme.secondary),
          const SizedBox(width: 8),
          const Text('StarBeauty'),
        ],
      ),
      actions: [
        if (userName == null) ...[
          // Botões para não logados
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
          // Ícones para logados
          IconButton(
            icon: const Icon(Icons.notifications),
            onPressed: onNotifications,
            tooltip: 'Notificações',
          ),
          IconButton(
            icon: const Icon(Icons.message),
            onPressed: onMessages,
            tooltip: 'Mensagens',
          ),
          // Foto do usuário com menu suspenso
          PopupMenuButton<String>(
            icon: CircleAvatar(
              backgroundImage:
                  userPhotoUrl != null ? NetworkImage(userPhotoUrl!) : null,
              child: userPhotoUrl == null
                  ? const Icon(Icons.account_circle, color: Colors.white)
                  : null,
            ),
            onSelected: (String result) {
              switch (result) {
                case 'view_profile':
                  print('Meu perfil');
                  break;
                case 'edit_profile':
                  onEditProfile();
                  break;
                case 'notifications':
                  onNotifications();
                  break;
                case 'auth':
                  print('Autenticação');
                  break;
                case 'logout':
                  onLogout();
                  break;
              }
            },
            itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
              const PopupMenuItem<String>(
                value: 'perfil_usuario',
                child: ListTile(
                  leading: Icon(Icons.person),
                  title: Text('Meu Perfil'),
                ),
              ),
              const PopupMenuItem<String>(
                value: 'meus_matchs',
                child: ListTile(
                  leading: Icon(Icons.person),
                  title: Text('Conexões'),
                ),
              ),
              const PopupMenuItem<String>(
                value: 'atividade',
                child: ListTile(
                  leading: Icon(Icons.person),
                  title: Text('Atividade'),
                ),
              ),
              const PopupMenuItem<String>(
                value: 'notifications',
                child: ListTile(
                  leading: Icon(Icons.notifications),
                  title: Text('Notificações'),
                ),
              ),
              const PopupMenuDivider(),
              const PopupMenuItem<String>(
                value: 'logout',
                child: ListTile(
                  leading: Icon(Icons.exit_to_app),
                  title: Text('Sair'),
                ),
              ),
            ],
          ),
          const SizedBox(width: 16),
        ],
      ],
    );
  }
}
