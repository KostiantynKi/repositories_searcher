// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:repositories_searcher/bloc/cubit/searcher_cubit.dart';
import 'package:repositories_searcher/widgets/reusable_widgets/search_cards.dart';

class SearcherSuccessWidget extends StatelessWidget {
  final SearcherSuccess state;

  const SearcherSuccessWidget({
    Key? key,
    required this.state,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SearcherCubit searcherCubit = BlocProvider.of<SearcherCubit>(context);
    const text = 'What we have found';

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(16),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              text,
              style: Theme.of(context).textTheme.labelLarge,
            ),
          ),
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.7,
          child: ListView.builder(
            itemCount: state.searchedRepositories.length,
            itemBuilder: (context, index) {
              final repository = state.searchedRepositories[index];
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
          ),
        ),
      ],
    );
  }
}
