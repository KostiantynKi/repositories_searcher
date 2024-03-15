import 'package:flutter/material.dart';
import 'package:repositories_searcher/bloc/cubit/searcher_cubit.dart';
import 'package:repositories_searcher/resource/app_icons.dart';
import 'package:repositories_searcher/widgets/reusable_widgets/icon_buttons.dart';
import 'package:repositories_searcher/widgets/reusable_widgets/search_cards.dart';
import 'package:repositories_searcher/widgets/reusable_widgets/svg_picture_form_asset.dart';

class SavedResultWidget extends StatelessWidget {
  final SavedRequests state;
  const SavedResultWidget({Key? key, required this.state}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SvgPictureFromAsset(
          iconString: AppIcons.search,
        ),
        const SvgPictureFromAsset(
          iconString: AppIcons.cancel,
        ),
        const SvgPictureFromAsset(
          iconString: AppIcons.disabledFavorite,
          color: Colors.amber,
        ),
        const SvgPictureFromAsset(
          iconString: AppIcons.favorite,
          color: Colors.amber,
        ),
        const SvgPictureFromAsset(
          iconString: AppIcons.left,
          color: Colors.amber,
        ),
        const SerchCard(),
        MyIconButton(
          icon: AppIcons.left,
          onTap: () {
            print('left');
          },
        ),
        const SizedBox(height: 10),
        MyIconButton(
          icon: AppIcons.favorite,
          onTap: () {
            print('favorite');
          },
        ),
      ],
    );
    // ListView.builder(
    //   itemCount: state.savedRequests.length,
    //   reverse: true,
    //   itemBuilder: (context, index) {
    //     final repository = state.savedRequests[index];
    //     return ListTile(
    //       title: Text(repository.name),
    //       subtitle: Text(repository.owner),
    //       trailing: IconButton(
    //         icon: repository.isFavorite
    //             ? Icon(Icons.favorite)
    //             : Icon(Icons.favorite_border),
    //         onPressed: () {},
    //       ),
    //       onTap: () {},
    //     );
    //   },
    // );
  }
}
