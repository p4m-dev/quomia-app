import 'package:flutter/material.dart';
import 'package:quomia/designSystem/gap.dart';
import 'package:quomia/widgets/common/avatar_placeholder.dart';
import 'package:quomia/widgets/common/button_placeholder.dart';
import 'package:quomia/widgets/common/placeholder.dart';

class BoxWidgetPlaceholder extends StatelessWidget {
  const BoxWidgetPlaceholder({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 570,
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
            height: 10.0,
          ),
          const Align(
              alignment: Alignment.topLeft,
              child: ShimmerPlaceholder(width: 180, height: 20)),
          const Gap(
            height: 10.0,
          ),
          const Padding(
            padding: EdgeInsets.only(bottom: 16.0),
            child: ShimmerPlaceholder(width: 350, height: 300),
          ),
          Padding(
              padding: const EdgeInsets.fromLTRB(30, 10, 10, 10),
              child: _quickActionsRow()),
          // Padding(
          //   padding: const EdgeInsets.symmetric(horizontal: 16.0),
          //   child: Row(
          //     mainAxisSize: MainAxisSize.max,
          //     children: [
          //       _avatar('SM'),
          //       const Gap(
          //         width: 10.0,
          //       ),
          //       Expanded(
          //         child: SizedBox(
          //           width: double.infinity,
          //           child: CustomTextFormField(
          //               controller: chatController,
          //               hintText: 'Scrivi un commento...',
          //               textInput: TextInputType.text,
          //               hasSuffixIcon: true,
          //               suffixIcon: IconButton(
          //                   onPressed: () {},
          //                   icon: const Icon(
          //                     Icons.emoji_emotions,
          //                     color: Colors.black,
          //                     size: 24,
          //                   ))),
          //         ),
          //       ),
          //     ],
          //   ),
          // ),
        ],
      ),
    );
  }

  Widget _timerRow() {
    return const Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        AvatarPlaceholder(),
        Gap(
          width: 20,
        ),
        Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ShimmerPlaceholder(
              width: 120,
              height: 20,
            ),
            Gap(
              height: 10.0,
            ),
            ShimmerPlaceholder(
              width: 100,
              height: 20,
            ),
          ],
        ),
      ],
    );
  }

  Widget _quickActionsRow() {
    Column column = const Column(
      mainAxisSize: MainAxisSize.max,
      children: [
        ButtonPlaceholder(width: 16, height: 16, radius: 32),
        ShimmerPlaceholder(
          width: 30,
          height: 16,
        )
      ],
    );

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      mainAxisSize: MainAxisSize.max,
      children: [
        column,
        column,
        column,
      ],
    );
  }
}
