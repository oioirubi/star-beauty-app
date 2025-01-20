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
  List<String> categories = [
    "Ação",
    "Aventura",
    "Terror",
  ];
  List<String> catalogueItems = [
    "assets/images/imagemcategoria07.jpg",
    "assets/images/imagemcategoria06.jpg",
    "assets/images/imagemcategoria05.jpg",
    "assets/images/imagemcategoria04.jpg",
    "assets/images/imagemcategoria03.jpg",
    "assets/images/imagemcategoria02.jpg",
    "assets/images/imagemcategoria01.jpg",
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: List.generate(categories.length, (idx) {
        return _buildCategory(context, categories[idx]);
      }),
    );
  }

  Widget _buildCategory(BuildContext context, String category) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            category,
            style: const TextStyle(
              color: Colors.black,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Container(
          // Changed from SizedBox to Container
          height: 300,
          width: double.infinity, // Added explicit width
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: catalogueItems.length,
            physics: const BouncingScrollPhysics(), // Added scroll physics
            padding: const EdgeInsets.symmetric(horizontal: 8), // Added padding
            itemBuilder: (context, index) {
              return _buildCatalogueItem(context, catalogueItems[index]);
            },
          ),
        ),
      ],
    );
  }

  Widget _buildCatalogueItem(BuildContext context, String imagePath) {
    return Container(
      // Wrapped in Container for more control
      margin: const EdgeInsets.only(right: 8), // Added margin between items
      width: 250,
      child: ClipRRect(
          borderRadius: BorderRadius.circular(8.0),
          child: ElevatedButton(
            onPressed: () {
              context.go("/course_screen");
            },
            child: Image.asset(
              imagePath,
              width: 250,
              height: 300, // Added explicit height
              fit: BoxFit.cover,
            ),
          )),
    );
  }
}

// class VideoPlayerWidget extends StatefulWidget {
//   final String videoUrl;

//   const VideoPlayerWidget({required this.videoUrl});

//   @override
//   _VideoPlayerWidgetState createState() => _VideoPlayerWidgetState();
// }

// class _VideoPlayerWidgetState extends State<VideoPlayerWidget> {
//   late VideoPlayerController _controller;

//   @override
//   void initState() {
//     super.initState();
//     _controller = VideoPlayerController.asset(widget.videoUrl)
//       ..initialize().then((_) {
//         setState(() {});
//         _controller.play();
//       });
//   }

//   @override
//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Center(
//       child: _controller.value.isInitialized
//           ? AspectRatio(
//               aspectRatio: _controller.value.aspectRatio,
//               child: VideoPlayer(_controller),
//             )
//           : CircularProgressIndicator(),
//     );
//   }
// }
