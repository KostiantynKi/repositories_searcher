import 'package:flutter/material.dart';
import 'package:repositories_searcher/bloc/cubit/searcher_cubit.dart';

class SavedResultWidget extends StatelessWidget {
  final SavedRequests state;
  const SavedResultWidget({Key? key, required this.state}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: state.savedRequests.length,
      reverse: true,
      itemBuilder: (context, index) {
        final repository = state.savedRequests[index];
        return ListTile(
          title: Text(repository.name),
          subtitle: Text(repository.owner),
          trailing: IconButton(
            icon: repository.isFavorite
                ? Icon(Icons.favorite)
                : Icon(Icons.favorite_border),
            onPressed: () {},
          ),
          onTap: () {},
        );
      },
    );
  }
}
