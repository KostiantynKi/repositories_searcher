// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:repositories_searcher/bloc/cubit/favorite_cubit/favorite_cubit.dart';

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
        return ListTile(
          title: Text(repository.name),
          subtitle: Text(repository.owner),
          trailing: IconButton(
            icon: repository.isFavorite
                ? Icon(Icons.favorite)
                : Icon(Icons.favorite_border),
            onPressed: () {
              searcherCubit.toggleFavorite(repository);
            },
          ),
          onTap: () {},
        );
      },
    );
  }
}
