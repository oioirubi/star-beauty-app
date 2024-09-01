import 'package:flutter/material.dart';
import '../components/custom_app_bar.dart';

class PresentationScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        onLogout: () {},
        onEditProfile: () {},
        onSettings: () {},
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Banner da Apresentação
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(20.0),
              color: Colors.blueAccent,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Bem-vindo ao Star Beauty App',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 32.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 10.0),
                  Text(
                    'A plataforma definitiva para profissionais de beleza e proprietários de salões.',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18.0,
                    ),
                  ),
                  SizedBox(height: 20.0),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/signup');
                    },
                    child: Text('Cadastre-se Agora'),
                  ),
                ],
              ),
            ),
            // Seção de Serviços
            Padding(
              padding: EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Nossos Serviços',
                    style: TextStyle(
                      fontSize: 24.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 10.0),
                  ServiceCard(
                    title: 'Vídeos Educacionais',
                    description:
                        'Assista a vídeos educativos sobre técnicas de beleza, auto gerenciamento, tendências de mercado e muito mais.',
                    icon: Icons.video_library,
                  ),
                  ServiceCard(
                    title: 'GPS da Beleza',
                    description:
                        'Organize suas tarefas, monitore seu faturamento e gerencie sua equipe com nosso guia de auto gerenciamento.',
                    icon: Icons.map,
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
              padding: EdgeInsets.all(20.0),
              color: Colors.blueGrey[50],
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Destaques da Star Beauty',
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
              padding: EdgeInsets.all(20.0),
              child: Center(
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/signup');
                  },
                  child: Text('Comece Agora'),
                  style: ElevatedButton.styleFrom(
                    padding:
                        EdgeInsets.symmetric(horizontal: 40.0, vertical: 20.0),
                    textStyle: TextStyle(fontSize: 20.0),
                  ),
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

  ServiceCard(
      {required this.title, required this.description, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 10.0),
      child: ListTile(
        leading: Icon(icon, size: 40.0),
        title: Text(
          title,
          style: TextStyle(
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Text(description),
      ),
    );
  }
}
