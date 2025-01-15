import 'package:flutter/material.dart';
import 'package:star_beauty_app/components/custom_text.dart';

class Profile {
  String name;
  String description;
  String type;
  String image;

  Profile({required this.name, required this.description, required this.type, required this.image});
}

class BuscaEMatch extends StatefulWidget {
  final String userType;

  const BuscaEMatch({super.key, required this.userType});

  @override
  _BuscaEMatchState createState() => _BuscaEMatchState();
}

class _BuscaEMatchState extends State<BuscaEMatch> {
  final List<Profile> profiles = [
    Profile(name: 'Proprietário 1', description: 'Salão de Beleza', type: 'owner', image: 'https://i.pinimg.com/736x/0d/0e/93/0d0e939d220bf6fe27d34f2cc8d0cd95.jpg'),
    Profile(name: 'Proprietário 2', description: 'Barbearia', type: 'owner', image: 'https://i.pinimg.com/736x/0d/0e/93/0d0e939d220bf6fe27d34f2cc8d0cd95.jpg'),
    Profile(name: 'Proprietário 3', description: 'Spa', type: 'owner', image: 'https://i.pinimg.com/736x/0d/0e/93/0d0e939d220bf6fe27d34f2cc8d0cd95.jpg'),
    Profile(name: 'Proprietário 4', description: 'Salão de Beleza', type: 'owner', image: 'https://i.pinimg.com/736x/0d/0e/93/0d0e939d220bf6fe27d34f2cc8d0cd95.jpg'),

  ];

  List<Profile> filteredProfiles = [];
  String? selectedCategory = 'Todos';
  String? selectedType;
  List<String> categories = ['Todos', 'Salão de Beleza', 'Barbearia', 'Spa'];
  List<String> types = ['Todos', 'owner', 'professional'];
  bool isFilterExpanded = false;

  @override
  void initState() {
    super.initState();
    filteredProfiles = profiles;
  }

  void applyFilters() {
    setState(() {
      filteredProfiles = profiles.where((profile) {
        final categoryMatches = selectedCategory == null || selectedCategory == 'Todos'
            ? true
            : profile.description == selectedCategory;
        final typeMatches = selectedType == null || selectedType == 'Todos'
            ? true
            : profile.type == selectedType;
        return categoryMatches && typeMatches;
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    // Obtendo a largura da tela
    double screenWidth = MediaQuery.of(context).size.width;

    int columns = 2; // Default para 2 colunas
    if (screenWidth >= 600) {
      columns = 3; // 3 colunas para telas maiores
    } else if (screenWidth >= 400) {
      columns = 2; // 2 colunas para telas médias
    } else {
      columns = 1; // 1 coluna para telas pequenas
    }

    // Definindo o childAspectRatio de forma dinâmica
    double childAspectRatio = screenWidth > 600 ? 1.0 : 0.8; // Ajusta a proporção com base na largura da tela

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        CustomText(
          text: 'Meus Matchs',
          isTitle: true, // Será formatado como título
        ),
        CustomText(
          text: 'Explore conteúdos incríveis sobre beleza e auto-cuidado.',
        ),
        SizedBox(height: 20),
        // Botão de Filtro
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: () {
              setState(() {
                isFilterExpanded = !isFilterExpanded;
              });
            },
            child: Text(isFilterExpanded ? 'Fechar Filtros' : 'Abrir Filtros'),
          ),
        ),
        if (isFilterExpanded)
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: Column(
              children: [
                DropdownButtonFormField<String>(
                  value: selectedCategory,
                  items: categories
                      .map((category) => DropdownMenuItem(
                    value: category,
                    child: Text(category),
                  ))
                      .toList(),
                  onChanged: (value) {
                    setState(() {
                      selectedCategory = value!;
                    });
                    applyFilters();
                  },
                  decoration: const InputDecoration(labelText: 'Categoria'),
                ),
                const SizedBox(height: 16),
                DropdownButtonFormField<String>(
                  value: selectedType,
                  items: types
                      .map((type) => DropdownMenuItem(
                    value: type,
                    child: Text(type),
                  ))
                      .toList(),
                  onChanged: (value) {
                    setState(() {
                      selectedType = value!;
                    });
                    applyFilters();
                  },
                  decoration: const InputDecoration(labelText: 'Tipo'),
                ),
              ],
            ),
          ),
        const SizedBox(height: 16),
        // Lista de Perfis
        filteredProfiles.isEmpty
            ? const Center(child: Text('Nenhum perfil encontrado.'))
            : Container(
          child: GridView.builder(
            shrinkWrap: true, // Evita quebra de layout
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: columns, // Usando a variável `columns` para definir a quantidade de colunas
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
              childAspectRatio: childAspectRatio, // Proporção do card ajustada dinamicamente
            ),
            itemCount: filteredProfiles.length,
            itemBuilder: (context, index) {
              final profile = filteredProfiles[index];
              return ProfileCard(profile: profile);
            },
          ),
        ),
      ],
    );
  }
}

class ProfileCard extends StatelessWidget {
  final Profile profile;

  const ProfileCard({super.key, required this.profile});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Foto de Perfil
            CircleAvatar(
              radius: 24,
              backgroundImage: NetworkImage(profile.image), // Usando NetworkImage para imagens da web
            ),
            SizedBox(height: 8),
            Text(
              profile.name,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(profile.description),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(profile.type),
                IconButton(
                  icon: const Icon(Icons.favorite_border),
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Você gostou de ${profile.name}'),
                      ),
                    );
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
