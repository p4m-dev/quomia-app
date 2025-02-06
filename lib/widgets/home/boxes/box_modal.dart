import 'package:audioplayers/audioplayers.dart';
import 'package:better_player/better_player.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:quomia/designSystem/gap.dart';
import 'package:quomia/designSystem/image.dart';
import 'package:quomia/designSystem/label.dart';
import 'package:quomia/designSystem/text_form_field.dart';
import 'package:quomia/models/box/box.dart';
import 'package:quomia/models/box/content.dart';
import 'package:quomia/models/box/info.dart';
import 'package:quomia/utils/app_colors.dart';

class BoxModal extends StatefulWidget {
  final Box box;

  const BoxModal({super.key, required this.box});

  @override
  State<BoxModal> createState() => _BoxModalState();
}

class _BoxModalState extends State<BoxModal> {
  late BetterPlayerController _betterPlayerController;
  final chatController = TextEditingController();
  final AudioPlayer _audioPlayer = AudioPlayer();
  bool isPlaying = false;
  final itemHeight = 500.0;

  @override
  void initState() {
    super.initState();
    BetterPlayerDataSource dataSource = BetterPlayerDataSource(
        BetterPlayerDataSourceType.network,
        widget.box.content.downloadUrl ?? '',
        cacheConfiguration:
            const BetterPlayerCacheConfiguration(useCache: true));

    _betterPlayerController = BetterPlayerController(
        const BetterPlayerConfiguration(
            aspectRatio: 16 / 9,
            autoPlay: true,
            looping: false,
            controlsConfiguration: BetterPlayerControlsConfiguration(
                enableSkips: true,
                enablePlaybackSpeed: true,
                showControls: true,
                enableFullscreen: true)));

    _betterPlayerController.setupDataSource(dataSource);
  }

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: 0.95,
      minChildSize: 0.5,
      maxChildSize: 1.0,
      builder: (context, scrollController) {
        return Container(
          decoration: BoxDecoration(
            color: AppColors.light.primaryBackground,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: AppBar(
                  backgroundColor: Colors.white,
                  elevation: 0,
                  title: Label(
                    data: widget.box.user.sender,
                    color: AppColors.light.primary,
                    fontSize: 22.0,
                    fontWeight: FontWeight.bold,
                  ),
                  centerTitle: true,
                  leading: IconButton(
                    icon: Icon(Icons.close, color: AppColors.light.primaryText),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Column(
                  children: [
                    const Gap(
                      height: 16.0,
                    ),
                    _timerRow(),
                    const Gap(
                      height: 16.0,
                    ),
                    Align(
                        alignment: Alignment.topLeft,
                        child: Label(
                          data: widget.box.info.title,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        )),
                    const Gap(
                      height: 10.0,
                    ),
                    _boxContent(widget.box.content),
                    const Gap(
                      height: 10.0,
                    ),
                    Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: _quickActionsRow(widget.box.info)),
                    const Gap(
                      height: 10.0,
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
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
                                    icon: Icon(
                                      Icons.send,
                                      color: AppColors.light.primaryText,
                                      size: 24,
                                    ))),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
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
            const Label(
              data: 'Tempo',
              fontSize: 12,
              fontWeight: FontWeight.w500,
            ),
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

  Widget _boxContent(Content content) {
    switch (content.fileType) {
      case FileType.image:
        return _imageContent(content.downloadUrl!, content.imageBlurhash!);
      case FileType.video:
        return _videoContent(content.downloadUrl!);
      case FileType.any:
        return _textContent(widget.box.info.title, content.message!);
      case FileType.audio:
        return _audioContent(content.downloadUrl!);
      default:
        return const Gap();
    }
  }

  Widget _textContent(String title, String message) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: itemHeight,
      decoration: BoxDecoration(
        color: AppColors.light.background,
        borderRadius: BorderRadius.circular(16),
      ),
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Gap(
                height: 10.0,
              ),
              Label(
                data: message,
                color: AppColors.light.primaryText,
                fontSize: 14,
                fontWeight: FontWeight.w400,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _imageContent(String downloadUrl, String imageBlurhash) {
    return CustomImage(
        width: MediaQuery.of(context).size.width,
        height: itemHeight,
        imageUrl: downloadUrl,
        blurHash: imageBlurhash);
  }

  Widget _videoContent(String downloadUrl) {
    return ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: SizedBox(
            width: MediaQuery.of(context).size.width,
            height: 200,
            child: BetterPlayer(controller: _betterPlayerController)));
  }

  Widget _audioContent(String downloadUrl) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          width: MediaQuery.of(context).size.width,
          height: itemHeight,
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
                      await _audioPlayer.play(UrlSource(downloadUrl));
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
