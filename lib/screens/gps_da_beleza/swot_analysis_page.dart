import 'package:flutter/material.dart';
import 'package:star_beauty_app/components/custom_container.dart';

class SwotAnalysisPage extends StatefulWidget {
  const SwotAnalysisPage({super.key});

  @override
  _SwotAnalysisPageState createState() => _SwotAnalysisPageState();
}

class _SwotAnalysisPageState extends State<SwotAnalysisPage> {
  final List<String> forces = ['Tarefa 1', 'Tarefa 2'];
  final List<String> weaknesses = ['Tarefa 3'];
  final List<String> opportunities = [];
  final List<String> threats = [];

  String? activeEditingCard;
  String? activeEditingColumn;
  bool isAddingCard = false;

  final FocusNode focusNode = FocusNode();

  /// Move um cartão entre colunas
  void onItemDropped(
      String data, List<String> targetBoard, List<String> sourceBoard) {
    setState(() {
      if (sourceBoard.contains(data)) {
        sourceBoard.remove(data); // Remove da coluna de origem
      }
      targetBoard.add(data); // Adiciona à nova coluna
    });
  }

  /// Adiciona um novo cartão
  void addNewCard(List<String> targetBoard) {
    if (isAddingCard) return;
    setState(() {
      isAddingCard = true;
      targetBoard.add('');
      activeEditingCard = '';
    });
  }

  /// Cancela um novo cartão
  void cancelNewCard(List<String> targetBoard) {
    setState(() {
      isAddingCard = false;
      targetBoard.remove('');
      activeEditingCard = null;
    });
  }

  /// Salva ou descarta edições
  void saveCard(List<String> targetBoard, int index, String newContent) {
    setState(() {
      if (newContent.trim().isEmpty) {
        targetBoard.removeAt(index);
      } else {
        targetBoard[index] = newContent.trim();
      }
      activeEditingCard = null;
      isAddingCard = false;
    });
  }

  /// Salva ou descarta com clique fora
  void handleOutsideClick() {
    if (activeEditingCard != null || isAddingCard) {
      setState(() {
        activeEditingCard = null;
        isAddingCard = false;
        forces.remove('');
        weaknesses.remove('');
        opportunities.remove('');
        threats.remove('');
      });
    }
    focusNode.unfocus();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: handleOutsideClick,
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(child: _buildBoard('Forças', forces, Colors.blue)),
                  const SizedBox(width: 16),
                  Expanded(
                      child:
                          _buildBoard('Fraquezas', weaknesses, Colors.orange)),
                ],
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                      child: _buildBoard(
                          'Oportunidades', opportunities, Colors.green)),
                  const SizedBox(width: 16),
                  Expanded(child: _buildBoard('Ameaças', threats, Colors.red)),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBoard(String title, List<String> board, Color lineColor) {
    return CustomContainer.trelloBoard(
      title: title,
      height: 500,
      children: [
        for (int i = 0; i < board.length; i++) ...[
          DragTarget<String>(
            onWillAccept: (data) => true,
            onAccept: (data) {
              // Detecta a origem e move o item
              List<List<String>> allBoards = [
                forces,
                weaknesses,
                opportunities,
                threats
              ];
              for (var sourceBoard in allBoards) {
                if (sourceBoard.contains(data)) {
                  onItemDropped(data, board, sourceBoard);
                  break;
                }
              }
            },
            builder: (context, candidateData, rejectedData) {
              return AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                height: candidateData.isNotEmpty ? 30 : 0,
                margin: const EdgeInsets.symmetric(vertical: 4),
                decoration: BoxDecoration(
                  color: candidateData.isNotEmpty
                      ? Colors.grey[300]
                      : Colors.transparent,
                  borderRadius: BorderRadius.circular(4),
                ),
              );
            },
          ),
          _buildEditableCard(board, i, lineColor),
        ],
        DragTarget<String>(
          onWillAccept: (data) => true,
          onAccept: (data) {
            List<List<String>> allBoards = [
              forces,
              weaknesses,
              opportunities,
              threats
            ];
            for (var sourceBoard in allBoards) {
              if (sourceBoard.contains(data)) {
                onItemDropped(data, board, sourceBoard);
                break;
              }
            }
          },
          builder: (context, candidateData, rejectedData) {
            return AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              height: candidateData.isNotEmpty ? 30 : 0,
              margin: const EdgeInsets.symmetric(vertical: 4),
              decoration: BoxDecoration(
                color: candidateData.isNotEmpty
                    ? Colors.grey[300]
                    : Colors.transparent,
                borderRadius: BorderRadius.circular(4),
              ),
            );
          },
        ),
        GestureDetector(
          onTap: () {
            handleOutsideClick();
            addNewCard(board);
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 4.0),
            child: Container(
              padding: const EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Text(
                '+ Adicionar cartão',
                style: TextStyle(
                  fontSize: 16.0,
                  color: Colors.blue,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildEditableCard(List<String> board, int index, Color lineColor) {
    final TextEditingController controller =
        TextEditingController(text: board[index]);

    return GestureDetector(
      onTap: () {
        setState(() {
          activeEditingCard = board[index];
          focusNode.requestFocus();
        });
      },
      child: Focus(
        focusNode: focusNode,
        onFocusChange: (hasFocus) {
          if (!hasFocus && activeEditingCard == board[index]) {
            saveCard(board, index, controller.text);
          }
        },
        child: CustomContainer.editableCard(
          key: ValueKey(board[index]),
          content: board[index],
          onUpdate: (newContent) => saveCard(board, index, newContent),
          lineColor: lineColor,
          isEditing: activeEditingCard == board[index],
        ),
      ),
    );
  }
}
