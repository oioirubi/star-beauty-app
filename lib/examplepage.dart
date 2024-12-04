import 'package:flutter/material.dart';
import 'package:star_beauty_app/components/table_imput_field.dart';

class ExamplePage extends StatelessWidget {
  const ExamplePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Table(
        border: TableBorder.all(color: Colors.grey[300]!), // Borda da tabela
        columnWidths: const {
          0: FlexColumnWidth(1),
          1: FlexColumnWidth(3),
        },
        children: [
          TableRow(
            children: [
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text("Nome:"),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TableInputField(
                  labelText: "Digite o nome",
                  onChanged: (value) {
                    print("Nome: $value");
                  },
                ),
              ),
            ],
          ),
          TableRow(
            children: [
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text("Email:"),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TableInputField(
                  labelText: "Digite o email",
                  onChanged: (value) {
                    print("Email: $value");
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
