import 'package:flutter/material.dart';

class MatchListagem extends StatefulWidget {
  final String userType; // 'professional' ou 'owner'

  const MatchListagem({super.key, required this.userType});

  @override
  _MatchScreenState createState() => _MatchScreenState();
}

class _MatchScreenState extends State<MatchListagem> {
  // Lista de perfis de exemplo
  final List<Map<String, String>> profiles = [
    {
      'name': 'Proprietário 1',
      'description': 'Salão de Beleza',
      'type': 'owner'
    },
    {'name': 'Proprietário 2', 'description': 'Barbearia', 'type': 'owner'},
    {
      'name': 'Profissional 1',
      'description': 'Cabelereiro',
      'type': 'professional'
    },
    {
      'name': 'Profissional 2',
      'description': 'Manicure',
      'type': 'professional'
    },
  ];

  List<Map<String, String>> filteredProfiles = [];

  int _currentIndex = 0;
  String _selectedService = 'Todos';
  double _maxDistance = 50;

  @override
  void initState() {
    super.initState();
    _filterProfiles();
  }

  void _filterProfiles() {
    setState(() {
      filteredProfiles = profiles.where((profile) {
        if (widget.userType == 'professional' && profile['type'] == 'owner') {
          return _selectedService == 'Todos' ||
              profile['description'] == _selectedService;
        } else if (widget.userType == 'owner' &&
            profile['type'] == 'professional') {
          return _selectedService == 'Todos' ||
              profile['description'] == _selectedService;
        }
        return false;
      }).toList();
    });
  }

  void _nextProfile() {
    setState(() {
      _currentIndex = (_currentIndex + 1) % filteredProfiles.length;
    });
  }

  void _matchProfile() {
    // Lógica de match aqui
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
          content: Text(
              'Você deu match com ${filteredProfiles[_currentIndex]['name']}!')),
    );
    _nextProfile();
  }

  @override
  Widget build(BuildContext context) {
    final profile =
        filteredProfiles.isNotEmpty ? filteredProfiles[_currentIndex] : null;

    return Scaffold(
      appBar: AppBar(
        title: Text(
            'Buscar ${widget.userType == 'professional' ? 'Proprietários' : 'Profissionais'}'),
      ),
      body: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: DropdownButtonFormField<String>(
                    value: _selectedService,
                    items: ['Todos', 'Cabelereiro', 'Manicure', 'Depilador']
                        .map((service) => DropdownMenuItem(
                              value: service,
                              child: Text(service),
                            ))
                        .toList(),
                    onChanged: (value) {
                      setState(() {
                        _selectedService = value!;
                        _filterProfiles();
                      });
                    },
                    decoration: const InputDecoration(
                      labelText: 'Serviço',
                    ),
                  ),
                ),
                const SizedBox(width: 20),
                Expanded(
                  child: Slider(
                    value: _maxDistance,
                    min: 0,
                    max: 100,
                    divisions: 20,
                    label: 'Distância máxima (${_maxDistance.round()} km)',
                    onChanged: (value) {
                      setState(() {
                        _maxDistance = value;
                      });
                    },
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: profile == null
                ? const Center(child: Text('Nenhum perfil encontrado.'))
                : Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        profile['name']!,
                        style: const TextStyle(fontSize: 24),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        profile['description']!,
                        style: const TextStyle(fontSize: 18),
                      ),
                      const SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          ElevatedButton(
                            onPressed: _nextProfile,
                            child: const Text('Pular'),
                          ),
                          const SizedBox(width: 20),
                          ElevatedButton(
                            onPressed: _matchProfile,
                            child: const Text('Match'),
                          ),
                        ],
                      ),
                    ],
                  ),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              // Lógica para exibir todos os perfis em uma lista
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      ProfileListScreen(profiles: filteredProfiles),
                ),
              );
            },
            child: const Text('Ver Todos'),
          ),
        ],
      ),
    );
  }
}

class ProfileListScreen extends StatelessWidget {
  final List<Map<String, String>> profiles;

  const ProfileListScreen({super.key, required this.profiles});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Todos os Perfis'),
      ),
      body: ListView.builder(
        itemCount: profiles.length,
        itemBuilder: (context, index) {
          final profile = profiles[index];
          return ListTile(
            title: Text(profile['name']!),
            subtitle: Text(profile['description']!),
          );
        },
      ),
    );
  }
}
