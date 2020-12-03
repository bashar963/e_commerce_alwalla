import 'dart:convert';

import 'package:e_commerce_alwalla/model/categories_response.dart';
import 'package:e_commerce_alwalla/model/home_response.dart';
import 'package:e_commerce_alwalla/model/products_response.dart';
import 'package:get/get.dart';
import 'package:http/http.dart';

class CategoriesController extends GetxController {
  var loading = false.obs;
  RxList<CategoryChild> categoryList = RxList();
  RxList<HomeResponse> homeList = RxList();
  RxList<Product> products = RxList();
  var productsEmpty = false.obs;
  @override
  void onInit() {
    super.onInit();
    getHomePage();
    getCategories();
  }

  void getCategories() async {
    try {
      loading(true);
      var url =
          "http://mymalleg.com/graphql?query={%20categoryList(filters:%20{ids:%20{in:%20[%223%22]}})%20{%20children_count,%20children%20{%20id,%20level,%20name,%20path,%20url_path,%20url_key,%20image,%20description,%20children%20{%20id,%20level,%20name,%20path,%20url_path,%20url_key,%20image%20description%20}%20}%20}%20}";
      var response = await get(url);
      loading(false);
      print(response.body);

      if (response.statusCode == 200) {
        var jsonString = jsonDecode(response.body);
        var cat = CategoriesResponse.fromJson(jsonString);
        categoryList.assignAll(cat.data.categoryList.first.children);
      } else {
        var error = jsonDecode(response.body);
        print(error['message'] ?? '');
      }
    } on Exception catch (e) {
      loading(false);
      print(e.toString());
    }
  }

  void getHomePage() async {
    try {
      loading(true);
      var url =
          "http://mymalleg.com/index.php/rest/V1/categories?rootCategoryId=2&depth=1";
      var response = await get(url);
      loading(false);
      print(response.body);

      if (response.statusCode == 200) {
        var jsonString = jsonDecode(response.body);
        var home = HomeResponse.fromJson(jsonString);
        for (var i = 0; i < home.childrenData.length; i++) {
          var url =
              "http://mymalleg.com/index.php/rest/V1/products?searchCriteria[filter_groups][0][filters][0][field]=category_id&searchCriteria[filter_groups][0][filters][0][value]=${home.childrenData[i].id}&searchCriteria[filter_groups][0][filters][0][condition_type]=eq";
          var response = await get(url);

          if (response.statusCode == 200) {
            var jsonString = jsonDecode(response.body);
            var cat = ProductsResponse.fromJson(jsonString);
            home.childrenData[i].products = [];
            home.childrenData[i].products.addAll(
                cat.items.length > 10 ? cat.items.getRange(0, 10) : cat.items);
          } else {
            var error = jsonDecode(response.body);
            print(error['message'] ?? '');
          }
        }
        List<HomeResponse> data = [];
        home.childrenData.forEach((element) {
          if (element.products.isNotEmpty) data.add(element);
        });
        homeList.assignAll(data);
      } else {
        var error = jsonDecode(response.body);
        print(error['message'] ?? '');
      }
    } on Exception catch (e) {
      loading(false);
      print(e.toString());
    }
  }

  void getProductsByCategory(String id) async {
    try {
      products.assignAll([]);
      loading(true);
      productsEmpty.value = false;
      var url =
          "http://mymalleg.com/index.php/rest/V1/products?searchCriteria[filter_groups][0][filters][0][field]=category_id&searchCriteria[filter_groups][0][filters][0][value]=$id&searchCriteria[filter_groups][0][filters][0][condition_type]=eq";
      var response = await get(url);
      loading(false);
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
      loading(false);
      productsEmpty.value = true;
      print(e.toString());
    }
  }
}
