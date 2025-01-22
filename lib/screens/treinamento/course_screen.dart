import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:star_beauty_app/components/custom_container.dart';
import 'package:star_beauty_app/screens/treinamento/video_screen.dart';

class CourseScreen extends StatefulWidget {
  const CourseScreen();
  @override
  State<CourseScreen> createState() => _CourseScreenState();
}

class _CourseScreenState extends State<CourseScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  String courseID = '';
  String courseName = '';

  String courseDescription = '';

  String expiryDate = '';

  List<LessonItem> lessons = [];

  double progress = 0;

  LessonItem? lessonSelected;

  late Future _futureData;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      initVariables();
    });
  }

  void initVariables() {
    var args = GoRouterState.of(context)?.extra as Map<String, dynamic>;

    setState(() {
      courseID = args['id'] ?? '';
      _futureData = _loadData();
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _futureData,
        builder: (context, ans) {
          if (ans.connectionState == ConnectionState.waiting) {
            return Container();
          }
          return CustomContainer(
            contentPadding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                lessonSelected != null
                    ? Expanded(
                        flex: 7,
                        child: VideoScreen(
                            title: lessonSelected!.title,
                            videoURL: lessonSelected!.videoURL),
                      )
                    : Expanded(
                        flex: 4,
                        child: _buildCourseDetails(),
                      ),
                const SizedBox(height: 50),
                Expanded(
                  flex: 3,
                  child: SizedBox(
                    height: 200,
                    child: ListView.separated(
                      itemCount: lessons.length,
                      separatorBuilder: (context, index) =>
                          const SizedBox(height: 12),
                      itemBuilder: (context, index) {
                        return LessonButton(
                          lesson: lessons[index],
                          onPressed: () {
                            setState(() {
                              lessonSelected = lessons[index];
                            });
                          },
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          );
        });
  }

  _buildCourseDetails() {
    // const width = 300.0;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          courseName,
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          courseDescription,
          style: TextStyle(
            color: Colors.grey[600],
            fontSize: 16,
          ),
        ),
        const SizedBox(height: 8),
        // Text(
        //   'Expira em $expiryDate',
        //   style: TextStyle(
        //     color: Colors.grey[600],
        //     fontSize: 14,
        //   ),
        // ),
        const SizedBox(height: 16),
        Container(
          // width: width,
          child: LinearProgressIndicator(
            value: progress,
            backgroundColor: Colors.grey[200],
            valueColor: AlwaysStoppedAnimation<Color>(Colors.blue[300]!),
          ),
        ),
        // const SizedBox(height: 24),
        // Row(
        //   children: [
        //     Expanded(
        //       child: ElevatedButton(
        //         onPressed: () {},
        //         style: ElevatedButton.styleFrom(
        //           backgroundColor: Colors.orange[300],
        //           foregroundColor: Colors.white,
        //         ),
        //         child: const Text('começar agora'),
        //       ),
        //     ),
        //   ],
        // ),
      ],
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

      final docs = await _firestore.collection('courses').doc(courseID).get();

      if (docs.exists) {
        final data = docs.data();

        setState(() {
          courseName = data?['name'] ?? '';
          courseDescription = data?['description'] ?? '';
          for (var map in data?['lessons'] ?? []) {
            lessons.add(LessonItem(
                videoURL: map['videoURL'] ?? '',
                title: map['name'],
                duration: ''));
          }
        });
      }
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('tela do curso carregada com sucesso!')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Erro ao carregar a tela do curso: $e')),
      );
    }
  }
}

class LessonItem {
  final String title;
  final String duration;
  final bool isCompleted;
  final String videoURL;

  const LessonItem({
    required this.videoURL,
    required this.title,
    required this.duration,
    this.isCompleted = false,
  });
}

class LessonButton extends StatelessWidget {
  final Function onPressed;
  final LessonItem lesson;

  const LessonButton({
    Key? key,
    required this.lesson,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        onPressed();
      },
      child: Row(
        children: [
          Expanded(
            child: Container(
              height: 80,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.1),
                    spreadRadius: 1,
                    blurRadius: 2,
                    offset: const Offset(0, 1),
                  ),
                ],
              ),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: lesson.isCompleted
                          ? Colors.green[50]
                          : Colors.grey[50],
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      lesson.isCompleted ? Icons.check : Icons.play_arrow,
                      color: lesson.isCompleted ? Colors.green : Colors.grey,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          lesson.title,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          lesson.duration,
                          style: TextStyle(
                            color: Colors.grey[600],
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ),
                  // Icon(
                  //   Icons.star_border,
                  //   color: Colors.grey[400],
                  // ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
