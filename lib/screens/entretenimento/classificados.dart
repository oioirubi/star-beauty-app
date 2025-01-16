import 'package:flutter/material.dart';

class Classificados extends StatefulWidget {
  final String userType;
  const Classificados({super.key, required this.userType});

  @override
  State<Classificados> createState() => _ClassificadosState();
}

class _ClassificadosState extends State<Classificados> {
  final List<Map<String, dynamic>> classifieds = [
    {
      'title': 'Corte de Cabelo Masculino',
      'description':
          'Serviço profissional de corte de cabelo masculino com atendimento personalizado.',
      'price': 50.00,
      'image': 'https://via.placeholder.com/100',
      'category': 'Manicure'
    },
    {
      'title': 'Casa para Aluguel',
      'description': 'Casa espaçosa com 3 quartos, ideal para famílias.',
      'price': 1200.00,
      'image': 'https://via.placeholder.com/100',
      'category': 'Proprietários'
    },
    {
      'title': 'Manicure Profissional',
      'description':
          'Manicure experiente com opções de design de unhas artísticas.',
      'price': 30.00,
      'image': 'https://via.placeholder.com/100',
      'category': 'Manicure'
    },
    {
      'title': 'Barbearia Completa',
      'description': 'Pacote de barbearia: corte, barba e massagem facial.',
      'price': 70.00,
      'image': 'https://via.placeholder.com/100',
      'category': 'Cabeleireiros'
    },
    {
      'title': 'Apartamento para Venda',
      'description': 'Apartamento novo, 2 quartos, ótima localização.',
      'price': 250000.00,
      'image': 'https://via.placeholder.com/100',
      'category': 'Proprietários'
    },
    {
      'title': 'Serviço de Alongamento de Unhas',
      'description':
          'Alongamento em gel, acrílico e outras técnicas avançadas.',
      'price': 80.00,
      'image': 'https://via.placeholder.com/100',
      'category': 'Manicure'
    },
  ];
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // User Information Section
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              CircleAvatar(
                radius: 30,
                backgroundImage:
                    NetworkImage('https://via.placeholder.com/150'),
              ),
              SizedBox(width: 16),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Olá, Usuário!',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    'Tipo: Professional',
                    style: TextStyle(color: Colors.grey),
                  ),
                ],
              ),
            ],
          ),
        ),

        // Category Filter
        Container(
          height: 50,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: [
              CategoryChip(label: 'Todos'),
              CategoryChip(label: 'Proprietários'),
              CategoryChip(label: 'Cabeleireiros'),
              CategoryChip(label: 'Manicure'),
            ],
          ),
        ),

        Container(
          child: ListView.builder(
            itemCount: classifieds.length,
            itemBuilder: (context, index) {
              final item = classifieds[index];
              return ClassifiedItem(
                title: item['title'],
                description: item['description'],
                price: item['price'],
                imageUrl: item['image'],
                category: item['category'],
              );
            },
          ),
        ),
      ],
    );
  }
}

class CategoryChip extends StatelessWidget {
  final String label;

  CategoryChip({required this.label});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: ActionChip(
        label: Text(label),
        onPressed: () {
          // Filter action
        },
      ),
    );
  }
}

class ClassifiedItem extends StatelessWidget {
  final String title;
  final String description;
  final double price;
  final String imageUrl;
  final String category;

  ClassifiedItem({
    required this.title,
    required this.description,
    required this.price,
    required this.imageUrl,
    required this.category,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            // Product Image
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.network(
                imageUrl,
                height: 80,
                width: 80,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(width: 16),
            // Product Info
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    description,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    'R\$ ${price.toStringAsFixed(2)}',
                    style: TextStyle(
                      color: Colors.green,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            // Contact Button
            IconButton(
              icon: Icon(Icons.chat_bubble_outline),
              onPressed: () {
                // Open chat
              },
            ),
          ],
        ),
      ),
    );
  }
}

