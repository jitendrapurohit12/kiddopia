import 'package:flutter/material.dart';
import 'package:kiddopia/ui/common/widgets/progress.dart';
import 'package:velocity_x/velocity_x.dart';

class AppNetworkImage extends StatelessWidget {
  final String url;
  final double width, height;
  final VoidCallback callback;
  const AppNetworkImage(this.url, this.width, this.height, this.callback, {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ph = context.percentHeight;
    return SizedBox(
      width: width,
      height: height,
      child: Image.network(
        url,
        fit: BoxFit.cover,
        loadingBuilder: (context, child, loadingProgress) {
          if (loadingProgress == null) return child;
          return const Progress();
        },
        errorBuilder: (context, error, stackTrace) {
          print(stackTrace);
          return Icon(Icons.error, color: Colors.red, size: ph * 10);
        },
      ),
    ).onTap(callback);
  }
}
