import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:star_beauty_app/components/custom_container.dart';

class SwotAnalysisPage extends StatefulWidget {
  const SwotAnalysisPage({super.key});

  @override
  _SwotAnalysisPageState createState() => _SwotAnalysisPageState();
}

class _SwotAnalysisPageState extends State<SwotAnalysisPage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  List<String> forces = ['Tarefa 1', 'Tarefa 2'];
  List<String> weaknesses = ['Tarefa 3'];
  List<String> opportunities = [];
  List<String> threats = [];

  String? activeEditingCard;
  String? activeEditingColumn;
  bool isAddingCard = false;

  final FocusNode focusNode = FocusNode();

  late Future _futureData;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _futureData = _loadData();
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
    _saveData();
  }

  /// Adiciona um novo cartão
  void addNewCard(List<String> targetBoard) {
    if (isAddingCard) return;
    setState(() {
      isAddingCard = true;
      targetBoard.add('');
      activeEditingCard = '';
    });
    _saveData();
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
    _saveData();
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
    return FutureBuilder(
      future: _futureData,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Container();
        }
        return GestureDetector(
          onTap: handleOutsideClick,
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                          child: _buildBoard('Forças', forces, Colors.blue)),
                      const SizedBox(width: 16),
                      Expanded(
                          child: _buildBoard(
                              'Fraquezas', weaknesses, Colors.orange)),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(
                          child: _buildBoard(
                              'Oportunidades', opportunities, Colors.green)),
                      const SizedBox(width: 16),
                      Expanded(
                          child: _buildBoard('Ameaças', threats, Colors.red)),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildBoard(String title, List<String> board, Color lineColor) {
    return CustomContainer.trelloBoard(
      title: title,
      height: 500,
      children: [
        for (int i = 0; i < board.length; i++) ...[
          DragTarget<String>(
            onWillAcceptWithDetails: (data) => true,
            onAcceptWithDetails: (data) {
              // Detecta a origem e move o item
              List<List<String>> allBoards = [
                forces,
                weaknesses,
                opportunities,
                threats
              ];
              for (var sourceBoard in allBoards) {
                if (sourceBoard.contains(data)) {
                  onItemDropped(data as String, board, sourceBoard);
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
          onWillAcceptWithDetails: (data) => true,
          onAcceptWithDetails: (data) {
            List<List<String>> allBoards = [
              forces,
              weaknesses,
              opportunities,
              threats
            ];
            for (var sourceBoard in allBoards) {
              if (sourceBoard.contains(data)) {
                onItemDropped(data as String, board, sourceBoard);
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
          .collection('swot')
          .doc('current')
          .get();
      if (doc.exists) {
        final data = doc.data();
        setState(() {
          forces = getStringList(data?['forces']);
          weaknesses = getStringList(data?['weaknesses']);
          opportunities = getStringList(data?['opportunities']);
          threats = getStringList(data?['threats']);
        });
      }
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('swot carregado com sucesso!')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Erro ao carregar o swot: $e')),
      );
    }
  }

  List<String> getStringList(dynamic data) {
    if (data == null) return [];
    if (data is! List) return [];
    return data.map((e) => e?.toString() ?? '').toList();
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
          .collection('swot')
          .doc('current')
          .set({
        "forces": forces,
        "weaknesses": weaknesses,
        "opportunities": opportunities,
        "threats": threats
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('swot salvo com sucesso!')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Erro ao salvar swot: $e')),
      );
    }
  }
}
