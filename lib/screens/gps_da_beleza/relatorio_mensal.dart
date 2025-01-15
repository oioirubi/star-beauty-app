import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:star_beauty_app/components/custom_container.dart';
import 'package:star_beauty_app/components/custom_text.dart';

class MonthlyReportScreen extends StatefulWidget {
  const MonthlyReportScreen({super.key});

  @override
  _MonthlyReportScreenState createState() => _MonthlyReportScreenState();
}

class _MonthlyReportScreenState extends State<MonthlyReportScreen> {
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

  bool isEditing = false;

  @override
  void initState() {
    super.initState();
    faturamentoTotalController.text = "10000";
    faturamentoAreasController.text = "4000";
    servicosTotalController.text = "150";
    servicosAreasController.text = "50";

    aluguelController.text = "2000";
    funcionarioController.text = "3000";
    aguaController.text = "200";
    luzController.text = "300";
    contadorController.text = "500";
    internetController.text = "100";

    comissaoController.text = "500";
    mercadoController.text = "700";
    manutencaoController.text = "400";

    resultadoController.text = "3000";
  }

  @override
  Widget build(BuildContext context) {
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
                    if (!isEditing)
                      ElevatedButton(
                        onPressed: () {
                          setState(() {
                            isEditing = true;
                          });
                        },
                        child: const Text("Editar"),
                      )
                    else
                      Row(
                        children: [
                          TextButton(
                            onPressed: () {
                              setState(() {
                                isEditing = false;
                              });
                            },
                            child: const Text(
                              "Cancelar",
                              style: TextStyle(color: Colors.grey),
                            ),
                          ),
                          ElevatedButton(
                            onPressed: () {
                              setState(() {
                                isEditing = false;
                              });
                              // Salvar lógica aqui
                            },
                            child: const Text("Salvar"),
                          ),
                        ],
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
}
