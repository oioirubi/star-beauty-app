import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class EditableTable extends StatefulWidget {
  List<TextEditingController> valorControllers = [];
  List<TextEditingController> quantidadeControllers = [];
  List<double> resultados = [];
  final bool editable;
  final Function(
    List<TextEditingController> valorControllers,
    List<TextEditingController> quantidadeControllers,
    List<double> resultados,
  )? onValueChanged;

  EditableTable({
    super.key,
    this.onValueChanged,
    this.editable = true,
    this.valorControllers = const [],
    this.quantidadeControllers = const [],
    this.resultados = const [],
  });
  @override
  State<EditableTable> createState() => _EditableTableState();
}

class _EditableTableState extends State<EditableTable> {
  List<TextEditingController> _valorControllers = [];
  List<TextEditingController> _quantidadeControllers = [];
  List<double> _resultados = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _valorControllers = widget.valorControllers;
    _quantidadeControllers = widget.quantidadeControllers;
    _resultados = widget.resultados;
    if (_valorControllers.isEmpty) {
      addNewRow();
    }
  }

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
        for (int i = 0; i < _valorControllers.length; i++)
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
    return TableRow(
      children: [
        createCell(
          editable
              ? const TextField(
                  decoration: InputDecoration(
                    hintText: 'Serviço',
                    border: InputBorder.none, // Remover borda
                    filled: false, // Remover cor de fundo
                  ),
                )
              : Center(child: const Text('Serviço')),
        ),
        createCell(
          editable
              ? TextField(
                  controller: _valorControllers[index],
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
                        valorControllers,
                        quantidadeControllers,
                        resultados); // Chama o método de atualização em tempo real
                  },
                )
              : Center(
                  child: Text(_valorControllers[index].text.isEmpty
                      ? "Valor"
                      : _valorControllers[index].text),
                ),
        ),
        createCell(
          editable
              ? TextField(
                  controller: _quantidadeControllers[index],
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
                        valorControllers,
                        quantidadeControllers,
                        resultados); // Chama o método de atualização em tempo real
                  },
                )
              : Center(
                  child: Text(
                    _quantidadeControllers[index].text.isEmpty
                        ? "Quantidade"
                        : _quantidadeControllers[index].text,
                  ),
                ),
        ),
        createCell(
          Center(
            child: Text(
              _resultados[index].toStringAsFixed(2),
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
      if (_valorControllers.length > 1) {
        _valorControllers.removeAt(index);
        _quantidadeControllers.removeAt(index);
        _resultados.removeAt(index);
      }
    });
  }

  void addNewRow() {
    setState(() {
      _valorControllers.add(TextEditingController());
      _quantidadeControllers.add(TextEditingController());
      _resultados.add(0.0);
    });
  }

  void _updateResult(int index) {
    final valor = double.tryParse(_valorControllers[index].text) ?? 0.0;
    final quantidade =
        double.tryParse(_quantidadeControllers[index].text) ?? 0.0;
    setState(() {
      _resultados[index] = valor * quantidade;
    });
  }

  get resultados {
    return _resultados;
  }

  get valorControllers {
    return _valorControllers;
  }

  get quantidadeControllers {
    return _quantidadeControllers;
  }

  set resultados(value) {
    _resultados = value;
  }

  set valorControllers(value) {
    _valorControllers = value;
  }

  set quantidadeControllers(value) {
    _quantidadeControllers = value;
  }
}
