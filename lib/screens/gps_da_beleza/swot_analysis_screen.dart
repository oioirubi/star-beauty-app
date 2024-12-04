import 'package:flutter/material.dart';
import 'package:star_beauty_app/components/custom_container.dart';

class AnaliseSWOT extends StatefulWidget {
  const AnaliseSWOT({super.key});

  @override
  _AnaliseSWOTState createState() => _AnaliseSWOTState();
}

class _AnaliseSWOTState extends State<AnaliseSWOT> {
  final Map<String, List<Map<String, String>>> _quadrants = {
    'Pontos Fortes': [
      {'title': 'Ponto Forte', 'description': 'Descrição do cartão'}
    ],
    'Pontos Fracos': [
      {'title': 'Ponto Fraco', 'description': 'Descrição do cartão'}
    ],
    'Oportunidades': [
      {'title': 'Oportunidade', 'description': 'Descrição do cartão'}
    ],
    'Ameaças': [
      {'title': 'Ameaça', 'description': 'Descrição do cartão'}
    ],
  };

  final Map<String, GlobalKey> _quadrantKeys = {
    'Pontos Fortes': GlobalKey(),
    'Pontos Fracos': GlobalKey(),
    'Oportunidades': GlobalKey(),
    'Ameaças': GlobalKey(),
  };

  final Map<Map<String, String>, GlobalKey> _cardKeys = {};

  String? _editingQuadrant;
  Map<String, String>? _editingCard;

  void _addCard(String quadrant) {
    setState(() {
      _quadrants[quadrant]?.add({'title': 'Novo cartão', 'description': ''});
    });
  }

  void _editCard(String quadrant, Map<String, String> card) {
    setState(() {
      _editingQuadrant = quadrant;
      _editingCard = Map<String, String>.from(card);
    });
  }

  void _saveCard() {
    if (_editingQuadrant != null && _editingCard != null) {
      setState(() {
        final cards = _quadrants[_editingQuadrant]!;
        final index = cards.indexWhere((c) => c == _editingCard);
        if (index != -1) {
          cards[index] = _editingCard!;
        }
        _editingQuadrant = null;
        _editingCard = null;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Análise SWOT: Entenda e melhore o seu negócio',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  'A análise SWOT é uma ferramenta simples e poderosa que ajuda você a entender melhor o seu negócio e o mercado ao seu redor. Com ela, você pode identificar seus pontos fortes (Strengths), fraquezas (Weaknesses), oportunidades (Opportunities) e ameaças (Threats).',
                  style: TextStyle(fontSize: 16),
                ),
                const SizedBox(height: 16),
                Expanded(
                  child: GridView.count(
                    crossAxisCount: 2, // Dois quadrantes por linha
                    crossAxisSpacing: 8,
                    mainAxisSpacing: 8,
                    children: _quadrants.entries.map((entry) {
                      final title = entry.key;
                      final cards = entry.value;
                      return _buildQuadrant(title, cards);
                    }).toList(),
                  ),
                ),
                const SizedBox(height: 16),
                /*const Text(
                  'Como Funciona?',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  'A análise é organizada em quatro quadrantes. Cada quadrante representa um aspecto importante do seu negócio. Aqui está o que você deve preencher em cada um: \n\n1 - Pontos Fortes (Strengths): \nListe as coisas que você faz bem ou que diferenciam você ou seu negócio dos concorrentes. \n     Exemplo: "Tenho muitos clientes fiéis" ou "Ofereço serviços únicos na minha região." \n\n2 - Fraquezas (Weaknesses): \nEscreva os pontos que você acha que pode melhorar ou que dificultam o crescimento do seu negócio. \n     Exemplo: "Pouca divulgação nas redes sociais" ou "Não tenho uma equipe fixa." \n\n3 - Oportunidades (Opportunities): \nPense nas tendências ou situações que podem ajudar seu negócio a crescer. \n     Exemplo: "Aumento na busca por tratamentos estéticos" ou "Feiras de beleza na minha cidade." \n\n4 - nAmeaças (Threats): \nIdentifique os desafios ou riscos externos que podem impactar o seu negócio. \n     Exemplo: "Concorrência de novos salões" ou "Redução da demanda em épocas de crise."',
                  style: TextStyle(fontSize: 16),
                ),
                const SizedBox(height: 16),*/
                ElevatedButton(
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                          content: Text('Análise SWOT salva com sucesso!')),
                    );
                  },
                  child: const Text('Salvar'),
                ),
              ],
            ),
          ),
          if (_editingCard != null) _buildEditCardOverlay(),
        ],
      ),
    );
  }

  Widget _buildCard(Map<String, String> card) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: CustomContainer(
        borderRadius: 8.0, // Bordas arredondadas
        elevation: 2.0, // Intensidade da sombra
        backgroundColor: Colors.white, // Cor de fundo do card
        content: '', // Deixe vazio, já que usaremos o `child`
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              card['title'] ?? '',
              style: const TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8.0), // Espaço entre título e descrição
            Text(
              card['description'] ?? '',
              style: const TextStyle(
                fontSize: 14.0,
                color: Colors.grey,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildQuadrant(String title, List<Map<String, String>> cards) {
    return DragTarget<Map<String, dynamic>>(
      onWillAcceptWithDetails: (_) => true,
      onAcceptWithDetails: (details) {
        final data = details.data;
        final draggedCard = data['card'];
        final fromQuadrant = data['fromQuadrant'];
        final fromIndex = data['fromIndex'];

        setState(() {
          // Remove o cartão do quadrante de origem
          if (fromQuadrant == title) {
            cards.removeAt(fromIndex);
          } else {
            _quadrants[fromQuadrant]?.remove(draggedCard);
          }

          // Adiciona o cartão ao final do quadrante atual
          cards.add(draggedCard);
        });
      },
      builder: (context, candidateData, rejectedData) {
        return CustomContainer(
          key: _quadrantKeys[title], // Associa a chave ao quadrante
          title: title,
          backgroundColor: const Color(0xFFF4F4F4), // Cinza claro
          borderColor: Colors.grey.shade300, // Borda cinza
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: cards.length + 1,
                  itemBuilder: (context, index) {
                    if (index == cards.length) {
                      return _buildDragTarget(title, cards, index, null, false);
                    }

                    final card = cards[index];
                    _cardKeys.putIfAbsent(card, () => GlobalKey());

                    return Column(
                      children: [
                        Draggable<Map<String, dynamic>>(
                          data: {
                            'card': card,
                            'fromQuadrant': title,
                            'fromIndex': index,
                          },
                          feedback: Material(
                            color: Colors.transparent,
                            child: Card(
                              elevation: 4,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                              child: SizedBox(
                                width: 200,
                                child: ListTile(
                                  title: Text(card['title']!),
                                  subtitle: Text(card['description']!),
                                  tileColor: Colors.white,
                                ),
                              ),
                            ),
                          ),
                          childWhenDragging: Opacity(
                            opacity: 0.5,
                            child: Card(
                              margin: const EdgeInsets.symmetric(vertical: 1.0),
                              elevation: 2,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                              child: ListTile(
                                title: Text(card['title']!),
                                subtitle: Text(card['description']!),
                                tileColor: Colors.white,
                              ),
                            ),
                          ),
                          child: Card(
                            key: _cardKeys[card], // Associa a chave ao cartão
                            margin: const EdgeInsets.symmetric(vertical: 1.0),
                            elevation: 2,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            child: ListTile(
                              title: Text(card['title']!),
                              subtitle: Text(card['description']!),
                              onTap: () => _editCard(title, card),
                              tileColor: Colors.white,
                            ),
                          ),
                        ),
                        _buildDragTarget(title, cards, index, card, true),
                      ],
                    );
                  },
                ),
              ),
              TextButton.icon(
                onPressed: () => _addCard(title),
                icon: const Icon(Icons.add, color: Colors.blue),
                label: const Text(
                  'Adicionar',
                  style: TextStyle(color: Colors.blue),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildDragTarget(String quadrant, List<Map<String, String>> cards,
      int index, Map<String, String>? card, bool isAbove) {
    return DragTarget<Map<String, dynamic>>(
      onWillAcceptWithDetails: (data) => true,
      onAcceptWithDetails: (details) {
        final data = details.data;
        final draggedCard = data['card'];
        final fromQuadrant = data['fromQuadrant'];
        final fromIndex = data['fromIndex'];

        setState(() {
          // Remove o cartão do quadrante de origem
          if (fromQuadrant == quadrant && fromIndex < index) {
            cards.removeAt(fromIndex);
          } else {
            _quadrants[fromQuadrant]?.remove(draggedCard);
          }

          // Calcula o índice mais próximo
          final newIndex = _findClosestIndex(quadrant, details.offset);

          // Insere o cartão no índice correto
          cards.insert(newIndex, draggedCard);
        });
      },
      builder: (context, candidateData, rejectedData) {
        return Container(
          height: 8.0,
          color: candidateData.isNotEmpty
              ? Colors.grey.shade300.withOpacity(0.5) // Área escura
              : Colors.transparent,
        );
      },
    );
  }

  Widget _buildEditCardOverlay() {
    return Stack(
      children: [
        // Fundo escuro com opacidade
        GestureDetector(
          onTap: () {
            setState(() {
              _editingCard = null;
              _editingQuadrant = null;
            });
          },
          child: Container(
            color: Colors.black.withOpacity(0.5),
          ),
        ),
        // Modal de edição
        Center(
          child: CustomContainer(
            backgroundColor: Colors.white,
            borderRadius: 16.0,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Botão de fechar no topo
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Editar Cartão',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.close),
                      onPressed: () {
                        setState(() {
                          _editingCard = null;
                          _editingQuadrant = null;
                        });
                      },
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                // Campo de título
                TextField(
                  decoration: const InputDecoration(
                    labelText: 'Título',
                    labelStyle: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                    filled: true,
                    fillColor: Color(0xFFF5F5F5), // Fundo cinza escuro
                    border: InputBorder.none, // Sem borda
                  ),
                  controller:
                      TextEditingController(text: _editingCard!['title']),
                  onChanged: (value) => _editingCard!['title'] = value,
                ),
                const SizedBox(height: 16),
                // Campo de descrição
                Expanded(
                  child: TextField(
                    decoration: const InputDecoration(
                      labelText: 'Descrição',
                      labelStyle: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                      filled: true,
                      fillColor: Color(0xFFF5F5F5), // Fundo cinza escuro
                      border: InputBorder.none, // Sem borda
                    ),
                    controller: TextEditingController(
                        text: _editingCard!['description']),
                    maxLines: null,
                    expands: true,
                    onChanged: (value) => _editingCard!['description'] = value,
                  ),
                ),
                const SizedBox(height: 16),
                // Botão de salvar
                Align(
                  alignment: Alignment.bottomRight,
                  child: ElevatedButton(
                    onPressed: _saveCard,
                    child: const Text('Salvar'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  int _findClosestIndex(String quadrant, Offset position) {
    int closestIndex = 0;
    double closestDistance = double.infinity;

    final cards = _quadrants[quadrant] ?? [];

    for (int i = 0; i <= cards.length; i++) {
      final RenderBox? renderBox = i < cards.length
          ? _cardKeys[cards[i]]?.currentContext?.findRenderObject()
              as RenderBox?
          : null;

      Offset cardPosition =
          renderBox?.localToGlobal(Offset.zero) ?? Offset.zero;

      // Para o último índice, considere o final da lista
      if (i == cards.length) {
        cardPosition =
            renderBox?.localToGlobal(Offset(0, renderBox.size.height)) ??
                cardPosition;
      }

      // Calcular a distância vertical
      final double distance = (cardPosition.dy - position.dy).abs();

      if (distance < closestDistance) {
        closestDistance = distance;

        // Decidir se será antes ou depois do cartão atual
        if (i < cards.length && position.dy > cardPosition.dy) {
          closestIndex = i + 1; // Inserir abaixo
        } else {
          closestIndex = i; // Inserir acima
        }
      }
    }

    return closestIndex;
  }
}
