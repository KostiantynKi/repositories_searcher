import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:repositories_searcher/bloc/cubit/searcher_cubit.dart';
import 'package:repositories_searcher/widgets/reusable_widgets/search_cards.dart';

class SavedResultWidget extends StatefulWidget {
  final SavedRequests state;

  const SavedResultWidget({Key? key, required this.state}) : super(key: key);

  @override
  State<SavedResultWidget> createState() => _SavedResultWidgetState();
}

class _SavedResultWidgetState extends State<SavedResultWidget> {
  @override
  Widget build(BuildContext context) {
    SearcherCubit searcherCubit = BlocProvider.of<SearcherCubit>(context);
    var text = 'Search History';

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
            itemCount: widget.state.savedRequests.length,
            itemBuilder: (context, index) {
              final reverceRepositoryList =
                  widget.state.savedRequests.reversed.toList();

              final repository = reverceRepositoryList[index];
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
