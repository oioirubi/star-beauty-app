import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:star_beauty_app/components/custom_container.dart';
import 'package:star_beauty_app/components/custom_text.dart';
import 'package:star_beauty_app/components/edit_button.dart';

class MonthlyReportScreen extends StatefulWidget {
  const MonthlyReportScreen({super.key});

  @override
  _MonthlyReportScreenState createState() => _MonthlyReportScreenState();
}

class _MonthlyReportScreenState extends State<MonthlyReportScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  final TextEditingController faturamentoTotalController =
      TextEditingController();
  final TextEditingController faturamentoAreasController =
      TextEditingController();
  final TextEditingController servicosTotalController = TextEditingController();
  final TextEditingController servicosAreasController = TextEditingController();

  // Controllers para despesas fixas
  final TextEditingController aluguelController = TextEditingController();
  final TextEditingController funcionarioController = TextEditingController();
  final TextEditingController aguaController = TextEditingController();
  final TextEditingController luzController = TextEditingController();
  final TextEditingController contadorController = TextEditingController();
  final TextEditingController internetController = TextEditingController();

  // Controllers para despesas variáveis
  final TextEditingController comissaoController = TextEditingController();
  final TextEditingController mercadoController = TextEditingController();
  final TextEditingController manutencaoController = TextEditingController();

  final TextEditingController resultadoController = TextEditingController();

  late Future<void> _futureData;

  bool isEditing = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _futureData = _loadData();
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
                        CustomText(
                          text: "Relatório Mensal",
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
                    const SizedBox(height: 20),
                    _buildSection(
                      bigTitle: "Faturamento",
                      fields: [
                        _buildCurrencyField(
                          title: "Total",
                          controller: faturamentoTotalController,
                          isEditing: isEditing,
                        ),
                        _buildCurrencyField(
                          title: "Por área de negócio",
                          controller: faturamentoAreasController,
                          isEditing: isEditing,
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    _buildSection(
                      bigTitle: "Serviços Realizados",
                      fields: [
                        _buildNumericField(
                          title: "Total",
                          controller: servicosTotalController,
                          isEditing: isEditing,
                        ),
                        _buildNumericField(
                          title: "Por área de negócio",
                          controller: servicosAreasController,
                          isEditing: isEditing,
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    _buildSection(
                      bigTitle: "Despesas",
                      fields: [
                        CustomText(text: "Fixas", isTitle: true),
                        _buildCurrencyField(
                          title: "Aluguel do espaço",
                          controller: aluguelController,
                          isEditing: isEditing,
                        ),
                        _buildCurrencyField(
                          title: "Funcionário CLT",
                          controller: funcionarioController,
                          isEditing: isEditing,
                        ),
                        _buildCurrencyField(
                          title: "Água",
                          controller: aguaController,
                          isEditing: isEditing,
                        ),
                        _buildCurrencyField(
                          title: "Luz",
                          controller: luzController,
                          isEditing: isEditing,
                        ),
                        _buildCurrencyField(
                          title: "Contador",
                          controller: contadorController,
                          isEditing: isEditing,
                        ),
                        _buildCurrencyField(
                          title: "Internet",
                          controller: internetController,
                          isEditing: isEditing,
                        ),
                        const SizedBox(height: 20),
                        CustomText(text: "Variáveis", isTitle: true),
                        _buildCurrencyField(
                          title: "Comissão de profissional",
                          controller: comissaoController,
                          isEditing: isEditing,
                        ),
                        _buildCurrencyField(
                          title: "Mercado",
                          controller: mercadoController,
                          isEditing: isEditing,
                        ),
                        _buildCurrencyField(
                          title: "Manutenção",
                          controller: manutencaoController,
                          isEditing: isEditing,
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    _buildSection(
                      bigTitle: "Resultado",
                      fields: [
                        _buildCurrencyField(
                          title: "Lucratividade (despesas x entradas)",
                          controller: resultadoController,
                          isEditing: isEditing,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildSection(
      {required String bigTitle, required List<Widget> fields}) {
    return CustomContainer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomText(
            text: bigTitle,
            isBigTitle: true, // Ajuste para título grande
          ),
          const SizedBox(height: 20),
          ...fields,
        ],
      ),
      contentPadding: const EdgeInsets.all(50.0),
    );
  }

  Widget _buildCurrencyField({
    required String title,
    required TextEditingController controller,
    bool isEditing = false,
  }) {
    return _buildEditableField(
      title: title,
      controller: controller,
      isEditing: isEditing,
      inputFormatters: [
        FilteringTextInputFormatter.digitsOnly,
      ],
      prefixText: "R\$ ",
    );
  }

  Widget _buildNumericField({
    required String title,
    required TextEditingController controller,
    bool isEditing = false,
  }) {
    return _buildEditableField(
      title: title,
      controller: controller,
      isEditing: isEditing,
      inputFormatters: [
        FilteringTextInputFormatter.digitsOnly,
      ],
    );
  }

  Widget _buildEditableField({
    required String title,
    required TextEditingController controller,
    bool isEditing = false,
    List<TextInputFormatter>? inputFormatters,
    String? prefixText,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomText(
          text: title,
          isTitle: true,
        ),
        const SizedBox(height: 4),
        TextField(
          controller: controller,
          readOnly: !isEditing,
          keyboardType: TextInputType.number,
          inputFormatters: inputFormatters,
          decoration: InputDecoration(
            prefixText: prefixText,
            border: isEditing ? const OutlineInputBorder() : InputBorder.none,
            hintText: "Insira $title",
          ),
        ),
        const SizedBox(height: 16),
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
          .collection('relatorio_mensal')
          .doc('current')
          .get();

      if (doc.exists) {
        final data = doc.data();
        setState(() {
          faturamentoTotalController.text = data?['faturamentoTotal'] ?? '';
          faturamentoAreasController.text = data?['faturamentoAreas'] ?? '';
          servicosAreasController.text = data?['servicosAreas'] ?? '';
          // Controllers para despesas fixa.text = data?['']??'';
          aluguelController.text = data?['aluguel'] ?? '';
          funcionarioController.text = data?['funcionario'] ?? '';
          aguaController.text = data?['agua'] ?? '';
          luzController.text = data?['luz'] ?? '';
          contadorController.text = data?['contador'] ?? '';
          internetController.text = data?['internet'] ?? '';
          // Controllers para despesas vari.text = data?[]??'';veis
          comissaoController.text = data?['comissao'] ?? '';
          mercadoController.text = data?['mercado'] ?? '';
          manutencaoController.text = data?['manutencao'] ?? '';
          resultadoController.text = data?['resultado'] ?? '';
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

      await _firestore
          .collection('users')
          .doc(user.uid)
          .collection('relatorio_mensal')
          .doc('current')
          .set({
        'faturamentoTotal': faturamentoTotalController.text,
        'faturamentoAreas': faturamentoAreasController.text,
        'servicosTotal': servicosTotalController.text,
        'servicosAreas': servicosAreasController.text,
        // Controllers para despesas fixa.text,
        'aluguel': aluguelController.text,
        'funcionario': funcionarioController.text,
        'agua': aguaController.text,
        'luz': luzController.text,
        'contador': contadorController.text,
        'internet': internetController.text,
        // Controllers para despesas variávei.text,
        'comissao': comissaoController.text,
        'mercado': mercadoController.text,
        'manutencao': manutencaoController.text,
        'resultado': resultadoController.text,
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
