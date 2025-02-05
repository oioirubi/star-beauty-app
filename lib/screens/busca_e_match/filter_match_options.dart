import 'package:flutter/material.dart';

class FilterMatchOptions extends StatefulWidget {
  final List<String> categories = [
    'Todos',
    'Salão de Beleza',
    'Barbearia',
    'Spa'
  ];
  final List<String> types = [
    'Todos',
    'owner',
    'professional',
  ];
  final Function(String type) onSelectedType;
  final Function(String category) onSelectedCategory;

  FilterMatchOptions(
      {super.key,
      required this.onSelectedType,
      required this.onSelectedCategory});
  @override
  State<FilterMatchOptions> createState() => _FilterMatchOptionsState();
}

class _FilterMatchOptionsState extends State<FilterMatchOptions> {
  @override
  Widget build(BuildContext context) {
    return _buildFilterOptions(
        onSelectedType: widget.onSelectedType,
        onSelectedCategory: widget.onSelectedCategory);
  }

  String selectedCategory = 'Todos';
  String selectedType = 'Todos';
  bool isFilterExpanded = false;

  _buildFilterOptions(
      {Function(String type)? onSelectedType,
      Function(String category)? onSelectedCategory}) {
    return Column(children: [
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
                items: widget.categories
                    .map((category) => DropdownMenuItem(
                          value: category,
                          child: Text(category),
                        ))
                    .toList(),
                onChanged: (v) {
                  onSelectedCategory?.call(v ?? '');
                },
                decoration: const InputDecoration(labelText: 'Categoria'),
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField<String>(
                value: selectedType,
                items: widget.types
                    .map((type) => DropdownMenuItem(
                          value: type,
                          child: Text(type),
                        ))
                    .toList(),
                onChanged: (v) {
                  onSelectedType?.call(v ?? '');
                },
                decoration: const InputDecoration(labelText: 'Tipo'),
              ),
            ],
          ),
        ),
    ]);
  }
}
