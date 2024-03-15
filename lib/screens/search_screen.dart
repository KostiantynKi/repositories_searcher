import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:repositories_searcher/bloc/cubit/searcher_cubit.dart';
import 'package:repositories_searcher/model/repositories_model.dart';
import 'package:repositories_searcher/services/favorite_service.dart';
import 'package:repositories_searcher/widgets/my_text_field.dart';
import 'package:repositories_searcher/widgets/searcher_success_widget.dart';

class SearchScreen extends StatelessWidget {
  final FavoriteService _favoriteService = FavoriteService();

  @override
  Widget build(BuildContext context) {
    final SearcherCubit searcherCubit = BlocProvider.of<SearcherCubit>(context);

    return Scaffold(
      appBar: AppBar(
        title: Focus(
          onFocusChange: (hasFocus) {
            searcherCubit.cleanResult();
          },
          child: MyTextField(),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.favorite),
            onPressed: () {
              _showFavoriteRepositories(context);
            },
          ),
        ],
      ),
      body: BlocBuilder<SearcherCubit, SearcherState>(
        builder: (context, state) {
          if (state is SearcherInitial) {
            return Center(child: Text('SearcherInitial'));
          } else if (state is SearcherLoading) {
            return Center(child: CircularProgressIndicator());
          } else if (state is SearcherEmpty) {
            return Center(child: Container());
          } else if (state is SearcherFailure) {
            return Center(
              child: Text(state.errorMessage),
            );
          } else if (state is SearcherSuccess) {
            return SearcherSuccessWidget(
              state: state,
            );
          } else {
            return Container();
          }
        },
      ),
    );
  }

  void _showFavoriteRepositories(BuildContext context) async {
    final List<RepositoryModel> favorites =
        await _favoriteService.getFavoriteRepositories();
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Favorite Repositories'),
          content: SingleChildScrollView(
            child: Column(
              children: favorites
                  .map((repo) => ListTile(title: Text(repo.name)))
                  .toList(),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Close'),
            ),
          ],
        );
      },
    );
  }
}
