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

  /// Chamada ao iniciar o arrasto de um cartão
  void onItemPicked(String data) {
    setState(() {
      activeEditingCard = null; // Fecha qualquer edição aberta
    });
  }

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
    setState(() {
      activeEditingCard = null; // Fecha qualquer cartão em edição
      isAddingCard = false; // Cancela a adição de novos cartões
      forces.remove(''); // Remove cartões temporários
      weaknesses.remove('');
      opportunities.remove('');
      threats.remove('');
      focusNode.unfocus(); // Remove o foco atual
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: handleOutsideClick, // Fecha qualquer edição ao clicar fora
      behavior: HitTestBehavior.opaque, // Captura cliques em qualquer lugar
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
    return DragTarget<String>(
      onWillAccept: (data) => true, // Sempre aceita o cartão
      onAccept: (data) {
        // Move o cartão para o final da coluna
        List<List<String>> allBoards = [
          forces,
          weaknesses,
          opportunities,
          threats
        ];
        for (var sourceBoard in allBoards) {
          if (sourceBoard.contains(data)) {
            setState(() {
              sourceBoard.remove(data);
              board.add(data); // Adiciona o cartão ao final da coluna
            });
            break;
          }
        }
      },
      builder: (context, candidateData, rejectedData) {
        return CustomContainer.trelloBoard(
          title: title,
          height: 500,
          children: [
            for (int i = 0; i < board.length; i++) ...[
              DragTarget<String>(
                onWillAccept: (data) => true, // Sempre aceita o cartão
                onAccept: (data) {
                  // Move o cartão para esta posição na coluna
                  List<List<String>> allBoards = [
                    forces,
                    weaknesses,
                    opportunities,
                    threats
                  ];
                  for (var sourceBoard in allBoards) {
                    if (sourceBoard.contains(data)) {
                      setState(() {
                        sourceBoard.remove(data);
                        board.insert(i, data); // Insere na posição atual
                      });
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
              onWillAccept: (data) => true, // Sempre aceita o cartão
              onAccept: (data) {
                // Move o cartão para o final da coluna
                List<List<String>> allBoards = [
                  forces,
                  weaknesses,
                  opportunities,
                  threats
                ];
                for (var sourceBoard in allBoards) {
                  if (sourceBoard.contains(data)) {
                    setState(() {
                      sourceBoard.remove(data);
                      board.add(data);
                    });
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
      },
    );
  }

  Widget _buildEditableCard(List<String> board, int index, Color lineColor) {
    final TextEditingController controller =
        TextEditingController(text: board[index]);

    bool isLongPressActive = false; // Controle para clique longo

    return GestureDetector(
      onLongPress: () {
        setState(() {
          isLongPressActive = true; // Ativa o clique longo para arraste
        });
      },
      onTap: () {
        if (!isLongPressActive) {
          // Clique curto: abre a edição
          setState(() {
            activeEditingCard = board[index];
            focusNode.requestFocus();
          });
        }
        isLongPressActive = false; // Reseta o estado do clique longo
      },
      child: Focus(
        focusNode: focusNode,
        onFocusChange: (hasFocus) {
          if (!hasFocus && activeEditingCard == board[index]) {
            saveCard(board, index,
                controller.text); // Salva alterações ao perder o foco
          }
        },
        child: Draggable<String>(
          data: board[index],
          onDragStarted: () {
            if (isLongPressActive) {
              onItemPicked(board[index]); // Permite arrastar no clique longo
            }
          },
          feedback: Material(
            elevation: 6,
            child: Container(
              padding: const EdgeInsets.all(12.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    blurRadius: 4,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Text(
                board[index],
                style: const TextStyle(fontSize: 16.0, color: Colors.black87),
              ),
            ),
          ),
          childWhenDragging: Container(
            padding: const EdgeInsets.all(12.0),
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              board[index],
              style: const TextStyle(fontSize: 16.0, color: Colors.black54),
            ),
          ),
          child: CustomContainer.editableCard(
            key: ValueKey(board[index]),
            content: board[index],
            onUpdate: (newContent) => saveCard(board, index, newContent),
            lineColor: lineColor,
            isEditing: activeEditingCard == board[index],
          ),
        ),
      ),
    );
  }
}
