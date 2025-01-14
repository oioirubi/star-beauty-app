import 'package:flutter/material.dart';

class EditButton extends StatefulWidget {
  final Function? onSave;
  final Function? onCancel;
  final Function(bool)? onEditStateChanged;

  EditButton({
    super.key,
    this.onSave,
    this.onCancel,
    this.onEditStateChanged,
  });

  @override
  State<EditButton> createState() => _EditButtonState();
}

class _EditButtonState extends State<EditButton> {
  bool isEditing = false;
  @override
  Widget build(BuildContext context) {
    return !isEditing
        ? ElevatedButton(
            onPressed: () {
              _changeState(true);
            },
            child: const Text("Editar"),
          )
        : Row(
            children: [
              TextButton(
                onPressed: () {
                  _changeState(false);
                  widget.onCancel?.call();
                },
                child: const Text(
                  "Cancelar",
                  style: TextStyle(color: Colors.grey),
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  _changeState(false);
                  widget.onSave?.call();
                  // Salvar lógica aqui
                },
                child: const Text("Salvar"),
              ),
            ],
          );
  }

  void _changeState(bool value) {
    setState(() {
      isEditing = value;
    });
    widget.onEditStateChanged?.call(isEditing);
  }

  get isEditting {
    return isEditing;
  }
}
