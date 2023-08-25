import 'package:flutter/material.dart';
import 'package:joyla/utils/colors/app_colors.dart';

class CustomCircularProgressIndicator extends StatelessWidget {
  final double? strokeWidth;

  const CustomCircularProgressIndicator({
    super.key,
    this.strokeWidth,
  });

  @override
  Widget build(BuildContext context) {
    if (strokeWidth == 3.0 || strokeWidth == null) {
      return CircularProgressIndicator(
        strokeWidth: 2,
        valueColor: AlwaysStoppedAnimation<Color>(AppColors.c_3669C9),
      );
    } else {
      return CircularProgressIndicator(
        strokeWidth: strokeWidth!,
        valueColor: AlwaysStoppedAnimation<Color>(AppColors.white),
      );
    }
  }
}
