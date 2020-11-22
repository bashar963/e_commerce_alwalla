import 'dart:convert';

import 'package:e_commerce_alwalla/data/main_api/main_api.dart';
import 'package:e_commerce_alwalla/model/products_response.dart';
import 'package:get/get.dart';

class ProductsController extends GetxController {
  RxList<Product> products = RxList();
  @override
  void onInit() {
    super.onInit();
    getProducts();
  }

  void getProducts() async {
    try {
      var response = await MainApi.create().getProducts();
      print('---------all products-------');
      print(response.bodyString);
      print(response.error);

      if (response.isSuccessful) {
        var productsResponse = ProductsResponse.fromJson(response.body);

        products.assignAll(productsResponse.items);
      } else {
        var error = jsonDecode(response.error.toString());

        print(error.toString());
      }
    } on Exception catch (e) {
      print(e.toString());
    }
  }

  Product getProductById(String id) {
    Product p;
    if (products.isNotEmpty) {
      products.forEach((element) {
        print('$id => ${element.sku}');
        if (element.sku == id) {
          p = element;
        }
      });
    }
    return p;
  }
}
