import 'package:flutter/material.dart';

class TableInputField extends StatelessWidget {
  final String labelText; // Texto que aparece inicialmente (placeholder)
  final TextEditingController? controller; // Controlador (opcional)
  final Function(String)? onChanged; // Callback para mudanças (opcional)

  const TableInputField({
    super.key,
    required this.labelText,
    this.controller,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      onChanged: onChanged,
      style: const TextStyle(
        fontSize: 14, // Tamanho do texto
        color: Colors.black, // Cor do texto
      ),
      decoration: InputDecoration(
        labelText: labelText,
        labelStyle: const TextStyle(
          fontSize: 14, // Tamanho do texto do label
          color: Colors.grey, // Cor do label
        ),
        border: InputBorder.none, // Sem borda
        enabledBorder: InputBorder.none, // Sem borda ao estar habilitado
        focusedBorder: InputBorder.none, // Sem borda ao focar
        contentPadding:
            const EdgeInsets.symmetric(vertical: 4), // Ajuste interno
      ),
    );
  }
}
