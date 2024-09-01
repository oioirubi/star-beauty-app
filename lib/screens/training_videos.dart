import 'package:flutter/material.dart';
import 'base_screen.dart';

class TrainingVideos extends StatelessWidget {
  final String userType;

  const TrainingVideos({Key? key, required this.userType}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Substitua 'userId' pelo valor real do ID do usuário
    return BaseScreen(
      userType: userType,
      userId: 'userId', // Passe o userId correto aqui
      child: Center(
        child: Text(
          'Aqui estão os vídeos de treinamento!',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}
