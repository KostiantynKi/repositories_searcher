import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:repositories_searcher/bloc/cubit/searcher_cubit.dart';

class MyTextField extends StatefulWidget {
  @override
  _MyTextFieldState createState() => _MyTextFieldState();
}

class _MyTextFieldState extends State<MyTextField> {
  @override
  Widget build(BuildContext context) {
    final SearcherCubit searcherCubit = BlocProvider.of<SearcherCubit>(context);

    return TextField(
      decoration: InputDecoration(
        hintText: 'Search repositories...',
      ),
      onSubmitted: (value) {
        searcherCubit.searchRepositories(value);
        // TODO: add a method that adds search text to history (savedRe)
      },
    );
  }
}
