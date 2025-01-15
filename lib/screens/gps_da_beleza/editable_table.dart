import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class EditableTable extends StatefulWidget {
  List<TextEditingController> servicoControllers = [];
  List<TextEditingController> valorControllers = [];
  List<TextEditingController> quantidadeControllers = [];
  List<double> resultados = [];
  final bool editable;
  final Function(
    List<TextEditingController> servicoControllers,
    List<TextEditingController> valorControllers,
    List<TextEditingController> quantidadeControllers,
    List<double> resultados,
  )? onValueChanged;

  EditableTable({
    super.key,
    this.onValueChanged,
    this.editable = true,
    this.servicoControllers = const [],
    this.valorControllers = const [],
    this.quantidadeControllers = const [],
    this.resultados = const [],
  });
  @override
  State<EditableTable> createState() => _EditableTableState();
}

class _EditableTableState extends State<EditableTable> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildTable(),
        const SizedBox(height: 8),
        Align(
          alignment: Alignment.centerLeft,
          child: widget.editable
              ? TextButton.icon(
                  onPressed: () {
                    addNewRow();
                  },
                  icon: const Icon(Icons.add),
                  label: const Text('Adicionar Linha'),
                )
              : Container(),
        ),
      ],
    );
  }

  Table _buildTable() {
    return Table(
      children: [
        _buildTableRow('Serviço', 'Valor', 'Quantidade', 'Resultado'),
        for (int i = 0; i < widget.valorControllers.length; i++)
          _buildEditableTableRow(i, editable: widget.editable),
      ],
    );
  }

  TableRow _buildTableRow(
      String service, String value, String quantity, String result) {
    return TableRow(
      children: [
        createCell(Text(service)),
        createCell(Text(value)),
        createCell(Text(quantity)),
        createCell(Text(result)),
        createCell(Container(), hasBorder: false),
      ],
    );
  }

  Widget createCell(Widget child, {bool hasBorder = true}) {
    return Container(
      height: 50,
      width: 100,
      alignment: AlignmentDirectional.topStart,
      decoration: BoxDecoration(border: hasBorder ? Border.all() : Border()),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: child,
      ),
    );
  }

  TableRow _buildEditableTableRow(int index, {bool editable = true}) {
    if (widget.valorControllers.isEmpty) {
      addNewRow();
    }
    return TableRow(
      children: [
        createCell(
          editable
              ? TextField(
                  controller: widget.servicoControllers[index],
                  decoration: const InputDecoration(
                    hintText: 'Serviço',
                    border: InputBorder.none, // Remover borda
                    filled: false, // Remover cor de fundo
                  ),
                  onChanged: (value) {
                    widget.onValueChanged?.call(
                      widget.servicoControllers,
                      widget.valorControllers,
                      widget.quantidadeControllers,
                      widget.resultados,
                    ); // Chama o
                  },
                )
              : Center(
                  child: Text(widget.servicoControllers[index].text.isEmpty
                      ? "Serviços"
                      : widget.servicoControllers[index].text),
                ),
        ),
        createCell(
          editable
              ? TextField(
                  controller: widget.valorControllers[index],
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
                    setState(() {
                      _updateResult(index);
                    });
                    widget.onValueChanged?.call(
                      widget.servicoControllers,
                      widget.valorControllers,
                      widget.quantidadeControllers,
                      widget.resultados,
                    );
                  },
                )
              : Center(
                  child: Text(widget.valorControllers[index].text.isEmpty
                      ? "Valor"
                      : widget.valorControllers[index].text),
                ),
        ),
        createCell(
          editable
              ? TextField(
                  controller: widget.quantidadeControllers[index],
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
                    setState(() {
                      _updateResult(index);
                    });
                    widget.onValueChanged?.call(
                      widget.servicoControllers,
                      widget.valorControllers,
                      widget.quantidadeControllers,
                      widget.resultados,
                    );
                  },
                )
              : Center(
                  child: Text(
                    widget.quantidadeControllers[index].text.isEmpty
                        ? "Quantidade"
                        : widget.quantidadeControllers[index].text,
                  ),
                ),
        ),
        createCell(
          Center(
            child: Text(
              widget.resultados[index].toStringAsFixed(2),
              style: const TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        editable
            ? createCell(
                IconButton(
                    onPressed: () {
                      removeRow(index);
                    },
                    icon: const Icon(
                      Icons.remove,
                      color: Colors.red,
                    )),
                hasBorder: false)
            : Container(),
      ],
    );
  }

  void removeRow(int index) {
    setState(() {
      if (widget.valorControllers.length > 1) {
        widget.servicoControllers.remove(index);
        widget.valorControllers.removeAt(index);
        widget.quantidadeControllers.removeAt(index);
        widget.resultados.removeAt(index);
      }
    });
  }

  void addNewRow() {
    setState(() {
      widget.servicoControllers.add(TextEditingController());
      widget.valorControllers.add(TextEditingController());
      widget.quantidadeControllers.add(TextEditingController());
      widget.resultados.add(0.0);
    });
  }

  void _updateResult(int index) {
    final valor = double.tryParse(widget.valorControllers[index].text) ?? 0.0;
    final quantidade =
        double.tryParse(widget.quantidadeControllers[index].text) ?? 0.0;
    setState(() {
      widget.resultados[index] = valor * quantidade;
    });
  }

  get resultados {
    return widget.resultados;
  }

  get valorControllers {
    return widget.valorControllers;
  }

  get quantidadeControllers {
    return widget.quantidadeControllers;
  }

  set resultados(value) {
    widget.resultados = value;
  }

  set valorControllers(value) {
    widget.valorControllers = value;
  }

  set quantidadeControllers(value) {
    widget.quantidadeControllers = value;
  }
}
