import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kiddopia/classes/enums/enums.dart';
import 'package:kiddopia/constants/constant.dart';
import 'package:kiddopia/main.dart';
import 'package:kiddopia/router/router.dart';
import 'package:kiddopia/ui/common/widgets/app_network_image.dart';
import 'package:kiddopia/ui/common/widgets/page_indicator.dart';
import 'package:kiddopia/ui/common/widgets/progress.dart';
import 'package:velocity_x/velocity_x.dart';

class ScreenDashboard extends StatelessWidget {
  const ScreenDashboard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ph = context.percentHeight;
    return Scaffold(
      backgroundColor: kColorDashboardBackground,
      body: Consumer(
        builder: (context, watch, child) {
          final notifier = watch(dashboardPod);
          switch (notifier.state) {
            case NotifierState.initial:
              notifier.init();
              return const Progress();
            case NotifierState.done:
              return VStack([
                const TopUI(),
                const PageUI().expand(),
                const PageIndicatorUI(),
                (ph * 8).heightBox,
              ]);
          }
        },
      ),
    );
  }
}

class TopUI extends StatelessWidget {
  const TopUI({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ph = context.percentHeight;
    return VxBox(
      child: HStack(
        [Image.asset(kImageHome, height: ph * 10)],
        axisSize: MainAxisSize.max,
      ).pSymmetric(v: ph * 3, h: ph * 10),
    ).white.make();
  }
}

class PageIndicatorUI extends ConsumerWidget {
  const PageIndicatorUI({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final notifier = watch(dashboardPod);

    return PageIndicator(notifier.totalPage, notifier.page);
  }
}

class PageUI extends ConsumerWidget {
  const PageUI({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final notifier = watch(dashboardPod);
    return PageView.builder(
      itemCount: notifier.totalPage,
      physics: const BouncingScrollPhysics(),
      itemBuilder: (context, index) {
        return const GridUI();
      },
      onPageChanged: notifier.changePage,
    );
  }
}

class GridUI extends ConsumerWidget {
  const GridUI({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    watch(dashboardPod);
    final child = VStack(
      [for (int i = 0; i < 2; i++) GetRow(i)],
      alignment: MainAxisAlignment.center,
    );
    return child;
  }
}

class GetRow extends ConsumerWidget {
  final int rowNo;
  const GetRow(this.rowNo, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final ph = context.percentHeight * 3;
    final notifier = context.read(dashboardPod);
    final previousCount = notifier.page * 6;
    final index = previousCount + (3 * rowNo);
    final index1 = index < notifier.totalVideos ? index : null;
    final index2 = index + 1 < notifier.totalVideos ? index + 1 : null;
    final index3 = index + 2 < notifier.totalVideos ? index + 2 : null;
    final ui1 = ThumbnailUI(index1);
    final ui2 = ThumbnailUI(index2);
    final ui3 = ThumbnailUI(index3);
    return HStack(
      [ui1, ui2, ui3],
      alignment: MainAxisAlignment.spaceEvenly,
      axisSize: MainAxisSize.max,
    ).centered().py(ph / 2);
  }
}

class ThumbnailUI extends StatelessWidget {
  final int? index;
  const ThumbnailUI(this.index, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final sh = context.screenHeight;
    final height = sh * 0.3;
    final width = height * 1.3;
    final notifier = context.read(dashboardPod);
    final model = index != null ? notifier.model!.videos![index!] : null;

    _playVideo() {
      gotoVideo(context, model!);
    }

    if (model == null) return SizedBox(height: height, width: width);

    return model == notifier.model!.videos!.last
        ? Image.asset(kImageComingSoon, width: width, height: height)
        : AppNetworkImage(model.ktvThumbnailUrl!, width, height, () => _playVideo());
  }
}
