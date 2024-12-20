import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:star_beauty_app/components/custom_base_screen.dart';
import 'package:star_beauty_app/components/custom_container.dart';
import 'package:star_beauty_app/components/custom_text.dart';

class AnaliseSWOTPage extends StatelessWidget {
  const AnaliseSWOTPage({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> swotItems = [
      {
        'title': 'Forças',
        'image': 'assets/images/forcas.jpg',
        'route': '/forcas',
      },
      {
        'title': 'Fraquezas',
        'image': 'assets/images/fraquezas.jpg',
        'route': '/fraquezas',
      },
      {
        'title': 'Oportunidades',
        'image': 'assets/images/oportunidades.jpg',
        'route': '/oportunidades',
      },
      {
        'title': 'Ameaças',
        'image': 'assets/images/ameacas.jpg',
        'route': '/ameacas',
      },
    ];

    return CustomizableBaseScreen(
      userName: "Usuário",
      userPhotoUrl: null,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const CustomText(
              text: "Análise SWOT",
              isBigTitle: true,
              textColor: Colors.black87,
            ),
            const SizedBox(height: 16),
            Expanded(
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                ),
                itemCount: swotItems.length,
                itemBuilder: (context, index) {
                  final item = swotItems[index];
                  return CustomContainer.category(
                    backgroundImage: item['image'],
                    title: item['title'],
                    onTap: () => context.go(item['route']),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
