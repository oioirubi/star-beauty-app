import 'package:flutter/material.dart';

class MatchScreen extends StatelessWidget {
  final String userType;
  // final String userId;

  const MatchScreen({
    super.key,
    required this.userType,
    // required this.userId,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  userType == "Profissional"
                      ? "Encontrar Salões"
                      : "Encontrar Profissionais",
                  style: const TextStyle(
                      fontSize: 24, fontWeight: FontWeight.bold),
                ),
                IconButton(
                  icon: const Icon(Icons.filter_list),
                  onPressed: () {
                    Navigator.pushNamed(context, '/search/filter');
                  },
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount:
                  10, // Número de itens de teste, mudar para dinâmico depois
              itemBuilder: (context, index) {
                return Card(
                  margin: const EdgeInsets.all(8.0),
                  child: ListTile(
                    leading: const CircleAvatar(
                      backgroundImage: NetworkImage(
                        'https://example.com/avatar.jpg', // Exemplo de URL
                      ),
                    ),
                    title: Text("Nome do Usuário ${index + 1}"),
                    subtitle: Text(userType == "Profissional"
                        ? "Salão de Cabelo"
                        : "Cabeleireiro"),
                    trailing: const Icon(Icons.star, color: Colors.yellow),
                    onTap: () {
                      Navigator.pushNamed(context, '/match/details');
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
