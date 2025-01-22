import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:star_beauty_app/components/custom_container.dart';

class Starflix extends StatefulWidget {
  const Starflix({super.key});

  @override
  State<Starflix> createState() => _StarflixState();
}

class Chapter {
  final String id;
  final String title;
  final List<String> courseIDs;

  Chapter({required this.id, required this.title, required this.courseIDs});
}

class _StarflixState extends State<Starflix> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  List<Chapter> chapters = [];

  late Future<void> _futureData;

  @override
  void initState() {
    super.initState();
    _futureData = _loadData();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _futureData,
        builder: (context, asyncSnapshot) {
          if (asyncSnapshot.connectionState == ConnectionState.waiting) {
            return Container();
          }
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: 40,
            children: [
              for (int i = 0; i < chapters.length; i++)
                _buildCourseChapter(
                    title: chapters[i].title,
                    courses: chapters[i].courseIDs,
                    color: Colors.blue,
                    onCouseSelected: (id) {
                      context.go('/course_screen', extra: {
                        'id': id,
                      });
                    }),
            ],
          );
        });
  }

  Widget _buildCourseCard(String title,
      {required Function onPressed, Color color = Colors.deepOrange}) {
    return TextButton(
      onPressed: () {
        onPressed();
      },
      child: Container(
        width: 160,
        margin: const EdgeInsets.only(right: 16),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              color,
              Colors.white,
            ],
          ),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Stack(
          children: [
            // Positioned(
            //   top: 16,
            //   left: 16,
            //   child: Image.asset(
            //     'assets/images/imagemcategoria01.jpg', // You'll need to add this asset
            //     width: 24,
            //     height: 24,
            //     color: Colors.white.withOpacity(0.8),
            //   ),
            // ),
            Center(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  title,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCourseChapter({
    required String title,
    required List<String> courses,
    required Color color,
    required Function(String id) onCouseSelected,
  }) {
    return CustomContainer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.grey[800],
            ),
          ),
          const SizedBox(height: 16),
          // First Row of Orange Cards
          SizedBox(
            height: 180,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                for (int i = 0; i < courses.length; i++)
                  _buildCourseCard(
                    courses[i],
                    color: color,
                    onPressed: () {
                      onCouseSelected(courses[i]);
                    },
                  )
              ],
            ),
          ),
        ],
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

      final collection = await _firestore.collection('chapters').get();

      if (collection != null) {
        final docs = collection.docs;
        setState(() {
          for (var doc in docs) {
            var data = doc.data();
            List<String> ids = [];
            for (var id in data['coursesIDs'] ?? []) {
              ids.add(id as String);
            }
            var chapter = Chapter(
              id: "",
              title: data["name"] ?? '',
              courseIDs: ids,
            );
            chapters.add(chapter);
          }
        });
      }
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('starflix carregado com sucesso!')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Erro ao carregar o starflix: $e')),
      );
    }
  }

  // Future<void> _saveData() async {
  //   try {
  //     final user = _auth.currentUser;
  //     if (user == null) {
  //       throw Exception(
  //           "Usuário não autenticado"); //caso não, throw uma exception
  //     }

  //     await _firestore
  //         .collection('users')
  //         .doc(user.uid)
  //         .collection('plano_de_acao')
  //         .doc('current')
  //         .set({
  //       'objetivo': objetivoController.text,
  //       'faturamentoDesejado': faturamentoDesejadoController.text,
  //       'tableData': tableData,
  //       'updatedAt': FieldValue.serverTimestamp(),
  //     });

  //     ScaffoldMessenger.of(context).showSnackBar(
  //       const SnackBar(content: Text('Plano de ação salvo com sucesso!')),
  //     );
  //   } catch (e) {
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       SnackBar(content: Text('Erro ao salvar plano: $e')),
  //     );
  //   }
  // }
}
