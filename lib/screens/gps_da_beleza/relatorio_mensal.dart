import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:star_beauty_app/components/custom_container.dart';
import 'package:star_beauty_app/components/custom_text.dart';

class MonthlyReportScreen extends StatefulWidget {
  const MonthlyReportScreen({super.key});

  @override
  _MonthlyReportScreenState createState() => _MonthlyReportScreenState();
}

final List<String> months = [
  "Janeiro",
  "Fevereiro",
  "Março",
  "Abril",
  "Maio",
  "Junho",
  "Julho",
  "Agosto",
  "Setembro",
  "Outubro",
  "Novembro",
  "Dezembro"
];
final List<int> years = [2023, 2024, 2025, 2026];

String selectedMonth = "Janeiro";
bool isEditing = false;

final ScrollController _scrollController = ScrollController();

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

  num _calculateSum(List<TextEditingController> controllers) {
    return controllers.fold<num>(
      0,
      (previousValue, controller) =>
          previousValue + (num.tryParse(controller.text) ?? 0),
    );
  }

  final List<int> years = [2023, 2024, 2025, 2026];
  int selectedYear = 2025;
  OverlayEntry? _overlayEntry;

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
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(50.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(height: 20),
          ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 1080),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //Título e ano
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        const CustomText(
                          text: "Relatório Mensal",
                          isBigTitle: true,
                        ),
                        const SizedBox(width: 16),
                        Row(
                          children: [
                            IconButton(
                              icon: const Icon(Icons.arrow_left),
                              onPressed: () {
                                setState(() {
                                  int currentIndex =
                                      years.indexOf(selectedYear);
                                  if (currentIndex > 0) {
                                    selectedYear = years[currentIndex - 1];
                                  }
                                });
                              },
                            ),
                            Text(
                              "$selectedYear",
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            IconButton(
                              icon: const Icon(Icons.arrow_right),
                              onPressed: () {
                                setState(() {
                                  int currentIndex =
                                      years.indexOf(selectedYear);
                                  if (currentIndex < years.length - 1) {
                                    selectedYear = years[currentIndex + 1];
                                  }
                                });
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
                //Seleção dos meses
                Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.arrow_left),
                      onPressed: () {
                        _scrollController.animateTo(
                          _scrollController.offset -
                              100, // Ajuste para o scroll para a esquerda
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.easeInOut,
                        );
                      },
                    ),
                    Expanded(
                      child: SingleChildScrollView(
                        controller: _scrollController,
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: months.map((month) {
                            return GestureDetector(
                              onTap: () {
                                setState(() {
                                  selectedMonth = month;
                                });
                              },
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 8.0, horizontal: 16.0),
                                margin: const EdgeInsets.only(right: 8.0),
                                decoration: BoxDecoration(
                                  color: selectedMonth == month
                                      ? Colors.purple[100]
                                      : Colors.white,
                                  border: Border.all(
                                    color: selectedMonth == month
                                        ? Colors.purple
                                        : Colors.grey,
                                  ),
                                  borderRadius: BorderRadius.circular(16.0),
                                ),
                                child: Text(
                                  month,
                                  style: TextStyle(
                                    color: selectedMonth == month
                                        ? Colors.purple
                                        : Colors.black,
                                    fontWeight: selectedMonth == month
                                        ? FontWeight.bold
                                        : FontWeight.normal,
                                  ),
                                ),
                              ),
                            );
                          }).toList(),
                        ),
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.arrow_right),
                      onPressed: () {
                        _scrollController.animateTo(
                          _scrollController.offset +
                              100, // Ajuste para o scroll para a direita
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.easeInOut,
                        );
                      },
                    ),
                  ],
                ),
                const SizedBox(height: 32),

                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
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
                                // Opcional: Restaurar valores originais
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
                                // Atualiza os valores no estado
                                final despesasFixasTotal = _calculateSum([
                                  aluguelController,
                                  funcionarioController,
                                  aguaController,
                                  luzController,
                                  contadorController,
                                  internetController,
                                ]);

                                final despesasVariaveisTotal = _calculateSum([
                                  comissaoController,
                                  mercadoController,
                                  manutencaoController,
                                ]);

                                final resultado =
                                    despesasFixasTotal + despesasVariaveisTotal;

                                // Atualiza os controladores com os valores recalculados
                                resultadoController.text =
                                    resultado.toStringAsFixed(2);

                                isEditing = false;

                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content:
                                        Text("Alterações salvas com sucesso!"),
                                    duration: Duration(seconds: 2),
                                  ),
                                );
                              });
                            },
                            child: const Text("Salvar"),
                          ),
                        ],
                      ),
                  ],
                ),

                const SizedBox(height: 20),

// Seção de Faturamento
                _buildSection(
                  title: "Faturamento",
                  fields: [
                    const Divider(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const CustomText(text: "Total", isTitle: true),
                        CustomText(
                          text: "R\$ ${_calculateSum([
                                TextEditingController(text: "2000"),
                                TextEditingController(text: "1500"),
                                TextEditingController(text: "1000"),
                                TextEditingController(text: "500"),
                                TextEditingController(text: "1000"),
                              ])}",
                          isTitle: true,
                        ),
                      ],
                    ),
                    const Divider(),
                    _buildExpenseCategory(
                      title: "Por área de negócio",
                      controllers: [
                        {"Cabelo": TextEditingController(text: "2000")},
                        {"Manicure": TextEditingController(text: "1500")},
                        {"Estética": TextEditingController(text: "1000")},
                        {"Maquiagem": TextEditingController(text: "500")},
                        {"Depilação": TextEditingController(text: "1000")},
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 20),

// Seção de Serviços Realizados
                _buildSection(
                  title: "Serviços Realizados",
                  fields: [
                    const Divider(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const CustomText(text: "Total", isTitle: true),
                        CustomText(
                          text: "R\$ ${_calculateSum([
                                TextEditingController(text: "50"),
                                TextEditingController(text: "40"),
                                TextEditingController(text: "30"),
                                TextEditingController(text: "20"),
                                TextEditingController(text: "10"),
                              ])}",
                          isTitle: true,
                        ),
                      ],
                    ),
                    const Divider(),
                    _buildExpenseCategory(
                      title: "Por área de negócio",
                      controllers: [
                        {"Cabelo": TextEditingController(text: "50")},
                        {"Manicure": TextEditingController(text: "40")},
                        {"Estética": TextEditingController(text: "30")},
                        {"Maquiagem": TextEditingController(text: "20")},
                        {"Depilação": TextEditingController(text: "10")},
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 20),

// Seção de Despesas
                _buildSection(
                  title: "Despesas",
                  fields: [
                    const Divider(),
                    _buildExpenseCategory(
                      title: "Fixas",
                      controllers: [
                        {"Aluguel": aluguelController},
                        {"Funcionário": funcionarioController},
                        {"Água": aguaController},
                        {"Luz": luzController},
                        {"Contador": contadorController},
                        {"Internet": internetController},
                      ],
                    ),
                    const Divider(),
                    _buildExpenseCategory(
                      title: "Variáveis",
                      controllers: [
                        {"Comissão": comissaoController},
                        {"Mercado": mercadoController},
                        {"Manutenção": manutencaoController},
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 20),

// Seção de Resultado
                _buildSection(
                  title: "Resultado",
                  fields: [
                    const Divider(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const CustomText(text: "Lucratividade", isTitle: true),
                        CustomText(
                          text: "R\$ ${resultadoController.text}",
                          isTitle: true,
                        ),
                      ],
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

  Widget _buildSection({required String title, required List<Widget> fields}) {
    return CustomContainer(
      contentPadding: const EdgeInsets.all(50.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomText(
            text: title,
            isTitle: true,
          ),
          const SizedBox(height: 16),
          ...fields,
        ],
      ),
    );
  }

  Widget _buildRowField({
    required String title,
    required TextEditingController controller,
    bool isEditing = false,
  }) {
    return Row(
      children: [
        CustomText(
          text: "$title:",
        ),
        const SizedBox(width: 8),
        Flexible(
          child: TextField(
            controller: controller,
            readOnly: !isEditing,
            keyboardType: TextInputType.number,
            inputFormatters: [
              FilteringTextInputFormatter.digitsOnly,
            ],
            decoration: InputDecoration(
              prefixText: "R\$ ",
              border: isEditing ? const OutlineInputBorder() : InputBorder.none,
              hintText: "Insira o valor",
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildExpenseCategory({
    required String title,
    required List<Map<String, TextEditingController>> controllers,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomText(
          text: title,
          isTitle: true,
        ),
        const SizedBox(height: 8),
        Wrap(
          spacing: 16.0,
          runSpacing: 8.0,
          children: controllers.map((item) {
            String label = item.keys.first;
            TextEditingController controller = item.values.first;
            return SizedBox(
              width: 200,
              child: _buildRowField(
                title: label,
                controller: controller,
                isEditing: isEditing,
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}
