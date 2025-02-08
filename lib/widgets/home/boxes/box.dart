import 'package:audioplayers/audioplayers.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:quomia/designSystem/gap.dart';
import 'package:quomia/designSystem/image.dart';
import 'package:quomia/designSystem/label.dart';
import 'package:quomia/designSystem/text_content.dart';
import 'package:quomia/designSystem/text_form_field.dart';
import 'package:quomia/models/box/box.dart';
import 'package:quomia/models/box/content.dart';
import 'package:quomia/models/box/info.dart';
import 'package:quomia/utils/app_colors.dart';
import 'package:quomia/widgets/home/boxes/box_modal.dart';

class BoxWidget extends StatefulWidget {
  final Box box;

  const BoxWidget({super.key, required this.box});

  @override
  State<BoxWidget> createState() => _BoxWidgetState();
}

class _BoxWidgetState extends State<BoxWidget> {
  final chatController = TextEditingController();
  final AudioPlayer _audioPlayer = AudioPlayer();
  bool isPlaying = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    chatController.dispose();
    _audioPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
        builder: (context) => BoxModal(
          box: widget.box,
        ),
      ),
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: 575,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
        ),
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
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
            _buildBoxContent(widget.box.content),
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
          ],
        ),
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

  Widget _buildBoxContent(Content content) {
    switch (content.fileType) {
      case FileType.image:
        return _buildImageContent(content.downloadUrl!, content.imageBlurhash!);
      case FileType.video:
        return _buildVideoContent(content.videoThumbnailUrl!);
      case FileType.any:
        return _buildTextContent(widget.box.info.title, content.message!);
      case FileType.audio:
        return _buildAudioContent(content.downloadUrl!);
      default:
        return const Gap();
    }
  }

  Widget _buildVideoContent(String videoThumbnailUrl) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          width: 350,
          height: 300,
          child: Stack(
            children: [
              Positioned.fill(
                child: CustomImage(
                    width: 350, height: 300, imageUrl: videoThumbnailUrl),
              ),
              const Align(
                alignment: Alignment.center,
                child: IconButton(
                  icon: Icon(
                    Icons.play_arrow,
                    color: Colors.white,
                    size: 64.0,
                  ),
                  onPressed: null,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildTextContent(String title, String message) {
    return Container(
      width: 350,
      height: 300,
      decoration: BoxDecoration(
        color: AppColors.light.background,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Gap(
              height: 10.0,
            ),
            TextContent(
              data: message,
              color: AppColors.light.primaryText,
              fontSize: 14,
              fontWeight: FontWeight.w400,
              maxLines: 12,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildImageContent(String downloadUrl, String imageBlurhash) {
    return CustomImage(
        width: 350,
        height: 300,
        imageUrl: downloadUrl,
        blurHash: imageBlurhash);
  }

  Widget _buildAudioContent(String downloadUrl) {
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
              const Align(
                alignment: Alignment.center,
                child: IconButton(
                    icon: Icon(
                      Icons.play_arrow,
                      color: Color.fromARGB(200, 255, 255, 255),
                      size: 64.0,
                    ),
                    onPressed: null),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
