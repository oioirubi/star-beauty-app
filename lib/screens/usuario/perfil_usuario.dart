import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

import 'package:star_beauty_app/components/custom_container.dart';
import 'package:star_beauty_app/components/custom_text.dart';

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
  final TextEditingController locationController = TextEditingController();
  final TextEditingController areaOfExpertiseController =
      TextEditingController();
  final TextEditingController experienceTimeController =
      TextEditingController();
  final TextEditingController potentialDescriptionController =
      TextEditingController();
  final TextEditingController professionalExperienceController =
      TextEditingController();
  final TextEditingController incomeExpectationController =
      TextEditingController();
  final TextEditingController completedCoursesController =
      TextEditingController();
  final TextEditingController starRatingController = TextEditingController();

  List<Map<String, dynamic>> portfolioPhotos = [];
  bool isEditingFirstContainer = false;
  bool isEditingSecondContainer = false;
  bool isEditingPortfolioContainer = false;

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    try {
      final user = _auth.currentUser;
      if (user == null) throw Exception('Usuário não autenticado.');

      final uid = user.uid;
      final doc = await _firestore.collection('users').doc(uid).get();

      if (!doc.exists) {
        throw Exception('Perfil do usuário não encontrado no Firestore.');
      }

      final data = doc.data();

      setState(() {
        nameController.text = data?['name'] ?? '';
        locationController.text = data?['location'] ?? '';
        areaOfExpertiseController.text = data?['areaOfExpertise'] ?? '';
        experienceTimeController.text = data?['experienceTime'] ?? '';
        potentialDescriptionController.text =
            data?['potentialDescription'] ?? '';
        professionalExperienceController.text =
            data?['professionalExperience'] ?? '';
        incomeExpectationController.text = data?['incomeExpectation'] ?? '';
        completedCoursesController.text = data?['completedCourses'] ?? '';
        starRatingController.text = data?['starRating'] ?? '1';
        portfolioPhotos =
            List<Map<String, dynamic>>.from(data?['portfolioPhotos'] ?? []);
      });
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Erro ao carregar perfil: $e')));
    }
  }

  Future<void> _addPortfolioPhoto() async {
    if (portfolioPhotos.length >= 8) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Você só pode adicionar até 8 fotos.')),
      );
      return;
    }

    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      final descriptionController = TextEditingController();
      await showDialog(
        context: context,
        builder: (ctx) {
          return AlertDialog(
            title: const Text('Adicionar Descrição'),
            content: TextField(
              controller: descriptionController,
              decoration:
                  const InputDecoration(hintText: 'Digite uma descrição'),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(ctx).pop(),
                child: const Text('Cancelar'),
              ),
              TextButton(
                onPressed: () {
                  if (descriptionController.text.isNotEmpty) {
                    setState(() {
                      portfolioPhotos.add({
                        'photoPath': pickedFile.path,
                        'description': descriptionController.text,
                      });
                    });
                    Navigator.of(ctx).pop();
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Descrição obrigatória.')),
                    );
                  }
                },
                child: const Text('Adicionar'),
              ),
            ],
          );
        },
      );
    }
  }

  Future<void> _savePortfolio() async {
    try {
      final user = _auth.currentUser;
      if (user == null) throw Exception('Usuário não autenticado.');

      final uid = user.uid;

      await _firestore.collection('users').doc(uid).update({
        'portfolioPhotos': portfolioPhotos,
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Portfólio salvo com sucesso.')),
      );
      setState(() {
        isEditingPortfolioContainer = false;
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Erro ao salvar portfólio: $e')),
      );
    }
  }

  void _cancelEditPortfolio() {
    setState(() {
      isEditingPortfolioContainer = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          // Primeiro Container
          CustomContainer(
            title: 'Meu Perfil',
            contentPadding: const EdgeInsets.all(50),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const CustomText(text: 'Editar Perfil', isTitle: true),
                    if (!isEditingFirstContainer)
                      ElevatedButton(
                        onPressed: () {
                          setState(() {
                            isEditingFirstContainer = true;
                          });
                        },
                        child: const Text('Editar'),
                      ),
                  ],
                ),
                const SizedBox(height: 24),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: isEditingFirstContainer ? 160 : 120,
                      height: isEditingFirstContainer ? 160 : 120,
                      child: CircleAvatar(
                        radius: isEditingFirstContainer ? 80 : 60,
                        backgroundImage: null,
                        child: const Icon(Icons.person, size: 60),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildEditableField(
                            controller: nameController,
                            title: 'Nome',
                            isEditing: isEditingFirstContainer,
                          ),
                          const SizedBox(height: 8),
                          _buildEditableField(
                            controller: areaOfExpertiseController,
                            title: 'Área de Atuação',
                            isEditing: isEditingFirstContainer,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Row(
                  children: List.generate(
                    5,
                    (index) => Icon(
                      Icons.star,
                      color: index < int.parse(starRatingController.text)
                          ? Colors.amber
                          : Colors.grey,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 32),

          // Segundo Container
          CustomContainer(
            title: 'Cadastro Profissional',
            contentPadding: const EdgeInsets.all(50),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const CustomText(text: 'Editar Cadastro', isTitle: true),
                    if (!isEditingSecondContainer)
                      ElevatedButton(
                        onPressed: () {
                          setState(() {
                            isEditingSecondContainer = true;
                          });
                        },
                        child: const Text('Editar'),
                      ),
                  ],
                ),
                const SizedBox(height: 24),
                _buildEditableField(
                  controller: completedCoursesController,
                  title: 'Cursos Realizados',
                  isEditing: isEditingSecondContainer,
                ),
                const SizedBox(height: 16),
                _buildEditableField(
                  controller: potentialDescriptionController,
                  title: 'Descrição do Potencial e Qualidades',
                  isEditing: isEditingSecondContainer,
                ),
              ],
            ),
          ),
          const SizedBox(height: 32),

          // Terceiro Container (Fotos dos Trabalhos)
          CustomContainer(
            title: 'Portfólio',
            contentPadding: const EdgeInsets.all(50),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const CustomText(
                        text: 'Fotos dos Trabalhos', isTitle: true),
                    if (!isEditingPortfolioContainer)
                      ElevatedButton(
                        onPressed: () {
                          setState(() {
                            isEditingPortfolioContainer = true;
                          });
                        },
                        child: const Text('Editar'),
                      ),
                  ],
                ),
                const SizedBox(height: 16),
                Wrap(
                  spacing: 16,
                  runSpacing: 16,
                  children: [
                    ...portfolioPhotos.map(
                      (photo) => CustomContainer(
                        child: Column(
                          children: [
                            Image.file(File(photo['photoPath'])),
                            Text(photo['description']),
                          ],
                        ),
                      ),
                    ),
                    if (isEditingPortfolioContainer)
                      GestureDetector(
                        onTap: _addPortfolioPhoto,
                        child: const CustomContainer(
                          child: Center(
                            child:
                                Icon(Icons.add, size: 40, color: Colors.grey),
                          ),
                        ),
                      ),
                  ],
                ),
                if (isEditingPortfolioContainer)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton(
                        onPressed: _savePortfolio,
                        child: const Text('Salvar'),
                      ),
                      ElevatedButton(
                        onPressed: _cancelEditPortfolio,
                        child: const Text('Cancelar'),
                      ),
                    ],
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEditableField({
    required TextEditingController controller,
    required String title,
    bool isEditing = false,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomText(text: title, isTitle: true),
        const SizedBox(height: 4),
        TextField(
          controller: controller,
          readOnly: !isEditing,
          decoration: InputDecoration(
            border: isEditing ? const OutlineInputBorder() : InputBorder.none,
          ),
        ),
      ],
    );
  }
}
