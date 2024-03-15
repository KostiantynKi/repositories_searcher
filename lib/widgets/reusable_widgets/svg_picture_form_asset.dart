import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SvgPictureFromAsset extends StatelessWidget {
  final String iconString;
  final double? height;
  final double? width;
  final Color? color;

  const SvgPictureFromAsset({
    required this.iconString,
    this.height = 24,
    this.width = 24,
    this.color,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      iconString,
      height: height,
      width: width,
      color: color,
    );
  }
}
