import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:star_beauty_app/components/custom_container.dart';

class ActionPlanScreen extends StatefulWidget {
  const ActionPlanScreen({super.key, required String userType});

  @override
  _ActionPlanScreenState createState() => _ActionPlanScreenState();
}

class _ActionPlanScreenState extends State<ActionPlanScreen> {
  List<TextEditingController> valorControllers = [];
  List<TextEditingController> quantidadeControllers = [];
  List<double> resultados = [];

  @override
  void initState() {
    super.initState();
    // Adicionar 4 linhas iniciais vazias
    for (int i = 0; i < 4; i++) {
      valorControllers.add(TextEditingController());
      quantidadeControllers.add(TextEditingController());
      resultados.add(0.0);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionTextField(
            'Objetivo do Mês', 'Qual é o seu objetivo para esse mês?'),
        const SizedBox(height: 16),
        _buildSectionTextField(
            'Faturamento Desejado', 'Quanto você deseja faturar?'),
        const SizedBox(height: 16),
        _buildSectionEditableTable('Preencha a tabela com os seus serviços'),
        const SizedBox(height: 16),
        CustomContainer(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildSectionTitle('Total Previsto Geral'),
              _buildDataCard(_calculateTotal()),
            ],
          ),
        ),
        const SizedBox(height: 16),
        _buildSectionTextField(
          'Painel dos Profissionais',
          'Análise dos profissionais para este plano de ação',
          submitButton: true,
          buttonLabel: "Salvar Plano de Ação",
          onPressed: () {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Plano de Ação salvo com sucesso!')),
            );
          },
        ),
        const SizedBox(height: 16),
        _buildSectionEditableTable(
            'Não sabe por onde começar? Você pode usar essa tabela exemplo como referência:'),
      ],
    );
  }

  Widget _buildSectionTextField(
    String title,
    String hint, {
    bool submitButton = false,
    String buttonLabel = "Submit",
    Function()? onPressed,
  }) {
    return CustomContainer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSectionTitle(title),
          _buildTextField(hint),
          const SizedBox(height: 8),
          submitButton
              ? ElevatedButton(
                  onPressed: onPressed,
                  child: Text(buttonLabel),
                )
              : Container()
        ],
      ),
    );
  }

  Widget _buildSectionEditableTable(String title) {
    return CustomContainer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSectionTitle(title),
          _buildEditableServiceTable(),
          const SizedBox(height: 8),
          Align(
            alignment: Alignment.centerLeft,
            child: TextButton.icon(
              onPressed: () {
                setState(() {
                  valorControllers.add(TextEditingController());
                  quantidadeControllers.add(TextEditingController());
                  resultados.add(0.0);
                });
              },
              icon: const Icon(Icons.add),
              label: const Text('Adicionar Linha'),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionTable(String title) {
    return CustomContainer(
      child: Column(
        children: [
          _buildSectionTitle(title),
          _buildExampleTable(),
        ],
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

  Widget _buildNumberField(String hint) {
    return TextField(
      decoration: InputDecoration(
        border: const OutlineInputBorder(),
        hintText: hint,
        prefixText: 'R\$ ',
      ),
      keyboardType: TextInputType.number,
      inputFormatters: <TextInputFormatter>[
        FilteringTextInputFormatter.digitsOnly, // Apenas números
      ],
    );
  }

  Widget _buildEditableServiceTable() {
    return Table(
      border: TableBorder.all(),
      children: [
        _buildTableRow('Serviço', 'Valor', 'Quantidade', 'Resultado'),
        for (int i = 0; i < valorControllers.length; i++)
          _buildEditableTableRow(i),
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

  TableRow _buildEditableTableRow(int index) {
    return TableRow(
      children: [
        const Padding(
          padding: EdgeInsets.all(8.0),
          child: TextField(
            decoration: InputDecoration(
              hintText: 'Serviço',
              border: InputBorder.none, // Remover borda
              filled: false, // Remover cor de fundo
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextField(
            controller: valorControllers[index],
            decoration: const InputDecoration(
              hintText: 'Valor',
              prefixText: 'R\$ ',
              border: InputBorder.none, // Remover borda
              filled: false, // Remover cor de fundo
            ),
            keyboardType: TextInputType.number,
            inputFormatters: <TextInputFormatter>[
              FilteringTextInputFormatter.digitsOnly, // Apenas números
            ],
            onChanged: (value) {
              _updateResult(
                  index); // Chama o método de atualização em tempo real
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextField(
            controller: quantidadeControllers[index],
            decoration: const InputDecoration(
              hintText: 'Quantidade',
              border: InputBorder.none, // Remover borda
              filled: false, // Remover cor de fundo
            ),
            keyboardType: TextInputType.number,
            inputFormatters: <TextInputFormatter>[
              FilteringTextInputFormatter.digitsOnly, // Apenas números
            ],
            onChanged: (value) {
              _updateResult(
                  index); // Chama o método de atualização em tempo real
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Card(
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                resultados[index].toStringAsFixed(2),
                style: const TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  void _updateResult(int index) {
    final valor = double.tryParse(valorControllers[index].text) ?? 0.0;
    final quantidade =
        double.tryParse(quantidadeControllers[index].text) ?? 0.0;
    setState(() {
      resultados[index] = valor * quantidade;
    });
  }

  String _calculateTotal() {
    double total = resultados.fold(0, (sum, result) => sum + result);
    return 'R\$ ${total.toStringAsFixed(2)}';
  }

  Widget _buildDataCard(String data) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      child: ListTile(
        title: Text(
          data,
          style: const TextStyle(
            fontSize: 16.0,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
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
}
