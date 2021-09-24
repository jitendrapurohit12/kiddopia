import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kiddopia/app/kiddopia_app.dart';
import 'package:kiddopia/notifier/dashboard_notifier.dart';
import 'package:kiddopia/notifier/video_notifier.dart';

final videoPod = ChangeNotifierProvider((_) => VideoNotifier());
final dashboardPod = ChangeNotifierProvider((_) => DashboardNotifier());
Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.landscapeLeft,
    DeviceOrientation.landscapeRight,
  ]);

  runApp(const ProviderScope(child: KiddopiaApp()));
}
