import 'package:flutter/material.dart';
import 'package:star_beauty_app/components/custom_text.dart';

class TvStarBeauty extends StatelessWidget {
  const TvStarBeauty({super.key, required String userType});

  @override
  Widget build(BuildContext context) {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomText(
          text: 'Bem-vindo à TV Star Beauty',
          isTitle: true, // Será formatado como título
        ),
        CustomText(
          text: 'Explore conteúdos incríveis sobre beleza e auto-cuidado.',
        ),
      ],
    );
  }
}
