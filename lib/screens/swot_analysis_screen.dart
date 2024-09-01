import 'package:flutter/material.dart';

class SWOTAnalysisScreen extends StatelessWidget {
  const SWOTAnalysisScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Análise SWOT'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Expanded(
              child: Row(
                children: [
                  // Quadrante de Pontos Fortes
                  Expanded(
                    child: _buildQuadrant(
                      context,
                      'Pontos Fortes',
                      Colors.green,
                      'Insira seus pontos fortes aqui',
                    ),
                  ),
                  const SizedBox(width: 8),
                  // Quadrante de Pontos Fracos
                  Expanded(
                    child: _buildQuadrant(
                      context,
                      'Pontos Fracos',
                      Colors.red,
                      'Insira seus pontos fracos aqui',
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 8),
            Expanded(
              child: Row(
                children: [
                  // Quadrante de Oportunidades
                  Expanded(
                    child: _buildQuadrant(
                      context,
                      'Oportunidades',
                      Colors.blue,
                      'Insira suas oportunidades aqui',
                    ),
                  ),
                  const SizedBox(width: 8),
                  // Quadrante de Ameaças
                  Expanded(
                    child: _buildQuadrant(
                      context,
                      'Ameaças',
                      Colors.orange,
                      'Insira suas ameaças aqui',
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                // Adicione a lógica para salvar as informações
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
    );
  }

  Widget _buildQuadrant(
      BuildContext context, String title, Color color, String hint) {
    return Container(
      decoration: BoxDecoration(
        color: color, // Preenche o fundo do container com a cor correspondente
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(8.0),
            child: Text(
              title,
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
          ),
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                color: Colors.white, // Fundo branco para a área de texto
                borderRadius: BorderRadius.vertical(
                  bottom: Radius.circular(8.0),
                ),
              ),
              child: TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: hint,
                ),
                maxLines: null,
                expands: true,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
