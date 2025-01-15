import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:star_beauty_app/components/custom_container.dart';
import 'package:star_beauty_app/components/custom_text.dart';
import 'package:star_beauty_app/components/edit_button.dart';
import 'package:star_beauty_app/screens/gps_da_beleza/editable_table.dart';

class ActionPlanScreen extends StatefulWidget {
  const ActionPlanScreen({super.key, required String userType});

  @override
  _ActionPlanScreenState createState() => _ActionPlanScreenState();
}

class _ActionPlanScreenState extends State<ActionPlanScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  final TextEditingController objetivoController = TextEditingController();
  final TextEditingController faturamentoDesejadoController =
      TextEditingController();
  List<TextEditingController> valorControllers = [];
  List<TextEditingController> quantidadeControllers = [];
  List<double> resultados = [];
  late Future<void> _futureData;
  bool isEditing = false;

  @override
  void initState() {
    super.initState();
    _futureData = _loadData();
    // // Adicionar 4 linhas iniciais vazias
    // for (int i = 0; i < 4; i++) {
    //   valorControllers.add(TextEditingController());
    //   quantidadeControllers.add(TextEditingController());
    //   resultados.add(0.0);
    // }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _futureData,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Container();
        }
        return Padding(
          padding: const EdgeInsets.all(30.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 1080),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const CustomText(
                          text: "Plano de Ação",
                          isBigTitle: true,
                        ),
                        EditButton(
                          onEditStateChanged: (value) {
                            setState(() {
                              isEditing = value;
                            });
                          },
                          onSave: () {
                            _saveData();
                          },
                        ),
                      ],
                    ),
                    _buildSectionTextField(
                      'Objetivo do Mês',
                      objetivoController.text.isEmpty
                          ? 'Qual é o seu objetivo para esse mês?'
                          : objetivoController.text,
                      objetivoController,
                      editable: isEditing,
                    ),
                    const SizedBox(height: 16),
                    _buildSectionTextField(
                      'Faturamento Desejado',
                      faturamentoDesejadoController.text.isEmpty
                          ? 'Quanto você deseja faturar?'
                          : faturamentoDesejadoController.text,
                      faturamentoDesejadoController,
                      editable: isEditing,
                    ),
                    const SizedBox(height: 16),
                    _buildSectionEditableTable(
                        'Preencha a tabela com os seus serviços',
                        editable: isEditing),
                    const SizedBox(height: 16),
                    _buildSectionTextField('Total Previsto Geral',
                        _calculateTotal(), TextEditingController(),
                        editable: false),
                    // const SizedBox(height: 16),
                    // _buildSectionTextField(
                    //   'Painel dos Profissionais',
                    //   'Análise dos profissionais para este plano de ação',
                    //   submitButton: true,
                    //   buttonLabel: "Salvar Plano de Ação",
                    //   onPressed: () {
                    //     ScaffoldMessenger.of(context).showSnackBar(
                    //       const SnackBar(content: Text('Plano de Ação salvo com sucesso!')),
                    //     );
                    //   },
                    // ),
                    // const SizedBox(height: 16),
                    // _buildSectionTable(
                    //     'Não sabe por onde começar? Você pode usar essa tabela exemplo como referência:'),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildSectionTextField(
    String title,
    String hint,
    TextEditingController controller, {
    bool editable = true,
    bool submitButton = false,
    String buttonLabel = "Submit",
    Function()? onPressed,
  }) {
    return CustomContainer(
      contentPadding: const EdgeInsets.all(50),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSectionTitle(title),
          editable ? _buildTextField(hint, controller) : Text(hint),
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

  Widget _buildSectionEditableTable(String title, {bool editable = true}) {
    return CustomContainer(
      contentPadding: const EdgeInsets.all(50),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSectionTitle(title),
          EditableTable(
            editable: editable,
            valorControllers: this.valorControllers,
            quantidadeControllers: this.quantidadeControllers,
            resultados: this.resultados,
            onValueChanged: (valor, quantidade, resultados) {
              valorControllers = valor;
              quantidadeControllers = quantidade;
              this.resultados = resultados;
            },
          ),
        ],
      ),
    );
  }

  Widget _buildSectionTable(String title) {
    return CustomContainer(
      contentPadding: const EdgeInsets.all(50),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
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

  Widget _buildTextField(String hint, TextEditingController controller) {
    return TextField(
      controller: controller,
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
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(),
        ),
      ],
    );
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

  Future<void> _loadData() async {
    try {
      //verificar se o usuário é autenticado
      final user = _auth.currentUser;
      if (user == null) {
        throw Exception(
            "Usuário não autenticado"); //caso não, throw uma exception
      }

      final doc = await _firestore
          .collection('users')
          .doc(user.uid)
          .collection('plano_de_acao')
          .doc('current')
          .get();

      if (doc.exists) {
        final data = doc.data();
        setState(() {
          objetivoController.text = data?['objetivo'] ?? '';
          faturamentoDesejadoController.text =
              data?['faturamentoDesejado'] ?? '';
          final tableData = data?['tableData'] ?? [];

          valorControllers = [];
          quantidadeControllers = [];
          resultados = [];

          for (int i = 0; i < tableData.length; i++) {
            valorControllers
                .add(TextEditingController(text: tableData[i]['valor'] ?? ''));
            quantidadeControllers.add(
                TextEditingController(text: tableData[i]['quantidade'] ?? ''));
            resultados.add(double.tryParse(tableData[i]['valor']) ?? 0.0);
          }
        });
      }
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Plano de ação carregado com sucesso!')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Erro ao carregar o plano de ação: $e')),
      );
    }
  }

  Future<void> _saveData() async {
    try {
      final user = _auth.currentUser;
      if (user == null) {
        throw Exception(
            "Usuário não autenticado"); //caso não, throw uma exception
      }

      //preparando tabela
      List<Map<String, dynamic>> tableData = [];
      for (int i = 0; i < valorControllers.length; i++) {
        tableData.add({
          'valor': valorControllers[i].text,
          'quantidade': quantidadeControllers[i].text,
          'reultado': resultados[i],
        });
      }

      await _firestore
          .collection('users')
          .doc(user.uid)
          .collection('plano_de_acao')
          .doc('current')
          .set({
        'objetivo': objetivoController.text,
        'faturamentoDesejado': faturamentoDesejadoController.text,
        'tableData': tableData,
        'updatedAt': FieldValue.serverTimestamp(),
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Plano de ação salvo com sucesso!')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Erro ao salvar plano: $e')),
      );
    }
  }
}
