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
        _buildCourseChapter("Curso Joana Arisel", [
          'cap 1',
          'cap 2',
          'cap 3',
          'cap 4',
        ]),
        const SizedBox(height: 40),
        _buildCourseChapter("Curso Carlos Alberto", [
          'cap 1',
          'cap 2',
          'cap 3',
          'cap 4',
        ]),
        const SizedBox(height: 40),
        _buildCourseChapter("Curso Juju Melodramatica", [
          'cap 1',
          'cap 2',
          'cap 3',
          'cap 4',
        ]),
        const SizedBox(height: 40),
        _buildCourseChapter("Curso João de melo", [
          'cap 1',
          'cap 2',
          'cap 3',
          'cap 4',
        ]),
        // const SizedBox(height: 24),
        // // "Cursos Iane Ventura" Section
        // Row(
        //   children: [
        //     Text(
        //       'Cursos Iane Ventura',
        //       style: TextStyle(
        //         fontSize: 20,
        //         fontWeight: FontWeight.bold,
        //         color: Colors.grey[800],
        //       ),
        //     ),
        //     const SizedBox(width: 8),
        //     // Text(
        //     //   'Ver tudo →',
        //     //   style: TextStyle(
        //     //     color: Colors.orange[800],
        //     //     fontSize: 14,
        //     //   ),
        //     // ),
        //   ],
        // ),
        // const SizedBox(height: 16),
        // // Course Cards Grid
        // GridView.count(
        //   shrinkWrap: true,
        //   physics: const NeverScrollableScrollPhysics(),
        //   crossAxisCount: 2,
        //   mainAxisSpacing: 16,
        //   crossAxisSpacing: 16,
        //   childAspectRatio: 0.8,
        //   children: [
        //     _buildCourseCard('COMO TER\nRELACIONAMENTOS', Colors.red[900]!),
        //     _buildCourseCard('COMUNICAÇÃO', Colors.brown),
        //     _buildCourseCard('INTELIGÊNCIA\nEMOCIONAL', Colors.teal[700]!),
        //     _buildCourseCard('AUTOESTIMA', Colors.green[800]!),
        //   ],
        // ),
      ],
    );
  }

  Widget _buildCourseCard(String title) {
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
              Colors.orange[400]!,
              Colors.deepOrange[500]!,
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

  Widget _buildCourseChapter(String title, List<String> cards) {
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
                  _buildCourseCard(cards[i])
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
