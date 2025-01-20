import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:star_beauty_app/components/custom_container.dart';

class Starflix extends StatefulWidget {
  const Starflix({super.key});

  @override
  State<Starflix> createState() => _StarflixState();
}

class _StarflixState extends State<Starflix> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 40),
        // Top Section - "Inicio"
        // Container(
        //   padding: const EdgeInsets.symmetric(vertical: 8.0),
        //   child: Text(
        //     'Início',
        //     style: TextStyle(
        //       color: Colors.orange[800],
        //       fontSize: 16,
        //     ),
        //   ),
        // ),
        // "Primeiros Passos" Section
        _buildCourseChapter(
          title: "Curso Joana Arisel",
          cards: [
            'cap 1',
            'cap 2',
            'cap 3',
            'cap 4',
          ],
          color: Colors.blue,
        ),
        const SizedBox(height: 40),
        _buildCourseChapter(
          title: "Curso Joana Arisel",
          cards: [
            'cap 1',
            'cap 2',
            'cap 3',
            'cap 4',
          ],
          color: Colors.purple,
        ),
        const SizedBox(height: 40),
        _buildCourseChapter(
          title: "Curso Joana Arisel",
          cards: [
            'cap 1',
            'cap 2',
            'cap 3',
            'cap 4',
          ],
          color: Colors.red,
        ),
        const SizedBox(height: 40),
        _buildCourseChapter(
          title: "Curso Joana Arisel",
          cards: [
            'cap 1',
            'cap 2',
            'cap 3',
            'cap 4',
          ],
          color: Colors.green,
        ),
      ],
    );
  }

  Widget _buildCourseCard(String title, {Color color = Colors.deepOrange}) {
    return TextButton(
      onPressed: () {
        context.go("/course_screen");
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
    required List<String> cards,
    required Color color,
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
                for (int i = 0; i < cards.length; i++)
                  _buildCourseCard(cards[i], color: color)
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Widget _buildCourseCard(String title, Color color) {
  //   return Container(
  //     decoration: BoxDecoration(
  //       color: color,
  //       borderRadius: BorderRadius.circular(12),
  //     ),
  //     child: Stack(
  //       children: [
  //         Positioned(
  //           top: 16,
  //           left: 16,
  //           child: Image.asset(
  //             'assets/images/imagemcategoria01.jpg', // You'll need to add this asset
  //             width: 24,
  //             height: 24,
  //             color: Colors.white.withOpacity(0.8),
  //           ),
  //         ),
  //         Center(
  //           child: Padding(
  //             padding: const EdgeInsets.all(16.0),
  //             child: Text(
  //               title,
  //               textAlign: TextAlign.center,
  //               style: const TextStyle(
  //                 color: Colors.white,
  //                 fontSize: 16,
  //                 fontWeight: FontWeight.bold,
  //               ),
  //             ),
  //           ),
  //         ),
  //       ],
  //     ),
  //   );
  // }
}
