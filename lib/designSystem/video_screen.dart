import 'package:better_player/better_player.dart';
import 'package:flutter/material.dart';

class VideoScreen extends StatefulWidget {
  final String videoUrl;
  const VideoScreen({super.key, required this.videoUrl});

  @override
  State<VideoScreen> createState() => _VideoScreenState();
}

class _VideoScreenState extends State<VideoScreen> {
  late BetterPlayerController _betterPlayerController;

  @override
  void initState() {
    super.initState();
    BetterPlayerDataSource dataSource = BetterPlayerDataSource(
        BetterPlayerDataSourceType.network, widget.videoUrl,
        cacheConfiguration:
            const BetterPlayerCacheConfiguration(useCache: true));

    _betterPlayerController = BetterPlayerController(
        const BetterPlayerConfiguration(
            aspectRatio: 16 / 9,
            autoPlay: true,
            looping: false,
            controlsConfiguration: BetterPlayerControlsConfiguration(
                enableSkips: true, enablePlaybackSpeed: true)));

    _betterPlayerController.setupDataSource(dataSource);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Video Player"),
      ),
      body: Center(
        child: BetterPlayer(controller: _betterPlayerController),
      ),
    );
  }

  @override
  void dispose() {
    _betterPlayerController.dispose();
    super.dispose();
  }
}
