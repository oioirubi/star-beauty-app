import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:star_beauty_app/components/custom_container.dart';
import 'package:video_player/video_player.dart';


class VideoScreen extends StatefulWidget {
  final String title;
  final String videoURL;

  VideoScreen({super.key, required this.title, required this.videoURL});

  @override
  _VideoScreenState createState() => _VideoScreenState();
}

class _VideoScreenState extends State<VideoScreen>
    with SingleTickerProviderStateMixin {
  late VideoPlayerController _controller;

  // Animation controller and animation
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;
  bool _showIcon = false;

  // Video managment values
  bool _isPlaying = false;
  bool _isVideoInitialized = false;
  double _volume = 1.0; // Default volume (1.0 = max, 0.0 = muted)

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.network(
      widget.videoURL ?? '',
    )..initialize().then(
        (_) {
          setState(() {
            _isVideoInitialized = true;
            _controller.addListener(_updateCustomProgressIndicator);
          });
        },
      );

    // Initialize animation controller
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 200), // Animation duration
    );

    // Define the scale animation
    _scaleAnimation = Tween<double>(begin: 1.0, end: 1.2).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeInOut,
      ),
    );

    // Listen for animation completion
    _animationController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        setState(() {
          _showIcon = false; // Hide the icon after animation completes
        });
      }
    });
  }

  @override
  void dispose() {
    _controller.removeListener(_updateCustomProgressIndicator);
    _controller.dispose();
    _animationController.dispose(); // Dispose the animation controller
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CustomContainer(
      child: Row(
        children: [
          // Main content area (video and controls)
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildVideoScreen(),
                Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: IconButton(
                          onPressed: _togglePausedPlayingState,
                          icon: _isPlaying
                              ? const Icon(Icons.play_arrow)
                              : const Icon(Icons.stop)),
                    ),
                    // Video controls
                    Expanded(flex: 9, child: _buildCustomProgressIndicator()),
                    Slider(
                      value: _volume,
                      min: 0.0,
                      max: 1.0,
                      onChanged: (value) {
                        setState(() {
                          _volume = value;
                          _controller.setVolume(_volume); // Update volume
                        });
                      },
                    ),
                  ],
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
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCustomProgressIndicator() {
    return Container(
      height: 20, // Adjust the height of the progress indicator
      child: Slider(
        value: _controller.value.position.inSeconds.toDouble(),
        min: 0.0,
        max: _controller.value.duration.inSeconds.toDouble(),
        onChanged: (value) {
          setState(() {
            _controller.seekTo(Duration(seconds: value.toInt()));
          });
        },
        onChangeEnd: (value) {
          // Optional: Perform actions when the user stops dragging
        },
        activeColor: Colors.deepPurple, // Color of the played portion
        inactiveColor: Colors.grey.shade800, // Color of the unplayed portion
        thumbColor: Colors.deepPurple, // Color of the handle (thumb)
      ),
    );
  }

  void _togglePausedPlayingState() {
    setState(() {
      _isPlaying = !_isPlaying;
      _isPlaying ? _controller.play() : _controller.pause();
      _showIcon = true;
    });

    // Trigger the splash animation
    _animationController.forward().then((_) {
      _animationController
          .reverse(); // Reverse the animation after it completes
    });
  }

  _buildVideoScreen() {
    return AspectRatio(
      aspectRatio: 16 / 9,
      child: _isVideoInitialized
          ? Stack(
              alignment: Alignment.center,
              children: [
                VideoPlayer(_controller),
                // Animated play/pause icon
                ScaleTransition(
                  scale: _scaleAnimation,
                  child: _showIcon
                      ? Icon(
                          _isPlaying ? Icons.pause : Icons.play_arrow,
                          color: Colors.white,
                          size: 50,
                        )
                      : Container(),
                ),
                GestureDetector(
                  onTap: _togglePausedPlayingState, // Toggle play/pause on tap
                  child: Container(
                    color: Colors.transparent, // Transparent container
                  ),
                ),
              ],
            )
          : Container(),
    );
  }

  void _updateCustomProgressIndicator() {
    if (mounted) {
      setState(() {});
    }
  }
}
