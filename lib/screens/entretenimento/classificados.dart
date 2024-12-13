import 'package:flutter/material.dart';
import 'package:star_beauty_app/components/custom_text.dart';

class Classificados extends StatelessWidget {
  final String userType;

  const Classificados({super.key, required this.userType});

  @override
  Widget build(BuildContext context) {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomText(
          text: 'Bem-vindo aos Classificados!',
          isTitle: true, // Será formatado como título
        ),
        CustomText(
          text: 'Explore conteúdos incríveis sobre beleza e auto-cuidado.',
        ),
      ],
    );
  }
}
