import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:velocity_x/velocity_x.dart';

class ImageButton extends StatelessWidget {
  final String path;
  final VoidCallback callback;
  const ImageButton(this.path, this.callback, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final buttonSize = 195.h;
    return Image.asset(path, width: buttonSize, height: buttonSize, fit: BoxFit.contain)
        .onTap(callback);
  }
}
