import 'package:flutter/material.dart';
import 'package:repositories_searcher/theme/colors/app_colors.dart';
import 'package:repositories_searcher/widgets/reusable_widgets/svg_picture_form_asset.dart';

class MyIconButton extends StatelessWidget {
  final String icon;
  final VoidCallback onTap;

  const MyIconButton({
    super.key,
    required this.icon,
    required this.onTap,
  });

  static const double radius = 12.0;
  static const double height = 44;
  static const double width = 44;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.all(
        Radius.circular(radius),
      ),
      child: InkWell(
        onTap: onTap,
        child: ColoredBox(
          color: AppColors.accentPrimary,
          child: SizedBox(
            height: height,
            width: width,
            child: Center(
              child: SvgPictureFromAsset(
                iconString: icon,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
