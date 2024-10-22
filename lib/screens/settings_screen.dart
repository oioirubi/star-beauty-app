import 'package:flutter/material.dart';

class SettingsScreen extends StatelessWidget {
  final ValueChanged<bool> onThemeChanged;

  const SettingsScreen({super.key, required this.onThemeChanged});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Configurações'),
      ),
      body: SwitchListTile(
        title: const Text('Modo Escuro'),
        value: Theme.of(context).brightness == Brightness.dark,
        onChanged: (value) {
          onThemeChanged(value);
        },
      ),
    );
  }
}
