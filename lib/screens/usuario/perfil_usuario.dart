import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
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
  final TextEditingController completedCoursesController =
      TextEditingController();
  final TextEditingController incomeExpectationController =
      TextEditingController();
  final TextEditingController starRatingController = TextEditingController();

  final TextEditingController addressController = TextEditingController();
  final TextEditingController portfolioDescriptionController =
      TextEditingController();
  final TextEditingController photosController = TextEditingController();

  String profilePhoto = '';
  bool isEditingFirstContainer = false;
  bool isEditingSecondContainer = false;
  bool isEditingPortfolioContainer = false;
  Map<String, String> _originalDataFirstContainer = {};
  Map<String, String> _originalDataSecondContainer = {};

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

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
        locationController.text = data?['location'] ?? '';
        areaOfExpertiseController.text = data?['areaOfExpertise'] ?? '';
        experienceTimeController.text = data?['experienceTime'] ?? '';
        potentialDescriptionController.text =
            data?['potentialDescription'] ?? '';
        professionalExperienceController.text =
            data?['professionalExperience'] ?? '';
        completedCoursesController.text = data?['completedCourses'] ?? '';
        incomeExpectationController.text = data?['incomeExpectation'] ?? '';
        starRatingController.text = data?['starRating'] ?? '1';
        addressController.text = data?['address'] ?? '';
        portfolioDescriptionController.text =
            data?['portfolioDescription'] ?? '';
        photosController.text = data?['photos'] ?? '';

        _originalDataFirstContainer = {
          'name': nameController.text,
          'location': locationController.text,
          'areaOfExpertise': areaOfExpertiseController.text,
          'experienceTime': experienceTimeController.text,
          'potentialDescription': potentialDescriptionController.text,
          'professionalExperience': professionalExperienceController.text,
          'completedCourses': completedCoursesController.text,
          'incomeExpectation': incomeExpectationController.text,
          'starRating': starRatingController.text,
        };

        _originalDataSecondContainer = {
          'address': addressController.text,
          'portfolioDescription': portfolioDescriptionController.text,
          'photos': photosController.text,
        };
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Erro ao carregar perfil: $e')),
      );
    }
  }

// Método para restaurar dados originais
  void _restoreOriginalData() {
    setState(() {
      nameController.text = _originalDataFirstContainer['name'] ?? '';
      locationController.text = _originalDataFirstContainer['location'] ?? '';
      areaOfExpertiseController.text =
          _originalDataFirstContainer['areaOfExpertise'] ?? '';
      experienceTimeController.text =
          _originalDataFirstContainer['experienceTime'] ?? '';
      potentialDescriptionController.text =
          _originalDataFirstContainer['potentialDescription'] ?? '';
      professionalExperienceController.text =
          _originalDataFirstContainer['professionalExperience'] ?? '';
      completedCoursesController.text =
          _originalDataFirstContainer['completedCourses'] ?? '';
      incomeExpectationController.text =
          _originalDataFirstContainer['incomeExpectation'] ?? '';
      starRatingController.text =
          _originalDataFirstContainer['starRating'] ?? '1';
    });
  }

// Método para salvar todos os dados
  Future<void> _saveAllData() async {
    try {
      final user = _auth.currentUser;
      if (user == null) {
        throw Exception('Usuário não autenticado.');
      }
      final uid = user.uid;
      await _firestore.collection('users').doc(uid).update({
        'name': nameController.text,
        'location': locationController.text,
        'areaOfExpertise': areaOfExpertiseController.text,
        'experienceTime': experienceTimeController.text,
        'potentialDescription': potentialDescriptionController.text,
        'professionalExperience': professionalExperienceController.text,
        'completedCourses': completedCoursesController.text,
        'incomeExpectation': incomeExpectationController.text,
        'starRating': starRatingController.text,
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Dados salvos com sucesso!')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Erro ao salvar dados: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Conteúdo principal com rolagem
        SingleChildScrollView(
          child: Column(
            children: [
              CustomContainer(
                title: 'Meu Perfil',
                contentPadding: const EdgeInsets.all(50),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const CustomText(
                          text: 'Editar Perfil',
                          isTitle: true,
                        ),
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
                            backgroundImage: profilePhoto.isNotEmpty
                                ? NetworkImage(profilePhoto)
                                : null,
                            child: profilePhoto.isEmpty
                                ? const Icon(Icons.person, size: 60)
                                : null,
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
                    const SizedBox(height: 16),
                    _buildEditableField(
                      controller: locationController,
                      title: 'Localização',
                      isEditing: isEditingFirstContainer,
                    ),
                    const SizedBox(height: 16),
                    _buildEditableField(
                      controller: experienceTimeController,
                      title: 'Tempo como Profissional',
                      isEditing: isEditingFirstContainer,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 32),
              CustomContainer(
                title: 'Cadastro Profissional',
                contentPadding: const EdgeInsets.all(50),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const CustomText(
                          text: 'Editar Cadastro',
                          isTitle: true,
                        ),
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
                  ],
                ),
              ),
              const SizedBox(height: 32),
              CustomContainer(
                title: 'Portfólio',
                contentPadding: const EdgeInsets.all(50),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildEditableField(
                      controller: photosController,
                      title: 'Fotos dos Trabalhos',
                      isEditing: isEditingPortfolioContainer,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        // Barra fixa no rodapé
        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: Visibility(
            visible: isEditingFirstContainer ||
                isEditingSecondContainer ||
                isEditingPortfolioContainer,
            child: Container(
              color: Colors.white,
              padding:
                  const EdgeInsets.symmetric(vertical: 16.0, horizontal: 32.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(
                    onPressed: () {
                      setState(() {
                        isEditingFirstContainer = false;
                        isEditingSecondContainer = false;
                        isEditingPortfolioContainer = false;
                      });
                    },
                    child: const Text('Cancelar',
                        style: TextStyle(color: Colors.grey)),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        isEditingFirstContainer = false;
                        isEditingSecondContainer = false;
                        isEditingPortfolioContainer = false;
                      });
                    },
                    child: const Text('Salvar alterações'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildEditableField({
    required TextEditingController controller,
    required String title,
    bool multiline = false,
    required bool isEditing,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomText(
          text: title,
          isTitle: true,
        ),
        const SizedBox(height: 4),
        TextField(
          controller: controller,
          maxLines: multiline ? null : 1,
          decoration: InputDecoration(
            border: isEditing ? const OutlineInputBorder() : InputBorder.none,
            hintText:
                isEditing ? 'Digite $title' : 'Nenhuma informação disponível',
          ),
          readOnly: !isEditing,
        ),
      ],
    );
  }
}
