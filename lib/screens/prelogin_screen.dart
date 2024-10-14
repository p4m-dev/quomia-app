import 'package:flutter/material.dart';
import 'package:peekforme/screens/home_screen.dart';
import 'package:peekforme/screens/login_screen.dart';
import 'package:peekforme/widgets/mobile/prelogin/gradient_button.dart';
import 'package:peekforme/widgets/mobile/prelogin/intro_widget.dart';
import 'package:video_player/video_player.dart';

class PreLoginScreen extends StatefulWidget {
  const PreLoginScreen({super.key});

  @override
  _PreLoginScreenState createState() => _PreLoginScreenState();
}

class _PreLoginScreenState extends State<PreLoginScreen> {
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
    return Scaffold(
      backgroundColor: const Color(0xFFE0E0E0),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const IntroWidget(),
          Container(
              height: 380,
              margin: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16), color: Colors.white),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Stack(
                    children: [
                      _videoController.value.isInitialized
                          ? Padding(
                              padding:
                                  const EdgeInsets.fromLTRB(15, 15, 15, 20),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(16),
                                child: AspectRatio(
                                  aspectRatio:
                                      _videoController.value.aspectRatio,
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
                          ),
                        ),
                      )
                    ],
                  ),
                  GradientButton(
                    buttonText: 'Sei già iscritto?',
                    onPress: () {
                      showModalBottomSheet(
                          context: context,
                          builder: (BuildContext context) {
                            return SizedBox.expand(
                              child: Center(
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    const Text("Peekforme"),
                                    GradientButton(
                                        buttonText: 'Accedi',
                                        onPress: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      const LoginScreen()));
                                        }),
                                    ElevatedButton(
                                        onPressed: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      const HomeScreen()));
                                        },
                                        child: const Text("Registrati"))
                                  ],
                                ),
                              ),
                            );
                          });
                    },
                  ),
                ],
              )),
        ],
      ),
    );
  }
}
