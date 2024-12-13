import 'package:flutter/material.dart';
import 'package:star_beauty_app/components/custom_text.dart';

class MeuAprendizado extends StatelessWidget {
  const MeuAprendizado({super.key, required String userType});

  @override
  Widget build(BuildContext context) {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomText(
          text: 'Meu Aprendizado',
          isTitle: true, // Será formatado como título
        ),
        CustomText(
          text: 'Explore conteúdos incríveis sobre beleza e auto-cuidado.',
        ),
      ],
    );
  }
}
