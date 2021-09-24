import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Progress extends StatelessWidget {
  final Color? color;

  const Progress({Key? key, this.color = Colors.white}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const iOS = CupertinoActivityIndicator();
    final android = CircularProgressIndicator(strokeWidth: 2, color: color);

    return Center(child: Platform.isIOS ? iOS : android);
  }
}
