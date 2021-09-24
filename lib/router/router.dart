import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kiddopia/classes/models/video_model.dart';
import 'package:kiddopia/main.dart';
import 'package:kiddopia/ui/screens/dashboard/screen_dashboard.dart';
import 'package:kiddopia/ui/screens/video/screen_video.dart';

const kRouteVideo = '/video';
const kRouteDefault = '/dashboard';

Future gotoDefault(BuildContext context) async {
  await Navigator.pushNamed(context, kRouteDefault);
}

Future gotoVideo(BuildContext context, Video model) async {
  final notifier = context.read(videoPod);
  await notifier.reset();
  notifier.model = model;
  await Navigator.pushNamed(context, kRouteVideo);
}

final routes = {
  kRouteVideo: (_) => ScreenVideo(),
  kRouteDefault: (_) => const ScreenDashboard(),
};
