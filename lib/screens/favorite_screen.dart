import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:repositories_searcher/bloc/cubit/favorite_cubit/favorite_cubit.dart';
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
    final FavoriteCubit favoriteCubit = BlocProvider.of<FavoriteCubit>(context);

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
                print('left');
                Navigator.pop(context);
              },
            ),
          ),
        ),
      ),
      body: BlocBuilder<FavoriteCubit, FavoriteState>(
        builder: (context, state) {
          if (state is FavoriteLoaded) {
            return FavoriteWidget(state: state);
          } else if (state is FavoriteInitial) {
            favoriteCubit.getFavoriteRepositories();
            return Center(child: CircularProgressIndicator());
          } else
            return Container();
        },
      ),
    );
  }
}
