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
      if (response.isSuccessful) {
        var productsResponse = ProductsResponse.fromJson(response.body);
        products.assignAll(productsResponse.items);
        print('---------all products ${products.length}-------');
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
    p = products.firstWhere((element) => element.sku == id, orElse: () {
      return null;
    });
    print('found');
    // if (products.isNotEmpty) {
    //   for (int i = 0; i < products.length; i++) {
    //     print('$id => ${products[i].sku}');
    //     if (products[i].sku == id) {
    //       p = products[i];
    //       break;
    //     }
    //   }
    // }
    return p;
  }
}
