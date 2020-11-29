import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:e_commerce_alwalla/controller/address_controller.dart';
import 'package:e_commerce_alwalla/controller/cart_controller.dart';
import 'package:e_commerce_alwalla/controller/checkout_controller.dart';
import 'package:e_commerce_alwalla/data/app_preference.dart';
import 'package:e_commerce_alwalla/screen/product_details/product_details_screen.dart';
import 'package:e_commerce_alwalla/theme/app_theme.dart';
import 'package:e_commerce_alwalla/utils/common.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SummaryScreen extends StatefulWidget {
  @override
  _SummaryScreenState createState() => _SummaryScreenState();
}

class _SummaryScreenState extends State<SummaryScreen> {
  final CartController _cartController = Get.find();
  final CheckoutController _checkoutController = Get.find();
  final AddressController _addressesController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        backgroundColor: whiteColor,
        title: Text("Summary"),
        centerTitle: true,
        elevation: 0,
      ),
      body: body(context),
      bottomNavigationBar: Obx(() {
        return Container(
          padding: EdgeInsets.symmetric(vertical: 24, horizontal: 24),
          color: whiteColor,
          child: Row(
            children: [
              Expanded(
                  child: Container(
                height: 50,
                child: OutlineButton(
                  highlightedBorderColor: redColor,
                  highlightColor: whiteColor,
                  color: redColor,
                  borderSide: BorderSide(color: redColor),
                  onPressed: _checkoutController.isLoading.value
                      ? null
                      : () {
                          Get.back();
                        },
                  child: Text(
                    "BACK",
                    style: subTextStyle.copyWith(color: blackColor),
                  ),
                ),
              )),
              const SizedBox(
                width: 24,
              ),
              Expanded(
                  child: Container(
                height: 50,
                child: RaisedButton(
                  elevation: 0,
                  color: redColor,
                  onPressed: _checkoutController.isLoading.value
                      ? null
                      : () {
                          _checkoutController.placeOrder();
                        },
                  child: Text(
                    "PAY",
                    style: subTextStyle.copyWith(color: whiteColor),
                  ),
                ),
              ))
            ],
          ),
        );
      }),
    );
  }

  space(double size) {
    return SliverToBoxAdapter(
      child: SizedBox(
        height: size,
      ),
    );
  }

  Widget body(BuildContext context) {
    return Obx(() {
      if (_checkoutController.isLoading.value)
        return Center(
          child: RefreshProgressIndicator(),
        );
      var paymentMethod = '';
      _checkoutController.paymentMethods.value.paymentMethods
          .forEach((element) {
        if (element.isSelected) paymentMethod = element.title;
      });
      return CustomScrollView(
        physics: BouncingScrollPhysics(),
        slivers: [
          space(32),
          if (_cartController.carts.value != null)
            SliverToBoxAdapter(
              child: Container(
                height: 200,
                child: ListView.builder(
                  itemBuilder: (c, i) =>
                      productItem(_cartController.carts.value.items[i], i == 0),
                  itemCount: _cartController.carts.value.items.length,
                  shrinkWrap: true,
                  physics: BouncingScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                ),
              ),
            ),
          space(24),
          SliverToBoxAdapter(
            child: Divider(),
          ),
          space(24),
          SliverToBoxAdapter(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Text(
                    "Shipping Address",
                    style: mainTextStyle.copyWith(fontSize: 20),
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Text(
                    getFullAddress(_addressesController.selectedAddress.value),
                    style: subTextStyle.copyWith(fontSize: 16),
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
                FlatButton(
                    onPressed: () {
                      Get.back(result: 0);
                    },
                    child: Text(
                      "Change",
                      style:
                          subTextStyle.copyWith(color: redColor, fontSize: 18),
                    ))
              ],
            ),
          ),
          space(24),
          SliverToBoxAdapter(
            child: Divider(),
          ),
          space(24),
          SliverToBoxAdapter(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Text(
                    "Payment",
                    style: mainTextStyle.copyWith(fontSize: 20),
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Text(
                    paymentMethod,
                    style: subTextStyle.copyWith(fontSize: 16),
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
                FlatButton(
                    onPressed: () {
                      Get.back(result: 2);
                    },
                    child: Text(
                      "Change",
                      style: subTextStyle.copyWith(
                          color: redColor,
                          fontSize: 18,
                          fontWeight: FontWeight.w400),
                    ))
              ],
            ),
          ),
          space(32),
        ],
      );
    });
  }

  Widget productItem(Item product, bool isFirst) {
    return GestureDetector(
      onTap: () {
        Get.to(ProductDetailsScreen(
          productId: product.id,
        ));
        // Navigator.push(
        //   context,
        //   MaterialPageRoute(
        //     builder: (c) => ProductDetailsScreen(),
        //   ),
        // );
      },
      child: Container(
        padding: isFirst
            ? EdgeInsets.only(
                left: AppPreference.appLanguage == "en" ? 16 : 12,
                right: AppPreference.appLanguage == "en" ? 12 : 16)
            : EdgeInsets.symmetric(horizontal: 12),
        width: ((MediaQuery.of(context).size.width - 48) / 2),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(6),
              child: Hero(
                tag: "product${product.id}",
                child: CachedNetworkImage(
                  imageUrl: product.image,
                  errorWidget: (c, s, w) {
                    return CachedNetworkImage(
                      imageUrl:
                          'http://mymalleg.com/pub/media/catalog/product/cache/no_image.jpg',
                      fit: BoxFit.cover,
                      height: 140,
                    );
                  },
                  fit: BoxFit.contain,
                  width: 120,
                  height: 120,
                ),
              ),
            ),
            const SizedBox(
              height: 6,
            ),
            AutoSizeText(
              product.title,
              maxFontSize: 16,
              minFontSize: 12,
              style: mainTextStyle.copyWith(
                  fontWeight: FontWeight.w400, fontSize: 16),
              maxLines: 1,
            ),
            const SizedBox(
              height: 3,
            ),
            Text(
              product.total + " EGP",
              style: mainTextStyle.copyWith(
                  color: redColor, fontWeight: FontWeight.w400, fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
