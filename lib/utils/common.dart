import 'package:content_placeholder/content_placeholder.dart';
import 'package:content_placeholder/content_placeholders.dart';
import 'package:e_commerce_alwalla/model/customer/customer_response.dart';
import 'package:e_commerce_alwalla/theme/app_theme.dart';
import 'package:e_commerce_alwalla/widget/message_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

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
  "dark blue": Color(0xFF33427D),
  "orange": Color(0xFFFF7A06),
  "brown": Color(0xFF7D3333),
  "dark pink": Color(0xFF7D3378),
};
Color getColor(String color) {
  Color c = _colors[color.toLowerCase()];
  if (c == null) return Color(0xFFFFFFFF);
  return c;
}

Widget loadingPage() {
  return Container(
    child: Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 16),
          child: ContentPlaceholder(
            width: Get.width,
            height: 160,
          ),
        ),
        ListView.builder(
          itemBuilder: (c, i) {
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ContentPlaceholder(
                    width: Get.width,
                    height: 180,
                  ),
                  ContentPlaceholder(
                    width: 120,
                    height: 20,
                  ),
                  ContentPlaceholder(
                    width: 60,
                    height: 20,
                  ),
                ],
              ),
            );
          },
          shrinkWrap: true,
          itemCount: 3,
          physics: NeverScrollableScrollPhysics(),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
          child: ContentPlaceholder(
            width: Get.width,
            height: 160,
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
          child: ContentPlaceholder(
            width: Get.width,
            height: 160,
          ),
        ),
      ],
    ),
  );
}
