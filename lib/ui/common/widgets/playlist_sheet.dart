import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kiddopia/classes/models/video_model.dart';
import 'package:kiddopia/constants/constant.dart';
import 'package:kiddopia/main.dart';
import 'package:kiddopia/ui/common/widgets/app_network_image.dart';
import 'package:kiddopia/ui/common/widgets/image_button.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PlaylistSheet extends StatelessWidget {
  final Function(Video) selectCb;
  final VoidCallback backCb, resumeCb;
  const PlaylistSheet(this.selectCb, this.backCb, this.resumeCb, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final list = context.read(videoPod).playlist;
    final height = 380.h;
    final width = height * 1.6;
    final playHeight = 650.h;
    final paddingTop = 100.h;
    final paddingBottomPlayButton = 290.h;
    final sheetHeight = height + (2 * paddingTop);

    final playButton =
        Image.asset(kImagePlay, width: playHeight, height: playHeight).onTap(resumeCb);
    final backButton = ImageButton(kImageBack, () => backCb());

    return VxBox(
      child: VStack(
        [
          backButton.objectTopLeft().p(paddingTop),
          playButton.objectTopCenter().pOnly(bottom: paddingBottomPlayButton),
          VxBox(
            child: ListView.builder(
              itemCount: list.length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                final model = list[index];
                return AppNetworkImage(
                  model.ktvThumbnailUrl!,
                  width,
                  height,
                  () => selectCb(model),
                ).px16().py(paddingTop / 1.5);
              },
              physics: const BouncingScrollPhysics(),
            ),
          ).white.make().wFull(context).h(sheetHeight)
        ],
        axisSize: MainAxisSize.max,
      ),
    ).color(Colors.black45).make().whFull(context);
  }
}
