import 'package:flutter/material.dart';

class ObjectivesPanel extends StatefulWidget {
  const ObjectivesPanel({super.key, required String userType});

  @override
  _ObjectivesPanelState createState() => _ObjectivesPanelState();
}

class _ObjectivesPanelState extends State<ObjectivesPanel> {
  List<String> objectives = [
    'Aumentar o faturamento em 20%',
    'Conquistar 10 novos clientes',
    'Reduzir despesas em 5%',
    'Aumentar a retenção de clientes'
  ];

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
            _buildObjectiveCard(context, objectives[0]),
            const SizedBox(height: 16),
            _buildSectionTitle('Objetivos Específicos'),
            ...objectives.sublist(1).map((objective) {
              return _buildObjectiveCard(context, objective);
            }),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
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
      style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
    );
  }

  Widget _buildObjectiveCard(BuildContext context, String objective) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      child: ListTile(
        title: Text(objective),
        trailing: IconButton(
          icon: const Icon(Icons.edit),
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
          title: const Text('Adicionar Novo Objetivo'),
          content: TextField(
            onChanged: (value) {
              newObjective = value;
            },
            decoration:
                const InputDecoration(hintText: "Insira o novo objetivo"),
          ),
          actions: <Widget>[
            ElevatedButton(
              child: const Text('Cancelar'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            ElevatedButton(
              child: const Text('Adicionar'),
              onPressed: () {
                if (newObjective.isNotEmpty) {
                  setState(() {
                    objectives.add(newObjective);
                  });
                  Navigator.of(context).pop();
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                        content: Text('Objetivo "$newObjective" adicionado!')),
                  );
                }
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
          title: const Text('Editar Objetivo'),
          content: TextField(
            controller: controller,
            decoration: const InputDecoration(hintText: "Edite o objetivo"),
          ),
          actions: <Widget>[
            ElevatedButton(
              child: const Text('Cancelar'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            ElevatedButton(
              child: const Text('Salvar'),
              onPressed: () {
                setState(() {
                  int index = objectives.indexOf(objective);
                  if (index != -1) {
                    objectives[index] = controller.text;
                  }
                });
                Navigator.of(context).pop();
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                      content: Text(
                          'Objetivo atualizado para "${controller.text}"!')),
                );
              },
            ),
          ],
        );
      },
    );
  }
}
