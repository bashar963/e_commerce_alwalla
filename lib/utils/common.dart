import 'package:e_commerce_alwalla/model/customer/customer_response.dart';
import 'package:e_commerce_alwalla/theme/app_theme.dart';
import 'package:e_commerce_alwalla/widget/message_dialog.dart';
import 'package:flutter/material.dart';

void hideKeyboard(BuildContext context) {
  FocusScope.of(context).requestFocus(new FocusNode());
}

void showFailedMessage(BuildContext context, String error) {
  showDialog(
      context: context,
      builder: (c) => AppMessageDialog(
          description: error,
          icon: Icon(
            Icons.error,
            color: backgroundColor,
            size: 60,
          ),
          iconBackgroundColor: redColor));
}

void showSuccessMessage(BuildContext context, String message) {
  showDialog(
      context: context,
      builder: (c) => AppMessageDialog(
          description: message,
          icon: Icon(
            Icons.check_circle,
            color: backgroundColor,
            size: 60,
          ),
          iconBackgroundColor: greenColor));
}

String getFullAddress(Addresses address) {
  return "${address.street.first} ${address.city} ${address.region.region} ";
}

Map<String, Color> _colors = {
  "white": Color(0xFFFFFFFF),
  "black": Color(0xFF000000),
  "yellow": Color(0xFFFFFF00),
};
Color getColor(String color) {
  Color c = _colors[color.toLowerCase()];
  if (c == null) return Color(0xFFFFFFFF);
  return c;
}
