import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:star_beauty_app/themes/app_themes.dart';
import '../components/custom_app_bar.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class HomeScreen extends StatelessWidget {
  final String userId = 'test-user-id';

  const HomeScreen({super.key}); // Substituir pelo ID real do usuário

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        onLogout: () {},
        onEditProfile: () {},
        onSettings: () {},
        onNotifications: () {},
        onMessages: () {},
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Banner da Apresentação
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20.0),
              color: Theme.of(context).colorScheme.primary,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Bem-vindo(a) à Star Beauty',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 32.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10.0),
                  const Text(
                    'A plataforma definitiva para profissionais de beleza e proprietários de salões.',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18.0,
                    ),
                  ),
                  const SizedBox(height: 20.0),
                  ElevatedButton(
                    onPressed: () {
                      GoRouter.of(context).go('/signup');
                    },
                    child: const Text('Cadastre-se Agora'),
                  ),
                ],
              ),
            ),
            // Seção de Serviços
            const Padding(
              padding: EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Funcionalidades',
                    style: TextStyle(
                      fontSize: 24.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 10.0),
                  ServiceCard(
                    title: 'GPS da Beleza',
                    description:
                        'Organize suas tarefas, monitore seu faturamento e gerencie sua equipe com nosso guia de auto gerenciamento.',
                    icon: Icons.map,
                  ),
                  ServiceCard(
                    title: 'Educação',
                    description:
                        'Assista a vídeos educativos sobre técnicas de beleza, auto gerenciamento, tendências de mercado e muito mais.',
                    icon: FontAwesomeIcons.camera,
                  ),
                  ServiceCard(
                    title: 'Entretenimento',
                    description:
                        'Fique atualizado com as últimas inovações e novidades no setor de beleza.',
                    icon: Icons.movie,
                  ),
                  ServiceCard(
                    title: 'Busca e Match',
                    description:
                        'Encontre e contrate profissionais ou descubra novas oportunidades de trabalho com nosso sistema de match.',
                    icon: Icons.search,
                  ),
                ],
              ),
            ),
            // Seção de Destaque
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20.0),
              color: branquinho,
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'A Conexão que você procurava',
                    style: TextStyle(
                      fontSize: 24.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 10.0),
                  Text(
                    'Nosso sistema de match facilita a conexão entre profissionais e proprietários, garantindo as melhores oportunidades para todos.',
                    style: TextStyle(fontSize: 18.0),
                  ),
                ],
              ),
            ),
            // Seção de Chamada para Ação
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Center(
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/signup');
                  },
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 40.0, vertical: 20.0),
                    textStyle: const TextStyle(fontSize: 20.0),
                  ),
                  child: const Text('Comece Agora'),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ServiceCard extends StatelessWidget {
  final String title;
  final String description;
  final IconData icon;

  const ServiceCard(
      {super.key,
      required this.title,
      required this.description,
      required this.icon});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 10.0),
      child: ListTile(
        leading: Icon(icon, size: 40.0),
        title: Text(
          title,
          style: const TextStyle(
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Text(description),
      ),
    );
  }
}
