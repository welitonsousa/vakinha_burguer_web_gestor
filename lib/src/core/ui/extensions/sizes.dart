import 'package:flutter/material.dart';

extension Size on BuildContext {
  double get width => MediaQuery.of(this).size.width;
  double get height => MediaQuery.of(this).size.height;

  double widthPercent(double percent) => width * percent;
  double heightPercent(double percent) => height * percent;
}
