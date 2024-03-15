import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:repositories_searcher/bloc/cubit/searcher_cubit.dart';
import 'package:repositories_searcher/model/repositories_model.dart';
import 'package:repositories_searcher/resource/app_icons.dart';
import 'package:repositories_searcher/services/favorite_service.dart';
import 'package:repositories_searcher/widgets/reusable_widgets/custom_text_field.dart';
import 'package:repositories_searcher/widgets/reusable_widgets/icon_buttons.dart';
import 'package:repositories_searcher/widgets/saved_result_widget.dart';
import 'package:repositories_searcher/widgets/searcher_success_widget.dart';

class SearchScreen extends StatelessWidget {
  final FavoriteService _favoriteService = FavoriteService();
  static const String title = 'Github repos list';

  @override
  Widget build(BuildContext context) {
    final SearcherCubit searcherCubit = BlocProvider.of<SearcherCubit>(context);
    TextEditingController _textController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: Text(
          title,
          style: Theme.of(context).textTheme.displayLarge,
        ),
        actions: [
          Padding(
              padding: const EdgeInsets.all(8),
              child: SizedBox(
                width: 44,
                // height: 44,
                child: MyIconButton(
                  icon: AppIcons.favorite,
                  onTap: () {
                    // todo сделать тут навигацию, которая ведет к новому экрану (виджут)
                    // todo где будет список избранного
                    print('favorite');
                  },
                ),
              )
              // IconButton(
              //   icon: Icon(Icons.favorite),
              //   onPressed: () {
              //     _showFavoriteRepositories(context);
              //   },
              // ),
              ),
        ],
      ),
      body: Column(
        children: [
          Focus(
            onFocusChange: (hasFocus) {
              print('hasFocus ${hasFocus}');
              searcherCubit.cleanResult();
            },
            child: CustomTextField(
              hintText: 'Search',
              controller: _textController,
            ),
            // MyTextField(),
          ),
          BlocBuilder<SearcherCubit, SearcherState>(
            builder: (context, state) {
              if (state is SearcherInitial) {
                searcherCubit.getSavedRequests();
                return Center(child: CircularProgressIndicator());
              } else if (state is SavedRequests) {
                return Center(child: SavedResultWidget(state: state));
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
        ],
      ),
    );
  }

  void _showFavoriteRepositories(BuildContext context) async {
    final List<RepositoryModel> favorites = await _favoriteService
        .getFavoriteRepositories(); // change to call cubit, not Service
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
