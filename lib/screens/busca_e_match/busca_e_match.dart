import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:star_beauty_app/components/custom_container.dart';
import 'package:star_beauty_app/components/custom_text.dart';
import 'package:star_beauty_app/global_classes/firebase_match_utils.dart';
import 'package:star_beauty_app/global_classes/firebase_user_utils.dart';
import 'package:star_beauty_app/screens/busca_e_match/filter_match_options.dart';
import 'package:star_beauty_app/screens/busca_e_match/profile_card.dart';

class BuscaEMatch extends StatefulWidget {
  final String userType;

  const BuscaEMatch({super.key, required this.userType});

  @override
  _BuscaEMatchState createState() => _BuscaEMatchState();
}

class _BuscaEMatchState extends State<BuscaEMatch> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final List<Profile> profiles = [];
  final List<Profile> matchs = [];

  late var futureGetUsers;

  List<Profile> filteredProfiles = [];
  String selectedCategory = 'Todos';
  String selectedType = 'Todos';
  bool isMatchListing = false;

  @override
  void initState() {
    super.initState();
    futureGetUsers =
        FirebaseUserUtils().getAllUsers(onSuccessfull: _onLoadedUsers);
    _applyFilters();
  }

  _onDeletePressed() {}

  _onLoadedUsers(List<Map<String, dynamic>> loadedUsers) {
    for (var i = 0; i < loadedUsers.length; i++) {
      profiles.add(Profile(
        uid: loadedUsers[i]['uid'] ?? '',
        phoneNumber: loadedUsers[i]['phoneNumber'] ?? '',
        email: loadedUsers[i]['email'] ?? '',
        name: loadedUsers[i]['name'] ?? '',
        category: loadedUsers[i]['areaOfExpertise'] ?? '',
        type: loadedUsers[i]['userType'] ?? '',
        image: loadedUsers[i]['image'] ?? '',
      ));
    }
  }

  _applyFilters() {
    setState(() {
      var toFilter = isMatchListing ? matchs : profiles;
      filteredProfiles = toFilter.where((profile) {
        return (selectedCategory == 'Todos' ||
                profile.category == selectedCategory) &&
            (selectedType == 'Todos' || profile.type == selectedType);
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    // Obtendo a largura da tela
    double screenWidth = MediaQuery.of(context).size.width;

    int columns;
    if (screenWidth >= 1200) {
      columns = 4; // Telas muito grandes (desktop)
    } else if (screenWidth >= 900) {
      columns = 3; // Telas grandes (tablets em landscape)
    } else if (screenWidth >= 800) {
      columns = 2; // Telas médias (tablets ou celulares maiores)
    } else {
      columns = 1; // Telas pequenas (celulares)
    }

    return FutureBuilder(
      future: futureGetUsers,
      builder: (ctx, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Container();
        }
        return _build_screen(columns);
      },
    );
  }

  CustomContainer _build_screen(int columns) {
    return CustomContainer(
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              TextButton(
                onPressed: () {
                  setState(() {
                    isMatchListing = false;
                    _applyFilters();
                  });
                },
                child: const CustomText(
                  text: 'Procurar Parceiros',
                  isTitle: true, // Será formatado como título
                ),
              ),
              TextButton(
                onPressed: () {
                  setState(() {
                    isMatchListing = true;
                    _applyFilters();
                  });
                },
                child: const CustomText(
                  text: 'Meus Matchs',
                  isTitle: true, // Será formatado como título
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          // Botão de Filtro
          FilterMatchOptions(
            onSelectedType: (value) {
              setState(() {
                selectedType = value;
              });
              _applyFilters();
            },
            onSelectedCategory: (category) {
              setState(() {
                selectedCategory = category;
              });
              _applyFilters();
            },
          ),
          const SizedBox(height: 16),
          // Lista de Perfis
          filteredProfiles.isEmpty
              ? const Center(child: Text('Nenhum perfil encontrado.'))
              : Container(
                  child: GridView.builder(
                    shrinkWrap: true, // Evita quebra de layout
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount:
                          columns, // Usando a variável `columns` para definir a quantidade de colunas
                      crossAxisSpacing: 16,
                      mainAxisSpacing: 16,
                    ),
                    itemCount: filteredProfiles.length,
                    itemBuilder: (context, index) {
                      final profile = filteredProfiles[index];
                      return ProfileCard(
                        profile: profile,
                        onDeletePressed: _onDeletePressed,
                        onFavoritePressed: () {
                          _onFavoritePressed(profile);
                        },
                      );
                    },
                  ),
                ),
        ],
      ),
    );
  }

  _onFavoritePressed(Profile profile) async {
    FirebaseMatchUtils().sendUserLike(toUserID: profile.uid);
  }
}
