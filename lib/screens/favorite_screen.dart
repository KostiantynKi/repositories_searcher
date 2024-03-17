import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:repositories_searcher/resource/app_icons.dart';
import 'package:repositories_searcher/widgets/favorite_widget.dart';
import 'package:repositories_searcher/widgets/reusable_widgets/icon_buttons.dart';

class FavoriteScreen extends StatelessWidget {
  static const String title = 'Favorite repos list';

  const FavoriteScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            title,
            style: Theme.of(context).textTheme.displayLarge,
          ),
          leading: Padding(
            padding: const EdgeInsets.all(8.0),
            child: SizedBox(
              child: MyIconButton(
                icon: AppIcons.left,
                onTap: () {
                  Navigator.pop(context);
                },
              ),
            ),
          ),
        ),
        body: const FavoriteWidget());
  }
}
