import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:repositories_searcher/bloc/cubit/searcher_cubit.dart';
import 'package:repositories_searcher/resource/app_icons.dart';
import 'package:repositories_searcher/screens/favorite_screen.dart';
import 'package:repositories_searcher/widgets/reusable_widgets/custom_text_field.dart';
import 'package:repositories_searcher/widgets/reusable_widgets/icon_buttons.dart';
import 'package:repositories_searcher/widgets/saved_result_widget.dart';
import 'package:repositories_searcher/widgets/searcher_success_widget.dart';

class SearchScreen extends StatelessWidget {
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
                child: MyIconButton(
                  icon: AppIcons.favorite,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const FavoriteScreen()),
                    );
                  },
                ),
              )),
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
}
