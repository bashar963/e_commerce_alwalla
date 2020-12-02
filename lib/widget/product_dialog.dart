import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_pro/carousel_pro.dart';
import 'package:e_commerce_alwalla/controller/cart_controller.dart';
import 'package:e_commerce_alwalla/model/products_response.dart';
import 'package:e_commerce_alwalla/theme/app_theme.dart';
import 'package:e_commerce_alwalla/utils/common.dart';
import 'package:e_commerce_alwalla/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

class ProductDialog extends StatefulWidget {
  final Product product;

  ProductDialog(this.product);
  @override
  _ProductDialogState createState() => _ProductDialogState();
}

class _ProductDialogState extends State<ProductDialog> {
  final CartController _cartController = Get.find();
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
          padding: EdgeInsets.symmetric(vertical: 0, horizontal: 0),
          width: MediaQuery.of(context).size.width,
          child: dialogContent(context)),
    );
  }

  dialogContent(BuildContext context) {
    return Stack(
      children: [
        Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              height: 350,
              child: Carousel(
                dotBgColor: Colors.transparent,
                dotColor: Theme.of(context).accentColor,
                dotIncreasedColor: Theme.of(context).accentColor,
                autoplay: false,
                images: widget.product.mediaGalleryEntries.map((e) {
                  return CachedNetworkImage(
                    imageUrl: baseUrlMedia + e.file,
                    width: MediaQuery.of(context).size.width,
                    fit: BoxFit.cover,
                    errorWidget: (c, s, w) {
                      return CachedNetworkImage(
                        imageUrl:
                            'http://mymalleg.com/pub/media/catalog/product/cache/no_image.jpg',
                        fit: BoxFit.cover,
                      );
                    },
                  );
                }).toList(),
              ),
            ),
            if (widget.product.options.isNotEmpty)
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 8),
                child: productOptions(),
              ),
            Container(
              padding: EdgeInsets.symmetric(vertical: 24, horizontal: 24),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text(
                          "Price",
                          style: mainTextStyle.copyWith(
                              fontSize: 14, color: subTextColor),
                        ),
                        Text(
                          widget.product.price.toString() + " EGP",
                          style: mainTextStyle.copyWith(
                              fontSize: 18, color: redColor),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                      child: Container(
                    height: 50,
                    child: RaisedButton(
                      elevation: 0,
                      padding:
                          EdgeInsets.symmetric(vertical: 16, horizontal: 12),
                      color: redColor,
                      onPressed: addToCart,
                      child: Text(
                        "ADD",
                        style: subTextStyle.copyWith(color: whiteColor),
                      ),
                    ),
                  ))
                ],
              ),
            )
          ],
        ),
        Positioned(
            top: 8,
            right: 8,
            child: IconButton(
                icon: FaIcon(
                  FontAwesomeIcons.times,
                  color: Theme.of(context).accentColor,
                ),
                onPressed: () {
                  Get.back();
                }))
      ],
    );
  }

  void addToCart() {
    if (widget.product.options.isNotEmpty) {
      List<Map<String, dynamic>> itemOptions = [];
      int optionsLength = widget.product.options.length;
      int selectedOptions = 0;
      widget.product.options.forEach((element) {
        bool hasSelected = false;
        element.values.forEach((val) {
          if (val.isSelected) {
            hasSelected = true;
            itemOptions.add({
              "optionValue": val.optionTypeId.toString(),
              "optionId": element.optionId.toString()
            });
          }
        });
        if (hasSelected) selectedOptions++;
      });

      if (selectedOptions == optionsLength)
        _cartController.addItemToCar(itemOptions, widget.product.sku);
      else
        showFailedMessage(context, 'Please choose option');
    } else {
      _cartController.addItemToCar(null, widget.product.sku);
    }
  }

  Widget productOptions() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: widget.product.options.map((e) {
        return Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.symmetric(vertical: 12, horizontal: 4),
                  decoration: BoxDecoration(
                      border: Border.all(color: lightGrey),
                      borderRadius: BorderRadius.circular(24)),
                  child: Center(
                    child: Text(
                      e.title,
                      style: subTextStyle,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
                Wrap(
                  alignment: WrapAlignment.center,
                  spacing: 8,
                  runSpacing: 2,
                  children: e.values.map((val) {
                    if (e.title == 'Color' ||
                        e.title == 'Colors' ||
                        e.title == 'Colour' ||
                        e.title == 'Colours')
                      return InkWell(
                        onTap: () {
                          setState(() {
                            e.values.forEach((element) {
                              element.isSelected = false;
                            });
                            val.isSelected = true;
                          });
                        },
                        child: Container(
                          width: val.isSelected ? 28 : 26,
                          height: val.isSelected ? 28 : 26,
                          decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                    color: Color.fromRGBO(36, 36, 36, 0.09),
                                    blurRadius: 20,
                                    offset: Offset(0, 5))
                              ],
                              border: val.isSelected
                                  ? Border.all(color: subTextColor, width: 2)
                                  : null,
                              borderRadius: BorderRadius.circular(
                                  val.isSelected ? 11 : 10),
                              color: getColor(val.title)),
                        ),
                      );
                    return InkWell(
                      onTap: () {
                        setState(() {
                          e.values.forEach((element) {
                            element.isSelected = false;
                          });
                          val.isSelected = true;
                        });
                      },
                      child: Container(
                        padding:
                            EdgeInsets.symmetric(vertical: 2, horizontal: 4),
                        decoration: val.isSelected
                            ? BoxDecoration(
                                border: Border.all(color: lightGrey),
                                borderRadius: BorderRadius.circular(24))
                            : null,
                        child: Text(
                          val.title,
                          style: mainTextStyle.copyWith(fontSize: 12),
                        ),
                      ),
                    );
                  }).toList(),
                )
              ],
            ),
          ),
        );
      }).toList(),
    );
  }
}
