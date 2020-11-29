import 'dart:convert';

import 'package:e_commerce_alwalla/model/products_response.dart';
import 'package:get/get.dart';
import 'package:http/http.dart';

class SearchController extends GetxController {
  var loading = false.obs;
  RxList<Product> products = RxList();
  RxList<Product> searchedProducts = RxList();
  var productsEmpty = false.obs;
  @override
  void onInit() {
    super.onInit();
    getRecommendedProducts();
  }

  void getRecommendedProducts() async {
    try {
      products.assignAll([]);

      productsEmpty.value = false;
      var url =
          "http://mymalleg.com/index.php/rest/V1/products?searchCriteria[filter_groups][0][filters][0][field]=category_id&searchCriteria[filter_groups][0][filters][0][value]=15&searchCriteria[filter_groups][0][filters][0][condition_type]=eq";
      var response = await get(url);

      print(response.body);

      if (response.statusCode == 200) {
        var jsonString = jsonDecode(response.body);
        var cat = ProductsResponse.fromJson(jsonString);
        products.assignAll(cat.items);
        if (cat.totalCount == 0) productsEmpty.value = true;
      } else {
        productsEmpty.value = true;
        var error = jsonDecode(response.body);
        print(error['message'] ?? '');
      }
    } on Exception catch (e) {
      productsEmpty.value = true;
      print(e.toString());
    }
  }

  void searchProducts(String q) async {
    try {
      searchedProducts.assignAll([]);
      loading(true);
      productsEmpty.value = false;
      var url =
          "http://mymalleg.com/index.php/rest/V1/products?searchCriteria[filter_groups][0][filters][0][field]=name&searchCriteria[filter_groups][0][filters][0][value]=%$q%&searchCriteria[filter_groups][0][filters][0][condition_type]=like";
      var response = await get(url);
      loading(false);
      print(response.body);

      if (response.statusCode == 200) {
        var jsonString = jsonDecode(response.body);
        var cat = ProductsResponse.fromJson(jsonString);
        searchedProducts.assignAll(cat.items);
        if (cat.totalCount == 0) productsEmpty.value = true;
      } else {
        productsEmpty.value = true;
        var error = jsonDecode(response.body);
        print(error['message'] ?? '');
      }
    } on Exception catch (e) {
      loading(false);
      productsEmpty.value = true;
      print(e.toString());
    }
  }
}
