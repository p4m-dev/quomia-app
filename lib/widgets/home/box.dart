import 'dart:ui';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:quomia/designSystem/gap.dart';
import 'package:quomia/designSystem/label.dart';
import 'package:quomia/designSystem/text_form_field.dart';
import 'package:quomia/models/box/box.dart';
import 'package:quomia/models/box/content.dart';
import 'package:quomia/models/box/file_type.dart';
import 'package:quomia/models/box/info.dart';
import 'package:quomia/utils/app_colors.dart';
import 'package:video_player/video_player.dart';

class BoxWidget extends StatefulWidget {
  final Box box;

  const BoxWidget({super.key, required this.box});

  @override
  State<BoxWidget> createState() => _BoxWidgetState();
}

class _BoxWidgetState extends State<BoxWidget> {
  final chatController = TextEditingController();
  late VideoPlayerController _videoController;
  final AudioPlayer _audioPlayer = AudioPlayer();
  bool isPlaying = false;

  @override
  void initState() {
    super.initState();
    _videoController = VideoPlayerController.networkUrl(Uri(
        path:
            'https://firebasestorage.googleapis.com/v0/b/quomia.appspot.com/o/files%2FSimone%20Zanetti%2Fvideo%2F3195394-uhd_3840_2160_25fps.mp4?alt=media&token=393b02bd-07d4-4331-946d-5f8fde19eee6'))
      ..initialize().then((_) {
        setState(() {});
      }).catchError((error) {
        print('Errore durante il caricamento del video: $error');
      });
    ;
  }

  @override
  void dispose() {
    chatController.dispose();
    _videoController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 570,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          Padding(padding: const EdgeInsets.all(16.0), child: _timerRow()),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: _buildBoxContent(widget.box.content),
          ),
          Padding(
              padding: const EdgeInsets.fromLTRB(30, 10, 10, 10),
              child: _quickActionsRow(widget.box.info)),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                _avatar('SM'),
                const Gap(
                  width: 10.0,
                ),
                Expanded(
                  child: SizedBox(
                    width: double.infinity,
                    child: CustomTextFormField(
                        controller: chatController,
                        hintText: 'Scrivi un commento...',
                        textInput: TextInputType.text,
                        hasSuffixIcon: true,
                        suffixIcon: IconButton(
                            onPressed: () {},
                            icon: const Icon(
                              Icons.emoji_emotions,
                              color: Colors.black,
                              size: 24,
                            ))),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _quickActionsRow(Info info) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      mainAxisSize: MainAxisSize.max,
      children: [
        Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            IconButton(
                onPressed: () {},
                icon: FaIcon(
                  FontAwesomeIcons.heart,
                  color: AppColors.light.primaryText,
                  size: 24,
                )),
            Label(data: info.likes.toString())
          ],
        ),
        Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            IconButton(
                onPressed: () {},
                icon: FaIcon(
                  FontAwesomeIcons.comment,
                  color: AppColors.light.primaryText,
                  size: 24,
                )),
            Label(data: info.comments.totalOfComments.toString()),
          ],
        ),
        Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            IconButton(
                onPressed: () {},
                icon: FaIcon(
                  FontAwesomeIcons.clock,
                  color: AppColors.light.primaryText,
                  size: 24,
                )),
          ],
        ),
      ],
    );
  }

  Widget _timerRow() {
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        _avatar('SZ'),
        const Gap(
          width: 20,
        ),
        Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Label(
                data: widget.box.user.sender,
                fontSize: 18,
                fontWeight: FontWeight.bold),
            Label(
              data: widget.box.user.location,
              fontSize: 14,
              fontWeight: FontWeight.w300,
            ),
          ],
        ),
        const Spacer(),
        IconButton(
          tooltip: 'Apri menu box',
          icon: Icon(
            Icons.keyboard_control,
            color: AppColors.light.primaryText,
          ),
          onPressed: () {},
        )
      ],
    );
  }

  Widget _avatar(String data) {
    return CircleAvatar(
      radius: 25,
      backgroundColor: AppColors.light.secondary,
      child:
          Label(data: data, fontSize: 20, color: AppColors.light.primaryText),
    );
  }

  Widget _buildBoxContent(Content content) {
    if (content.fileType == FileType.image) {
      return _buildImageContent(content.filePath!);
    } else if (content.fileType == FileType.video) {
      _videoController =
          VideoPlayerController.networkUrl(Uri(path: content.filePath));

      return _videoController.value.isInitialized
          ? Padding(
              padding: const EdgeInsets.all(16.0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: AspectRatio(
                  aspectRatio: _videoController.value.aspectRatio,
                  child: VideoPlayer(_videoController),
                ),
              ),
            )
          : const SizedBox(
              width: 350, height: 300, child: CircularProgressIndicator());
    } else if (content.fileType == FileType.text) {
      return _buildTextContent(content.message!);
    } else if (content.fileType == FileType.audio) {
      return _buildAudioPlayer(content.filePath!);
    }
    return const Gap();
  }

  Widget _buildTextContent(String message) {
    return SizedBox(
      width: 350,
      height: 300,
      child: Label(data: message),
    );
  }

  Widget _buildImageContent(String filePath) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(16),
      child: Image.network(
        filePath,
        width: 350,
        height: 300,
        fit: BoxFit.cover,
      ),
    );
  }

  Widget _buildAudioPlayer(String filePath) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          width: 350,
          height: 300,
          child: Stack(
            children: [
              Positioned.fill(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: Image(
                    image: const AssetImage(
                        'assets/images/audio-record-image-placeholder.png'),
                    fit: BoxFit.cover,
                    color: Colors.black.withOpacity(0.6),
                    colorBlendMode: BlendMode.darken,
                  ),
                ),
              ),
              Align(
                alignment: Alignment.center,
                child: IconButton(
                  icon: Icon(
                    isPlaying ? Icons.pause : Icons.play_arrow,
                    color: Colors.white,
                    size: 64.0,
                  ),
                  onPressed: () async {
                    if (isPlaying) {
                      await _audioPlayer.pause();
                    } else {
                      await _audioPlayer.play(UrlSource(filePath));
                    }
                    setState(() {
                      isPlaying = !isPlaying;
                    });
                  },
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
