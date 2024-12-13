import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UserProfilePage extends StatefulWidget {
  const UserProfilePage({super.key});

  @override
  _UserProfilePageState createState() => _UserProfilePageState();
}

class _UserProfilePageState extends State<UserProfilePage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Controladores de texto
  final TextEditingController nameController = TextEditingController();
  final TextEditingController titleController = TextEditingController();
  final TextEditingController locationController = TextEditingController();
  final TextEditingController areaOfExpertiseController =
      TextEditingController();
  final TextEditingController experienceTimeController =
      TextEditingController();
  final TextEditingController potentialDescriptionController =
      TextEditingController();
  final TextEditingController professionalExperienceController =
      TextEditingController();
  final TextEditingController completedCoursesController =
      TextEditingController();
  final TextEditingController incomeExpectationController =
      TextEditingController();

  String profilePhoto = '';
  bool isEditing = false; // Estado geral de edição

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  // Carregar dados do usuário
  Future<void> _loadUserData() async {
    try {
      final user = _auth.currentUser;
      if (user == null) {
        throw Exception('Usuário não autenticado.');
      }

      final uid = user.uid;

      final doc = await _firestore.collection('users').doc(uid).get();

      if (!doc.exists) {
        throw Exception('Perfil do usuário não encontrado no Firestore.');
      }

      final data = doc.data();

      setState(() {
        nameController.text = data?['name'] ?? '';
        titleController.text = data?['title'] ?? '@meu_usuario';
        locationController.text = data?['location'] ?? '';
        profilePhoto = data?['profilePicture'] ?? '';
        areaOfExpertiseController.text = data?['areaOfExpertise'] ?? '';
        experienceTimeController.text = data?['experienceTime'] ?? '';
        potentialDescriptionController.text =
            data?['potentialDescription'] ?? '';
        professionalExperienceController.text =
            data?['professionalExperience'] ?? '';
        completedCoursesController.text = data?['completedCourses'] ?? '';
        incomeExpectationController.text = data?['incomeExpectation'] ?? '';
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Erro ao carregar perfil: $e')),
      );
    }
  }

  // Salvar dados do perfil
  Future<void> _saveUserData() async {
    try {
      final user = _auth.currentUser;
      if (user == null) {
        throw Exception('Usuário não autenticado.');
      }

      final uid = user.uid;

      await _firestore.collection('users').doc(uid).set(
        {
          'name': nameController.text.trim(),
          'title': titleController.text.trim(),
          'location': locationController.text.trim(),
          'profilePicture': profilePhoto,
          'areaOfExpertise': areaOfExpertiseController.text.trim(),
          'experienceTime': experienceTimeController.text.trim(),
          'potentialDescription': potentialDescriptionController.text.trim(),
          'professionalExperience':
              professionalExperienceController.text.trim(),
          'completedCourses': completedCoursesController.text.trim(),
          'incomeExpectation': incomeExpectationController.text.trim(),
        },
        SetOptions(merge: true),
      );

      setState(() {
        isEditing = false;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Perfil atualizado com sucesso!')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Erro ao salvar perfil: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Perfil'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 800),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Cabeçalho
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // Foto de perfil com hover
                      Stack(
                        children: [
                          CircleAvatar(
                            radius: 50,
                            backgroundImage: profilePhoto.isNotEmpty
                                ? NetworkImage(profilePhoto)
                                : null,
                            child: profilePhoto.isEmpty
                                ? const Icon(Icons.person, size: 50)
                                : null,
                          ),
                          if (isEditing)
                            Positioned.fill(
                              child: Material(
                                color: Colors.black.withOpacity(0.3),
                                child: InkWell(
                                  onTap: () {
                                    // Lógica para editar foto
                                  },
                                  child: const Icon(
                                    Icons.edit,
                                    color: Colors.white,
                                    size: 30,
                                  ),
                                ),
                              ),
                            ),
                        ],
                      ),
                      const SizedBox(width: 16),

                      // Informações principais
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Nome
                            isEditing
                                ? TextField(
                                    controller: nameController,
                                    decoration: const InputDecoration(
                                      labelText: 'Nome',
                                      border: OutlineInputBorder(),
                                    ),
                                  )
                                : Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const Text(
                                        'Nome',
                                        style: TextStyle(
                                            fontSize: 12, color: Colors.grey),
                                      ),
                                      const SizedBox(height: 4),
                                      Text(
                                        nameController.text.isNotEmpty
                                            ? nameController.text
                                            : 'Não informado',
                                        style: const TextStyle(fontSize: 16),
                                      ),
                                    ],
                                  ),
                            const SizedBox(height: 8),

                            // Área de atuação
                            isEditing
                                ? TextField(
                                    controller: areaOfExpertiseController,
                                    decoration: const InputDecoration(
                                      labelText: 'Área de Atuação',
                                      border: OutlineInputBorder(),
                                    ),
                                  )
                                : Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const Text(
                                        'Área de Atuação',
                                        style: TextStyle(
                                            fontSize: 12, color: Colors.grey),
                                      ),
                                      const SizedBox(height: 4),
                                      Text(
                                        areaOfExpertiseController
                                                .text.isNotEmpty
                                            ? areaOfExpertiseController.text
                                            : 'Não informado',
                                        style: const TextStyle(fontSize: 16),
                                      ),
                                    ],
                                  ),
                          ],
                        ),
                      ),

                      // Botão de editar/salvar
                      IconButton(
                        icon: Icon(isEditing ? Icons.save : Icons.edit),
                        onPressed: isEditing
                            ? _saveUserData
                            : () => setState(() {
                                  isEditing = true;
                                }),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),

                  // Campos adicionais
                  _buildEditableField(
                    controller: locationController,
                    label: 'Localização',
                    isEditing: isEditing,
                  ),
                  const SizedBox(height: 16),
                  _buildEditableField(
                    controller: experienceTimeController,
                    label: 'Tempo como Profissional',
                    isEditing: isEditing,
                  ),
                  const SizedBox(height: 16),
                  _buildEditableField(
                    controller: potentialDescriptionController,
                    label: 'Descrição do Potencial e Qualidades',
                    multiline: true,
                    isEditing: isEditing,
                  ),
                  const SizedBox(height: 16),
                  _buildEditableField(
                    controller: professionalExperienceController,
                    label: 'Experiência Profissional',
                    multiline: true,
                    isEditing: isEditing,
                  ),
                  const SizedBox(height: 16),
                  _buildEditableField(
                    controller: completedCoursesController,
                    label: 'Cursos Realizados',
                    isEditing: isEditing,
                  ),
                  const SizedBox(height: 16),
                  _buildEditableField(
                    controller: incomeExpectationController,
                    label: 'Expectativa de Faturamento',
                    isEditing: isEditing,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  // Método para exibir um campo de texto editável ou texto fixo
  Widget _buildEditableField({
    required TextEditingController controller,
    required String label,
    bool multiline = false,
    required bool isEditing,
  }) {
    return isEditing
        ? TextField(
            controller: controller,
            maxLines: multiline ? null : 1,
            decoration: InputDecoration(
              labelText: label,
              border: const OutlineInputBorder(),
            ),
          )
        : Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: const TextStyle(fontSize: 12, color: Colors.grey),
              ),
              const SizedBox(height: 4),
              Text(
                controller.text.isNotEmpty ? controller.text : 'Não informado',
                style: const TextStyle(fontSize: 16),
              ),
            ],
          );
  }
}
