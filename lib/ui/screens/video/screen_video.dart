import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kiddopia/classes/enums/enums.dart';
import 'package:kiddopia/classes/models/video_model.dart';
import 'package:kiddopia/constants/constant.dart';
import 'package:kiddopia/main.dart';
import 'package:kiddopia/ui/common/widgets/image_button.dart';
import 'package:kiddopia/ui/common/widgets/playlist_sheet.dart';
import 'package:kiddopia/ui/common/widgets/progress.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:video_player/video_player.dart';
import 'package:flutter/material.dart';

class ScreenVideo extends ConsumerWidget {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  ScreenVideo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final notifier = watch(videoPod);
    if (notifier.state == NotifierState.initial && notifier.controller == null) {
      notifier.initController(context);
    }
    return Scaffold(
      key: _scaffoldKey,
      body: notifier.state == NotifierState.done
          ? _VideoUI(notifier.controller!)
          : Image.asset(kImageLoading, width: double.maxFinite, height: double.maxFinite),
    );
  }
}

class _VideoUI extends ConsumerWidget {
  final VideoPlayerController controller;

  const _VideoUI(this.controller, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final notifier = watch(videoPod);

    _playVideo(Video model) {
      notifier.model = model;
      notifier.initController(context);
    }

    _exit() => Navigator.pop(context);
    _togglePlay() => notifier.togglePause();

    return ZStack(
      [
        AspectRatio(
          child: VideoPlayer(controller),
          aspectRatio: controller.value.aspectRatio,
        ),
        ImageButton(kImagePause, () => notifier.togglePause()).objectBottomRight().p(80.h),
        if (!notifier.isPlaying) PlaylistSheet(_playVideo, _exit, _togglePlay),
      ],
      fit: StackFit.expand,
    ).centered();
  }
}
