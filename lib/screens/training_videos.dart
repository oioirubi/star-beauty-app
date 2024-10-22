import 'package:flutter/material.dart';
import '../components/base_screen.dart';

class TrainingVideos extends StatelessWidget {
  final String userType;

  const TrainingVideos({super.key, required this.userType});

  @override
  Widget build(BuildContext context) {
    // Substitua 'userId' pelo valor real do ID do usuário
    return BaseScreen(
      userType: userType,
      userId: 'userId', // Passe o userId correto aqui
      child: const Center(
        child: Text(
          'Aqui estão os vídeos de treinamento!',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}
