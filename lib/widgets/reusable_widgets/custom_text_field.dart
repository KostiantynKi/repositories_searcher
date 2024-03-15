// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
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

  @override
  Widget build(BuildContext context) {
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
            child: TextFormField(
              controller: widget.controller,

              // textCapitalization: TextCapitalization.sentences,
              // textInputAction: TextInputAction.next,
              style: Theme.of(context).textTheme.displayMedium,
              onTap: () {
                setState(() {
                  _isFocused = true;
                });
              },
              onFieldSubmitted: (_) {
                setState(() {
                  _isFocused = false;
                });
              },

              onChanged: (value) {
                if (widget.onChanged != null) {
                  widget.onChanged!(value);
                }
                setState(() {
                  _isFocused = true;
                });
              },
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
                    // todo: oчистить kонтроллер
                    widget.controller?.clear();
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: SizedBox(
                      child: SvgPictureFromAsset(
                        iconString: AppIcons.cancel,
                      ),
                    ),
                  ),
                ),
                prefixIcon: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: SizedBox(
                    child: SvgPictureFromAsset(
                      iconString: AppIcons.search,
                    ),
                  ),
                ),
                hintText: widget.hintText,
                hintStyle: Theme.of(context).textTheme.bodyMedium,
                contentPadding:
                    EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide(
                    // color: AppColors.layer1,
                    color:
                        _isFocused ? AppColors.accentPrimary : AppColors.layer1,
                    // color: Colors.red, _isFocused ? AppColors.accentSecondary : AppColors.layer1,
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide(
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
}
