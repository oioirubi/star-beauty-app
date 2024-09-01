import 'package:flutter/material.dart';

class ObjectivesPanel extends StatelessWidget {
  const ObjectivesPanel({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Painel de Objetivos'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSectionTitle('Objetivo do Mês'),
            _buildObjectiveCard(context, 'Aumentar o faturamento em 20%'),
            const SizedBox(height: 16),
            _buildSectionTitle('Objetivos Específicos'),
            _buildObjectiveCard(context, 'Conquistar 10 novos clientes'),
            _buildObjectiveCard(context, 'Reduzir despesas em 5%'),
            _buildObjectiveCard(context, 'Aumentar a retenção de clientes'),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                // Lógica para adicionar novo objetivo
                _showAddObjectiveDialog(context);
              },
              child: const Text('Adicionar Novo Objetivo'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
    );
  }

  Widget _buildObjectiveCard(BuildContext context, String objective) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      child: ListTile(
        title: Text(objective),
        trailing: IconButton(
          icon: Icon(Icons.edit),
          onPressed: () {
            _showEditObjectiveDialog(context, objective);
          },
        ),
      ),
    );
  }

  void _showAddObjectiveDialog(BuildContext context) {
    String newObjective = '';
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Adicionar Novo Objetivo'),
          content: TextField(
            onChanged: (value) {
              newObjective = value;
            },
            decoration: InputDecoration(hintText: "Insira o novo objetivo"),
          ),
          actions: <Widget>[
            ElevatedButton(
              child: Text('Cancelar'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            ElevatedButton(
              child: Text('Adicionar'),
              onPressed: () {
                // Lógica para adicionar o objetivo
                Navigator.of(context).pop();
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                      content: Text('Objetivo "$newObjective" adicionado!')),
                );
              },
            ),
          ],
        );
      },
    );
  }

  void _showEditObjectiveDialog(BuildContext context, String objective) {
    TextEditingController controller = TextEditingController(text: objective);
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Editar Objetivo'),
          content: TextField(
            controller: controller,
            onChanged: (value) {
              objective = value;
            },
            decoration: InputDecoration(hintText: "Edite o objetivo"),
          ),
          actions: <Widget>[
            ElevatedButton(
              child: Text('Cancelar'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            ElevatedButton(
              child: Text('Salvar'),
              onPressed: () {
                // Lógica para salvar o objetivo editado
                Navigator.of(context).pop();
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                      content: Text('Objetivo atualizado para "$objective"!')),
                );
              },
            ),
          ],
        );
      },
    );
  }
}
