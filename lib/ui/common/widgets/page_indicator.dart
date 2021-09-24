import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

class PageIndicator extends StatelessWidget {
  final int index, total;
  const PageIndicator(this.total, this.index, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return HStack([
      for (int i = 0; i < total; i++) IndicatorUI(isSelected: i == index),
    ]).centered();
  }
}

class IndicatorUI extends StatelessWidget {
  final bool isSelected;
  const IndicatorUI({this.isSelected = false, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ph = context.percentHeight;
    final size = ph * 3;
    final color = isSelected ? Colors.white : Colors.white38;
    return VxBox().height(size).width(size).roundedFull.color(color).make().pSymmetric(h: ph * 1.8);
  }
}
