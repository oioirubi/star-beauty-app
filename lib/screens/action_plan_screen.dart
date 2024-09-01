import 'package:flutter/material.dart';

class ActionPlanScreen extends StatefulWidget {
  const ActionPlanScreen({Key? key, required String userType})
      : super(key: key);

  @override
  _ActionPlanScreenState createState() => _ActionPlanScreenState();
}

class _ActionPlanScreenState extends State<ActionPlanScreen> {
  List<TableRow> editableRows = [];

  @override
  void initState() {
    super.initState();
    // Adiciona uma linha inicial vazia
    editableRows.add(_buildEditableTableRow());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Plano de Ação'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSectionTitle('Objetivo do Mês'),
            _buildTextField('Escreva o objetivo principal do mês'),
            const SizedBox(height: 16),
            _buildSectionTitle('Faturamento Desejado'),
            _buildTextField('Digite o faturamento desejado'),
            const SizedBox(height: 16),
            _buildSectionTitle(
                'Número de Serviços por Área de Negócio (Exemplo)'),
            _buildExampleTable(),
            const SizedBox(height: 16),
            _buildSectionTitle('Preencha sua própria tabela de serviços'),
            _buildEditableServiceTable(),
            const SizedBox(height: 8),
            Align(
              alignment: Alignment.centerLeft,
              child: TextButton.icon(
                onPressed: () {
                  setState(() {
                    editableRows.add(_buildEditableTableRow());
                  });
                },
                icon: const Icon(Icons.add),
                label: const Text('Adicionar Linha'),
              ),
            ),
            const SizedBox(height: 16),
            _buildSectionTitle('Total Previsto Geral'),
            _buildDataCard(
                'R\$ 14.200'), // Esse valor pode ser calculado automaticamente com base nos serviços
            const SizedBox(height: 16),
            _buildSectionTitle('Painel dos Profissionais'),
            _buildTextField(
                'Análise dos profissionais para este plano de ação'),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                // Lógica para salvar o plano de ação
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                      content: Text('Plano de Ação salvo com sucesso!')),
                );
              },
              child: const Text('Salvar Plano de Ação'),
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

  Widget _buildTextField(String hint) {
    return TextField(
      decoration: InputDecoration(
        border: const OutlineInputBorder(),
        hintText: hint,
      ),
      maxLines: 2,
    );
  }

  Widget _buildExampleTable() {
    return Table(
      border: TableBorder.all(),
      children: [
        _buildTableRow('Serviço', 'Valor', 'Quantidade', 'Resultado'),
        _buildTableRow('Mechas', 'R\$ 320', '8', 'R\$ 2.560'),
        _buildTableRow('Corte', 'R\$ 60', '40', 'R\$ 2.400'),
        _buildTableRow('Coloração', 'R\$ 90', '20', 'R\$ 1.800'),
        _buildTableRow('Tratamentos / Hidratação', 'R\$ 40', '28', 'R\$ 1.120'),
        _buildTableRow('Escova', 'R\$ 40', '80', 'R\$ 3.200'),
        _buildTableRow('Progressiva / Botox', 'R\$ 120', '8', 'R\$ 960'),
        _buildTableRow('Penteado', 'R\$ 90', '8', 'R\$ 720'),
        _buildTableRow('Reconstrução', 'R\$ 120', '12', 'R\$ 1.440'),
        _buildTableRow('Total', '', '204', 'R\$ 14.200'),
      ],
    );
  }

  Widget _buildEditableServiceTable() {
    return Table(
      border: TableBorder.all(),
      children: [
        _buildTableRow('Serviço', 'Valor', 'Quantidade', 'Resultado'),
        ...editableRows,
      ],
    );
  }

  TableRow _buildTableRow(
      String service, String value, String quantity, String result) {
    return TableRow(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(service),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(value),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(quantity),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(result),
        ),
      ],
    );
  }

  TableRow _buildEditableTableRow() {
    return TableRow(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextField(
            decoration: const InputDecoration(hintText: 'Serviço'),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextField(
            decoration: const InputDecoration(hintText: 'Valor'),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextField(
            decoration: const InputDecoration(hintText: 'Quantidade'),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextField(
            decoration: const InputDecoration(hintText: 'Resultado'),
          ),
        ),
      ],
    );
  }

  Widget _buildDataCard(String data) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      child: ListTile(
        title: Text(data),
      ),
    );
  }
}
