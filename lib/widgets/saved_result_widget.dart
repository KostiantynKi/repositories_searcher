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

    return SizedBox(
      height: MediaQuery.of(context).size.height / 2,
      child: ListView.builder(
        itemCount: widget.state.savedRequests.length,
        itemBuilder: (context, index) {
          final repository = widget.state.savedRequests[index];
          return SerchCard(
            text: repository.name,
            onTap: () {
              searcherCubit.toggleFavorite(repository);
            },
            isFavorite: repository.isFavorite,
          );
        },
      ),
    );
  }
}
