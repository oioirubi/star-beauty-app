import 'package:flutter/material.dart';
import 'package:star_beauty_app/components/custom_text.dart';

class UserHome extends StatelessWidget {
  const UserHome({super.key, required String userId, required String userType});

  @override
  Widget build(BuildContext context) {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomText(
          text: 'Bem-vindo ao Starflix!',
          isTitle: true, // Será formatado como título
        ),
        CustomText(
          text: 'Explore conteúdos incríveis sobre beleza e auto-cuidado.',
        ),
      ],
    );
  }
}
