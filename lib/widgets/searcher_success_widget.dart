// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:repositories_searcher/bloc/cubit/searcher_cubit.dart';

class SearcherSuccessWidget extends StatelessWidget {
  final SearcherSuccess state;

  const SearcherSuccessWidget({
    Key? key,
    required this.state,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SearcherCubit searcherCubit = BlocProvider.of<SearcherCubit>(context);

    return ListView.builder(
      itemCount: state.repositories.length,
      itemBuilder: (context, index) {
        final repository = state.repositories[index];
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
