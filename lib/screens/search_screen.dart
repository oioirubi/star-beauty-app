import 'package:flutter/material.dart';

class SearchScreen extends StatefulWidget {
  final String userType;
  final String userId;

  const SearchScreen({super.key, required this.userType, required this.userId});

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  String? _selectedService;
  double _distance = 10.0;

  void _performSearch() {
    // Implemente a lógica de busca com base nos filtros
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Busca e Match'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            DropdownButtonFormField<String>(
              value: _selectedService,
              hint: const Text('Selecione o tipo de serviço'),
              items: <String>['Cabeleireiro', 'Manicure', 'Depilador']
                  .map((service) {
                return DropdownMenuItem<String>(
                  value: service,
                  child: Text(service),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  _selectedService = value;
                });
              },
            ),
            Slider(
              value: _distance,
              min: 1,
              max: 50,
              divisions: 49,
              label: 'Distância: $_distance km',
              onChanged: (value) {
                setState(() {
                  _distance = value;
                });
              },
            ),
            ElevatedButton(
              onPressed: _performSearch,
              child: const Text('Buscar'),
            ),
          ],
        ),
      ),
    );
  }
}
