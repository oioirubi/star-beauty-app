import 'package:flutter/material.dart';
import 'package:star_beauty_app/components/custom_text.dart';

class MatchCadastro extends StatefulWidget {
  const MatchCadastro({super.key});

  @override
  _MatchCadastroState createState() => _MatchCadastroState();
}

class _MatchCadastroState extends State<MatchCadastro> {
  final List<String> _photos =
      []; // Lista para armazenar as fotos (simulação com URLs)
  final _formKey = GlobalKey<FormState>(); // Chave do formulário para validação

  void _addPhoto() {
    // Simula o upload de uma foto (adicione integração com câmera ou galeria)
    setState(() {
      _photos
          .add('https://via.placeholder.com/150'); // Exemplo de imagem genérica
    });
  }

  void _saveForm() {
    if (_formKey.currentState!.validate()) {
      if (_photos.length < 3) {
        // Validação mínima de 3 fotos
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
                'É obrigatório adicionar pelo menos 3 fotos ao portfólio!'),
            backgroundColor: Colors.red,
          ),
        );
      } else {
        // Processar o formulário se tudo estiver válido
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Cadastro salvo com sucesso!'),
            backgroundColor: Colors.green,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Form(
        key: _formKey, // Adicionando o Form para validação
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const CustomText(
              text: 'Cadastro Profissional',
              isTitle: true,
            ),
            const SizedBox(height: 16),
            const CustomText(
              text: 'Preencha suas informações para começar a se conectar',
            ),
            const SizedBox(height: 8),
            // Nome
            TextFormField(
              decoration: const InputDecoration(
                labelText: 'Nome',
                border: OutlineInputBorder(),
              ),
              validator: (value) =>
                  value == null || value.isEmpty ? 'Campo obrigatório' : null,
            ),
            const SizedBox(height: 16),
            // Endereço
            TextFormField(
              decoration: const InputDecoration(
                labelText: 'Endereço',
                border: OutlineInputBorder(),
              ),
              validator: (value) =>
                  value == null || value.isEmpty ? 'Campo obrigatório' : null,
            ),
            const SizedBox(height: 16),
            // Área Profissional
            TextFormField(
              decoration: const InputDecoration(
                labelText: 'Área de atuação',
                border: OutlineInputBorder(),
              ),
              validator: (value) =>
                  value == null || value.isEmpty ? 'Campo obrigatório' : null,
            ),
            const SizedBox(height: 16),
            // Tempo de Profissional
            TextFormField(
              decoration: const InputDecoration(
                labelText: 'Tempo como Profissional',
                border: OutlineInputBorder(),
              ),
              validator: (value) =>
                  value == null || value.isEmpty ? 'Campo obrigatório' : null,
            ),
            const SizedBox(height: 40),
            // Descrição do Potencial e Qualidades
            const CustomText(
              text:
                  'Descreva suas principais qualidades e o que você tem a oferecer profissionalmente',
            ),
            const SizedBox(height: 8),
            TextFormField(
              decoration: const InputDecoration(
                labelText: 'Descrição do potencial e qualidades',
                border: OutlineInputBorder(),
              ),
              maxLines: 4,
              validator: (value) =>
                  value == null || value.isEmpty ? 'Campo obrigatório' : null,
            ),
            const SizedBox(height: 16),
            // Experiência Profissional
            TextFormField(
              decoration: const InputDecoration(
                labelText: 'Experiência Profissional',
                border: OutlineInputBorder(),
              ),
              maxLines: 2,
              validator: (value) =>
                  value == null || value.isEmpty ? 'Campo obrigatório' : null,
            ),
            const SizedBox(height: 16),
            // Cursos Realizados
            TextFormField(
              decoration: const InputDecoration(
                labelText: 'Cursos Realizados',
                border: OutlineInputBorder(),
              ),
              validator: (value) => value == null || value.isEmpty ? '' : null,
            ),
            const SizedBox(height: 16),
            // Expectativa de Faturamento
            TextFormField(
              decoration: const InputDecoration(
                labelText: 'Expectativa de Faturamento',
                border: OutlineInputBorder(),
              ),
              validator: (value) =>
                  value == null || value.isEmpty ? 'Campo obrigatório' : null,
            ),
            const SizedBox(height: 40),
            // Botão Salvar alinhado à direita
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: _saveForm,
                  child: const Text('Salvar'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
