import 'package:e_commerce_alwalla/theme/app_theme.dart';
import 'package:flutter/material.dart';

class SearchBar extends StatelessWidget {
  final TextEditingController textController;
  final Function onComplete;
  const SearchBar(
      {Key key, @required this.textController, @required this.onComplete})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(vertical: 4, horizontal: 16),
      height: 46,
      decoration: BoxDecoration(
          color: Color(0xFFf7f7f7), borderRadius: BorderRadius.circular(24)),
      child: TextFormField(
        controller: textController,
        keyboardType: TextInputType.text,
        cursorWidth: 1,
        autofocus: false,
        onEditingComplete: onComplete,
        style: TextStyle(
            color: mainTextColor, fontWeight: FontWeight.w600, fontSize: 16),
        decoration: InputDecoration(
          icon: Image.asset("assets/icons/icon_search.png"),
          hintText: "",
          hintStyle: TextStyle(
            color: subTextColor,
            fontWeight: FontWeight.w200,
          ),
          border: InputBorder.none,
        ),
      ),
    );
  }
}
