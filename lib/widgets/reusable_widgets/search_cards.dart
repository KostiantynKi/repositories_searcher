import 'package:flutter/material.dart';
import 'package:repositories_searcher/resource/app_icons.dart';
import 'package:repositories_searcher/theme/colors/app_colors.dart';
import 'package:repositories_searcher/widgets/reusable_widgets/svg_picture_form_asset.dart';

class SerchCard extends StatelessWidget {
  const SerchCard({super.key});

  static const double radius = 16.0;
  static const double height = 55;
  static const double paddingLeft = 16.0;
  static const double paddingRight = 22.0;

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 16),
      child: ClipRRect(
        borderRadius: BorderRadius.all(
          Radius.circular(radius),
        ),
        child: ColoredBox(
          color: AppColors.layer1,
          child: SizedBox(
            height: height,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  child: Padding(
                    padding: EdgeInsets.only(left: paddingLeft),
                    child: Text(
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      'dataafasda',
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(right: paddingRight),
                  child: SvgPictureFromAsset(
                    iconString: AppIcons.favorite,
                    color: Colors.amber,
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
