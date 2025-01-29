import 'package:flutter/material.dart';
import 'package:quomia/screens/login_screen.dart';
import 'package:quomia/screens/signup_screen.dart';
import 'package:quomia/theme/palette.dart';
import 'package:quomia/widgets/mobile/prelogin/gradient_button.dart';
import 'package:quomia/widgets/mobile/prelogin/intro_widget.dart';
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
      backgroundColor: AppColors.light.background,
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
                            color: Colors.black,
                          ),
                        ),
                      )
                    ],
                  ),
                  GradientButton(
                    buttonText: 'Sei già iscritto?',
                    onPress: () {
                      showModalBottomSheet(
                          backgroundColor: Colors.white,
                          context: context,
                          builder: (BuildContext context) {
                            return SizedBox.expand(
                              child: Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    const Padding(
                                      padding:
                                          EdgeInsets.fromLTRB(0, 20, 0, 50),
                                      child: Text("Quomia",
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 24,
                                              fontWeight: FontWeight.normal)),
                                    ),
                                    Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                            0, 0, 0, 30),
                                        child: GradientButton(
                                            buttonText: 'Accedi',
                                            onPress: () {
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          const LoginScreen()));
                                            })),
                                    ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 100, vertical: 15),
                                            backgroundColor:
                                                Colors.grey.shade300,
                                            shadowColor: Colors.transparent,
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(26))),
                                        onPressed: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      const SignupScreen()));
                                        },
                                        child: const Text(
                                          "Registrati",
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 18),
                                        ))
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
