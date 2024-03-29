import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:repositories_searcher/bloc/cubit/searcher_cubit.dart';
import 'package:repositories_searcher/resource/app_icons.dart';
import 'package:repositories_searcher/theme/colors/app_colors.dart';
import 'package:repositories_searcher/widgets/reusable_widgets/svg_picture_form_asset.dart';

class CustomTextField extends StatefulWidget {
  final String? titleText;
  final String? hintText;
  final String? name;
  final TextEditingController? controller;
  final Function? onChanged;
  CustomTextField({
    Key? key,
    this.titleText,
    this.hintText,
    this.name,
    this.controller,
    this.onChanged,
  }) : super(key: key);

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool _isFocused = false;
  Timer? _timer;

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final SearcherCubit searcherCubit = BlocProvider.of<SearcherCubit>(context);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          (widget.titleText != null)
              ? Padding(
                  padding: const EdgeInsets.only(bottom: 6),
                  child: Text(
                    widget.titleText!,
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                )
              : Container(),
          Container(
            child: TextField(
              controller: widget.controller,
              style: Theme.of(context).textTheme.displayMedium,
              onTap: _onTap,
              onSubmitted: _onSubmitted,
              onChanged: _onTextChanged,
              onEditingComplete: () {
                setState(() {
                  _isFocused = false;
                });
              },
              decoration: InputDecoration(
                filled: true,
                fillColor:
                    _isFocused ? AppColors.accentSecondary : AppColors.layer1,
                suffixIcon: InkWell(
                  onTap: () {
                    widget.controller?.clear();
                    searcherCubit.getSavedRequests();
                  },
                  child: const Padding(
                    padding: EdgeInsets.all(16.0),
                    child: SizedBox(
                      child: SvgPictureFromAsset(
                        iconString: AppIcons.cancel,
                      ),
                    ),
                  ),
                ),
                prefixIcon: const Padding(
                  padding: EdgeInsets.all(16.0),
                  child: SizedBox(
                    child: SvgPictureFromAsset(
                      iconString: AppIcons.search,
                    ),
                  ),
                ),
                hintText: widget.hintText,
                hintStyle: Theme.of(context).textTheme.bodyMedium,
                contentPadding:
                    const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide(
                    color:
                        _isFocused ? AppColors.accentPrimary : AppColors.layer1,
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: const BorderSide(
                    color: AppColors.layer1,
                    width: 0.0,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _onTap() {
    setState(() {
      _isFocused = true;
    });
  }

  void _onTextChanged(String value) {
    if (_timer != null) {
      _timer!.cancel();
    }
    _timer = Timer(Duration(seconds: 2), () {
      if (value.isNotEmpty)
        BlocProvider.of<SearcherCubit>(context).searchRepositories(value);
    });

    if (widget.onChanged != null) {
      widget.onChanged!(value);
    }
    setState(() {
      _isFocused = true;
    });
  }

  void _onSubmitted(String value) {
    BlocProvider.of<SearcherCubit>(context).searchRepositories(value);

    if (_timer != null) {
      _timer!.cancel();
    }

    setState(() {
      _isFocused = false;
    });
  }
}
