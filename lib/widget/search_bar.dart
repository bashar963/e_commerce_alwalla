import 'package:e_commerce_alwalla/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SearchBar extends StatelessWidget {
  final TextEditingController textController;
  final Function onComplete;
  final Function onTap;
  final Function onClose;
  const SearchBar(
      {Key key,
      @required this.textController,
      this.onTap,
      this.onClose,
      @required this.onComplete})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(vertical: 4, horizontal: 16),
      height: 46,
      decoration: BoxDecoration(
          color: Color(0xFFf7f7f7), borderRadius: BorderRadius.circular(24)),
      child: Material(
        color: Colors.transparent,
        child: TextFormField(
          controller: textController,
          onTap: onTap,
          keyboardType: TextInputType.text,
          cursorWidth: 1,
          autofocus: onClose != null,
          onEditingComplete: onComplete,
          style: TextStyle(
              color: mainTextColor, fontWeight: FontWeight.w600, fontSize: 16),
          decoration: InputDecoration(
            icon: FaIcon(
              FontAwesomeIcons.search,
              size: 18,
              color: mainTextColor,
            ),
            suffixIcon: onClose != null
                ? GestureDetector(
                    onTap: onClose,
                    child: Icon(
                      Icons.close,
                      color: blackColor,
                    ),
                  )
                : null,
            hintText: "",
            hintStyle: TextStyle(
              color: subTextColor,
              fontWeight: FontWeight.w200,
            ),
            border: InputBorder.none,
          ),
        ),
      ),
    );
  }
}
