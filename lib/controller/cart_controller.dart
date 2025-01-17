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
  final ProductsController productsController = Get.put(ProductsController());
  var isLoading = false.obs;
  var quoteId = ''.obs;
  var quoteIdFromGuest = ''.obs;
  @override
  void onInit() {
    super.onInit();
    getCart();
  }

  void clearCart() {
    carts.value = null;
    cart.value = null;
    quoteId.value = '';
  }

  Future getQuoteId() async {
    if (carts.value != null) {
      carts.value.items.forEach((element) {
        quoteId.value = element.quoteId;
        return;
      });
    } else {
      try {
        var response = await MainApi.create().getQuoteId(AppPreference.token);
        print('---------get QuoteId-------');
        print(response.bodyString);
        print(response.error);
        if (response.isSuccessful) {
          quoteId.value = response.bodyString;
        } else if (response.statusCode != 404) {
          var error = jsonDecode(response.error.toString());
          showFailedMessage(Get.context, error['message'] ?? '');
        }
      } on Exception catch (e) {
        showFailedMessage(Get.context, e.toString() ?? '');
      }
    }
  }

  void getCart() async {
    if (AppPreference.token == null) {
      try {
        isLoading(true);
        if (AppPreference.guestCartId.isEmpty) {
          if (quoteId.value.isEmpty) {
            var responseQuote = await MainApi.create().getQuoteIdGuest();
            print(responseQuote.body.toString());
            quoteId.value = responseQuote.body.toString();
            AppPreference.guestCartId = responseQuote.body.toString();
          }
        } else {
          quoteId.value = AppPreference.guestCartId;
        }

        var response = await MainApi.create().getCartGuest(quoteId.value);
        print('---------cart-------');
        print(response.bodyString);
        print(response.error);
        print(response.statusCode);
        isLoading(false);
        if (response.isSuccessful) {
          cart.value = CartResponse.fromJson(response.body);
          quoteIdFromGuest.value = cart.value.id.toString();
          fillCart();
        } else if (response.statusCode != 404) {
          var error = jsonDecode(response.error.toString());

          showFailedMessage(Get.context, error['message'] ?? '');
        }
      } on Exception catch (e) {
        showFailedMessage(Get.context, e.toString() ?? '');
      }
    } else {
      try {
        isLoading(true);
        getQuoteId();
        var response = await MainApi.create().getCart(AppPreference.token);
        print('---------cart-------');
        print(response.bodyString);
        print(response.error);
        print(response.statusCode);
        isLoading(false);
        if (response.isSuccessful) {
          cart.value = CartResponse.fromJson(response.body);
          fillCart();
        } else if (response.statusCode != 404) {
          var error = jsonDecode(response.error.toString());

          showFailedMessage(Get.context, error['message'] ?? '');
        }
      } on Exception catch (e) {
        showFailedMessage(Get.context, e.toString() ?? '');
      }
    }
  }

  void removeItemInCart(String itemId) async {
    if (AppPreference.token == null) {
      try {
        isLoading(true);
        var response =
            await MainApi.create().deleteItemInCartGuest(quoteId.value, itemId);
        print('--------- delete cart item $itemId -------');
        print(response.bodyString);
        print(response.error);
        isLoading(false);
        if (response.isSuccessful) {
          //var cartResponse = response.body;
          getCart();
        } else {
          var error = jsonDecode(response.error.toString());
          showFailedMessage(Get.context, error['message'] ?? '');
        }
      } on Exception catch (e) {
        showFailedMessage(Get.context, e.toString() ?? '');
      }
    } else {
      try {
        isLoading(true);
        var response = await MainApi.create()
            .deleteItemInCart(AppPreference.token, itemId);
        print('--------- delete cart item $itemId -------');
        print(response.bodyString);
        print(response.error);
        isLoading(false);
        if (response.isSuccessful) {
          //var cartResponse = response.body;
          getCart();
        } else {
          var error = jsonDecode(response.error.toString());
          showFailedMessage(Get.context, error['message'] ?? '');
        }
      } on Exception catch (e) {
        showFailedMessage(Get.context, e.toString() ?? '');
      }
    }
  }

  void editItemInCart(String itemId, String quoteId, int qty) async {
    if (AppPreference.token == null) {
      try {
        isLoading(true);
        print(quoteId);
        var response = await MainApi.create()
            .editItemInCartGuest(this.quoteId.value, itemId, {
          "cartItem": {
            "item_id": itemId,
            "qty": qty,
            "quoteId": this.quoteId.value
          }
        });
        print('---------edit cart item $itemId-------');
        print(response.bodyString);
        print(response.error);
        isLoading(false);
        if (response.isSuccessful) {
          //var cartResponse = response.body;
          getCart();
        } else {
          var error = jsonDecode(response.error.toString());
          showFailedMessage(Get.context, error['message'] ?? '');
        }
      } on Exception catch (e) {
        showFailedMessage(Get.context, e.toString() ?? '');
      }
    } else {
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
          //var cartResponse = response.body;
          getCart();
        } else {
          var error = jsonDecode(response.error.toString());
          showFailedMessage(Get.context, error['message'] ?? '');
        }
      } on Exception catch (e) {
        showFailedMessage(Get.context, e.toString() ?? '');
      }
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
        subTotal += double.tryParse(element.price.toString()) *
                (int.tryParse(element.qty.toString())) ??
            1;

        var p = productsController.getProductById(element.sku);
        var image = '';
        if (p != null) {
          if (p.mediaGalleryEntries != null) {
            if (p.mediaGalleryEntries.isNotEmpty) {
              image = p.mediaGalleryEntries.first.file;
            }
          }
        }
        items.add(Item(
            element.sku,
            element.itemId.toString(),
            element.name,
            element.price.toString(),
            baseUrlMedia + image,
            element.quoteId,
            element.qty));
      });
      tax = total - subTotal;
      carts.value = Cart(subTotal.toStringAsFixed(1), tax.toStringAsFixed(1),
          total.toStringAsFixed(1), items);
    }
  }

  void addItemToCar(List<Map<String, dynamic>> itemOptions, String sku) async {
    if (AppPreference.token == null) {
      try {
        isLoading(true);
        if (quoteId.value.isEmpty) {
          var response = await MainApi.create().getQuoteIdGuest();
          print('---------get QuoteId-------');
          print(response.bodyString);
          print(response.error);
          if (response.isSuccessful) {
            quoteId.value = response.bodyString;
          } else if (response.statusCode != 404) {
            var error = jsonDecode(response.error.toString());
            showFailedMessage(Get.context, error['message'] ?? '');
          }
        }
        print(itemOptions);
        var response;
        if (itemOptions == null)
          response = await MainApi.create().addItemToCartGuest(quoteId.value, {
            "cartItem": {
              "sku": sku,
              "qty": 1,
              "quoteId": quoteIdFromGuest.value,
            }
          });
        else
          response = await MainApi.create().addItemToCartGuest(quoteId.value, {
            "cartItem": {
              "sku": sku,
              "qty": 1,
              "quoteId": quoteIdFromGuest.value,
              "productOption": {
                "extensionAttributes": {"customOptions": itemOptions}
              },
              "extension_attributes": {}
            }
          });
        print('---------cart-------');
        print(response.bodyString);
        print(response.error);
        print(response.statusCode);
        isLoading(false);
        if (response.isSuccessful) {
          getCart();
          showSuccessMessage(Get.context,
              'This item has been added successfully to your cart');
          Future.delayed(Duration(seconds: 1), () {
            Get.back();
          });
        } else if (response.statusCode != 404) {
          var error = jsonDecode(response.error.toString());

          showFailedMessage(Get.context, error['message'] ?? '');
        }
      } on Exception catch (e) {
        showFailedMessage(Get.context, e.toString() ?? '');
      }
    } else {
      try {
        isLoading(true);
        if (quoteId.value.isEmpty) {
          var response = await MainApi.create().getQuoteId(AppPreference.token);
          print('---------get QuoteId-------');
          print(response.bodyString);
          print(response.error);
          if (response.isSuccessful) {
            quoteId.value = response.bodyString;
          } else if (response.statusCode != 404) {
            var error = jsonDecode(response.error.toString());
            showFailedMessage(Get.context, error['message'] ?? '');
          }
        }
        print(itemOptions);
        var response;
        if (itemOptions == null)
          response = await MainApi.create().addItemToCart(AppPreference.token, {
            "cartItem": {
              "sku": sku,
              "qty": 1,
              "quote_id": quoteId.value,
            }
          });
        else
          response = await MainApi.create().addItemToCart(AppPreference.token, {
            "cartItem": {
              "sku": sku,
              "qty": 1,
              "quote_id": quoteId.value,
              "productOption": {
                "extensionAttributes": {"customOptions": itemOptions}
              },
              "extension_attributes": {}
            }
          });
        print('---------cart-------');
        print(response.bodyString);
        print(response.error);
        print(response.statusCode);
        isLoading(false);
        if (response.isSuccessful) {
          getCart();
          showSuccessMessage(Get.context,
              'This item has been added successfully to your cart');
          Future.delayed(Duration(seconds: 1), () {
            Get.back();
          });
        } else if (response.statusCode != 404) {
          var error = jsonDecode(response.error.toString());

          showFailedMessage(Get.context, error['message'] ?? '');
        }
      } on Exception catch (e) {
        showFailedMessage(Get.context, e.toString() ?? '');
      }
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
