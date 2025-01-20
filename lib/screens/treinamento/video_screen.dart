import 'package:flutter/material.dart';
import 'package:star_beauty_app/components/custom_container.dart';
import 'package:video_player/video_player.dart';

class VideoScreen extends StatefulWidget {
  const VideoScreen({required this.videoURL, required this.title});
  final String videoURL;
  final String title;
  @override
  _VideoScreenState createState() => _VideoScreenState();
}

class _VideoScreenState extends State<VideoScreen> {
  late VideoPlayerController _controller;
  bool _isPlaying = false;

  @override
  void initState() {
    super.initState();
    // Initialize video player with a sample video URL
    _controller = VideoPlayerController.network(
      widget.videoURL,
    )..initialize().then((_) {
        setState(() {});
      });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CustomContainer(
      child: Row(
        children: [
          // Main content area (video and controls)
          Expanded(
            flex: 3,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Video player
                AspectRatio(
                  aspectRatio: 16 / 9,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      VideoPlayer(_controller),
                      // Play/Pause button overlay
                      IconButton(
                        icon: Icon(
                          _isPlaying ? Icons.pause : Icons.play_arrow,
                          size: 50,
                          color: Colors.white,
                        ),
                        onPressed: () {
                          setState(() {
                            _isPlaying = !_isPlaying;
                            _isPlaying
                                ? _controller.play()
                                : _controller.pause();
                          });
                        },
                      ),
                    ],
                  ),
                ),
                // Video controls
                VideoProgressIndicator(
                  _controller,
                  allowScrubbing: true,
                  colors: VideoProgressColors(
                    playedColor: Colors.red,
                    bufferedColor: Colors.grey,
                    backgroundColor: Colors.grey.shade800,
                  ),
                ),
                // Video title and metadata
                Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.title,
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      // Row(
                      //   children: [
                      //     Icon(Icons.visibility, color: Colors.grey, size: 16),
                      //     SizedBox(width: 4),
                      //     Text(
                      //       '1.2K views',
                      //       style: TextStyle(color: Colors.grey),
                      //     ),
                      //   ],
                      // ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          // Right sidebar with playlist
          // Container(
          //   width: 300,
          //   color: Colors.black54,
          //   child: ListView.builder(
          //     itemCount: 4,
          //     itemBuilder: (context, index) {
          //       return ListTile(
          //         leading: Container(
          //           width: 120,
          //           height: 67,
          //           decoration: BoxDecoration(
          //             color: Colors.grey.shade800,
          //             borderRadius: BorderRadius.circular(4),
          //           ),
          //         ),
          //         title: Text(
          //           'Video ${index + 1}',
          //           style: TextStyle(color: Colors.white),
          //         ),
          //         subtitle: Text(
          //           '${index + 1}K views',
          //           style: TextStyle(color: Colors.grey),
          //         ),
          //       );
          //     },
          //   ),
          // ),
        ],
      ),
    );
  }
}
