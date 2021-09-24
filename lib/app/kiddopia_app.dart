import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kiddopia/router/router.dart';

class KiddopiaApp extends StatelessWidget {
  const KiddopiaApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(1080, 1920),
      builder: () => MaterialApp(routes: routes, initialRoute: kRouteDefault),
    );
  }
}
