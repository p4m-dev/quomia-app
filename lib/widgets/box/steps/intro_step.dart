import 'package:flutter/material.dart';
import 'package:quomia/designSystem/subtitle.dart';
import 'package:quomia/designSystem/title.dart';
import 'package:video_player/video_player.dart';

class IntroStep extends StatefulWidget {
  const IntroStep({super.key});

  @override
  State<IntroStep> createState() => _IntroStepState();
}

class _IntroStepState extends State<IntroStep> {
  late VideoPlayerController _videoController;

  @override
  void initState() {
    super.initState();
    _videoController =
        VideoPlayerController.asset('assets/videos/sample_video.mp4')
          ..initialize().then((_) {
            setState(() {});
          });
  }

  @override
  void dispose() {
    _videoController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const CustomTitle(data: 'Introduzione'),
          const Subtitle(
              data:
                  'Scopri le potenzialità di Quomia attraverso questo video introduttivo.'),
          Stack(
            children: [
              _videoController.value.isInitialized
                  ? Padding(
                      padding: const EdgeInsets.fromLTRB(15, 15, 15, 20),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(16),
                        child: AspectRatio(
                          aspectRatio: _videoController.value.aspectRatio,
                          child: VideoPlayer(_videoController),
                        ),
                      ),
                    )
                  : const Center(child: CircularProgressIndicator()),
              Positioned(
                bottom: 100,
                right: 160,
                child: FloatingActionButton(
                  backgroundColor: Colors.transparent,
                  elevation: 0,
                  shape: const CircleBorder(),
                  onPressed: () {
                    setState(() {
                      _videoController.value.isPlaying
                          ? _videoController.pause()
                          : _videoController.play();
                    });
                  },
                  child: Icon(
                    _videoController.value.isPlaying
                        ? Icons.pause
                        : Icons.play_arrow,
                    color: Colors.black,
                  ),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
