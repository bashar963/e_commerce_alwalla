import 'dart:convert';

import 'package:e_commerce_alwalla/controller/products_controller.dart';
import 'package:e_commerce_alwalla/data/app_preference.dart';
import 'package:e_commerce_alwalla/data/main_api/main_api.dart';
import 'package:e_commerce_alwalla/model/cart_response.dart';
import 'package:e_commerce_alwalla/utils/common.dart';
import 'package:e_commerce_alwalla/utils/constants.dart';
import 'package:get/get.dart';

class CartController extends GetxController {
  Rx<CartResponse> cart = Rx(null);
  Rx<Cart> carts = Rx(null);
  final ProductsController productsController = Get.find();
  var isLoading = false.obs;
  @override
  void onInit() {
    super.onInit();
    getCart();
  }

  void getCart() async {
    try {
      isLoading(true);
      var response = await MainApi.create().getCart(AppPreference.token);
      print('---------cart-------');
      print(response.bodyString);
      print(response.error);
      isLoading(false);
      if (response.isSuccessful) {
        cart.value = CartResponse.fromJson(response.body);
        fillCart();
      } else {
        var error = jsonDecode(response.error.toString());

        showFailedMessage(Get.context, error['message'] ?? '');
      }
    } on Exception catch (e) {
      showFailedMessage(Get.context, e.toString() ?? '');
    }
  }

  void fillCart() {
    if (cart.value != null) {
      print('init cart');
      List<Item> items = [];
      var subTotal = 0.0;
      cart.value.items.forEach((element) {
        subTotal += element.price;
        var p = productsController.getProductById(element.sku);
        var image = '';
        if (p != null) {
          if (p.mediaGalleryEntries != null) {
            if (p.mediaGalleryEntries.isNotEmpty) {
              image = p.mediaGalleryEntries.first.file;
            }
          }
        }
        print('link $image');
        print(baseUrlMedia + image);
        items.add(Item(
            element.sku,
            element.name,
            p == null ? element.price.toString() : p.price.toString(),
            'http://mymalleg.com/pub/media/catalog/product' + image,
            element.qty));
      });
      carts.value = Cart(subTotal.toStringAsFixed(2), '0.0',
          subTotal.toStringAsFixed(2), items);
    }
  }
}

class Cart {
  final String subTotal, tax, total;
  final List<Item> items;

  Cart(this.subTotal, this.tax, this.total, this.items);
}

class Item {
  final String id, title, total, image;
  dynamic quantity = 1;

  Item(this.id, this.title, this.total, this.image, this.quantity);
}
