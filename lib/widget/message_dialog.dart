import 'package:e_commerce_alwalla/theme/app_theme.dart';
import 'package:flutter/material.dart';

class AppMessageDialog extends StatelessWidget {
  final String description;
  final Widget icon;
  final Color iconBackgroundColor;

  const AppMessageDialog(
      {Key key,
      @required this.description,
      @required this.icon,
      @required this.iconBackgroundColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      elevation: 1.0,
      backgroundColor: backgroundColor,
      insetPadding: EdgeInsets.symmetric(horizontal: 28),
      child: Container(
          padding: EdgeInsets.symmetric(vertical: 32, horizontal: 24),
          width: MediaQuery.of(context).size.width,
          child: dialogContent(context)),
    );
  }

  Widget dialogContent(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        CircleAvatar(
          backgroundColor: iconBackgroundColor,
          radius: 75,
          child: Center(
            child: icon,
          ),
        ),
        SizedBox(
          height: 46,
        ),
        Text(
          description,
          textAlign: TextAlign.center,
          style: TextStyle(
              fontSize: 14, fontWeight: FontWeight.w600, color: mainTextColor),
        )
      ],
    );
  }
}
