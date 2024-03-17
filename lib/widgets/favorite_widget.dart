import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:repositories_searcher/bloc/cubit/searcher_cubit.dart';
import 'package:repositories_searcher/model/repositories_model.dart';
import 'package:repositories_searcher/widgets/reusable_widgets/search_cards.dart';

class FavoriteWidget extends StatefulWidget {
  const FavoriteWidget({
    Key? key,
  }) : super(key: key);

  @override
  State<FavoriteWidget> createState() => _FavoriteWidgetState();
}

class _FavoriteWidgetState extends State<FavoriteWidget> {
  @override
  Widget build(BuildContext context) {
    SearcherCubit searcherCubit = BlocProvider.of<SearcherCubit>(context);

    return FutureBuilder<List<RepositoryModel>?>(
      future: searcherCubit.getFavoriteRepositories(),
      builder: (
        BuildContext context,
        AsyncSnapshot snapshot,
      ) {
        final List<RepositoryModel> itemList = snapshot.data ?? [];
        if (itemList.isEmpty) {
          return const EmptyFavorite();
        } else {
          return ListView.builder(
            itemCount: itemList.length,
            itemBuilder: (context, index) {
              final item = itemList[index];
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 4),
                child: SerchCard(
                  text: item.name,
                  onTap: () {
                    searcherCubit.removeFromFavorite(index);

                    setState(() {});
                  },
                  isFavorite: true,
                ),
              );
            },
          );
        }
      },
    );
  }
}

class EmptyFavorite extends StatelessWidget {
  const EmptyFavorite({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('You have no favorites.'),
          Text('Click on star while searching to add first favorite'),
        ],
      ),
    );
  }
}
