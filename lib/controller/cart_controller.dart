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

  void removeItemInCart(String itemId) async {
    try {
      isLoading(true);
      var response =
          await MainApi.create().deleteItemInCart(AppPreference.token, itemId);
      print('--------- delete cart item $itemId -------');
      print(response.bodyString);
      print(response.error);
      isLoading(false);
      if (response.isSuccessful) {
        var cartResponse = response.body;
        getCart();
      } else {
        var error = jsonDecode(response.error.toString());
        showFailedMessage(Get.context, error['message'] ?? '');
      }
    } on Exception catch (e) {
      showFailedMessage(Get.context, e.toString() ?? '');
    }
  }

  void editItemInCart(String itemId, String quoteId, int qty) async {
    try {
      isLoading(true);
      var response =
          await MainApi.create().editItemInCart(AppPreference.token, itemId, {
        "cartItem": {"item_id": itemId, "qty": qty, "quote_id": quoteId}
      });
      print('---------edit cart item $itemId-------');
      print(response.bodyString);
      print(response.error);
      isLoading(false);
      if (response.isSuccessful) {
        var cartResponse = response.body;
        getCart();
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
      var total = 0.0;
      var tax = 0.0;
      cart.value.items.forEach((element) {
        total += double.tryParse(element.price.toString()) *
                (int.tryParse(element.qty.toString())) ??
            1;
        var p = productsController.getProductById(element.sku);
        var image = '';
        if (p != null) {
          if (p.mediaGalleryEntries != null) {
            if (p.mediaGalleryEntries.isNotEmpty) {
              subTotal += double.tryParse(p.price.toString()) *
                      (int.tryParse(element.qty.toString())) ??
                  1;
              image = p.mediaGalleryEntries.first.file;
            }
          }
        }
        items.add(Item(
            element.sku,
            element.itemId.toString(),
            element.name,
            p == null ? element.price.toString() : p.price.toString(),
            baseUrlMedia + image,
            element.quoteId,
            element.qty));
      });
      tax = total - subTotal;
      carts.value = Cart(subTotal.toStringAsFixed(1), tax.toStringAsFixed(1),
          total.toStringAsFixed(1), items);
    }
  }
}

class Cart {
  final String subTotal, tax, total;
  final List<Item> items;

  Cart(this.subTotal, this.tax, this.total, this.items);
}

class Item {
  final String id, itemId, title, total, image, quoteId;
  dynamic quantity = 1;

  Item(this.id, this.itemId, this.title, this.total, this.image, this.quoteId,
      this.quantity);
}
