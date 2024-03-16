import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:repositories_searcher/bloc/cubit/favorite_cubit/favorite_cubit.dart';
import 'package:repositories_searcher/widgets/reusable_widgets/search_cards.dart';

class FavoriteWidget extends StatelessWidget {
  final FavoriteLoaded state;

  const FavoriteWidget({
    Key? key,
    required this.state,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    FavoriteCubit searcherCubit = BlocProvider.of<FavoriteCubit>(context);

    return ListView.builder(
      itemCount: state.favorites.length,
      itemBuilder: (context, index) {
        final repository = state.favorites[index];
        repository.isFavorite = true;
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 4),
          child: SerchCard(
            text: repository.name,
            onTap: () {
              searcherCubit.toggleFavorite(repository);
            },
            isFavorite: repository.isFavorite,
          ),
        );
      },
    );
  }
}
