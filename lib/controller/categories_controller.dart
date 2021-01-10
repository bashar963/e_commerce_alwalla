import 'dart:convert';

import 'package:e_commerce_alwalla/model/categories_response.dart';
import 'package:e_commerce_alwalla/model/home_response.dart';
import 'package:e_commerce_alwalla/model/products_response.dart';
import 'package:e_commerce_alwalla/utils/constants.dart';
import 'package:get/get.dart';
import 'package:http/http.dart';

class CategoriesController extends GetxController {
  var loading = false.obs;
  var loadingCategory = false.obs;
  RxList<CategoryChild> categoryList = RxList();
  RxList<dynamic> homeList = RxList();
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
          "$baseUrl/graphql?query={%20categoryList(filters:%20{ids:%20{in:%20[%223%22]}})%20{%20children_count,%20children%20{%20id,%20level,%20name,%20path,%20url_path,%20url_key,%20image,%20description,%20children%20{%20id,%20level,%20name,%20path,%20url_path,%20url_key,%20image%20description%20}%20}%20}%20}";
      var response = await get(url);
      loading(false);

      if (response.statusCode == 200) {
        var jsonString = jsonDecode(response.body);
        var cat = CategoriesResponse.fromJson(jsonString);
        if (cat.data.categoryList.isNotEmpty)
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
      loadingCategory(true);
      var url = "$baseUrlApi/categories?rootCategoryId=2&depth=1";
      var response = await get(url);

      print(response.body);

      if (response.statusCode == 200) {
        var jsonString = jsonDecode(response.body);
        var home = HomeResponse.fromJson(jsonString);
        for (var i = 0; i < home.childrenData.length; i++) {
          var url =
              "$baseUrlApi/products?searchCriteria[filter_groups][0][filters][0][field]=category_id&searchCriteria[filter_groups][0][filters][0][value]=${home.childrenData[i].id}&searchCriteria[filter_groups][0][filters][0][condition_type]=eq";
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
        List<dynamic> data = [];
        home.childrenData.forEach((element) {
          if (element.products.isNotEmpty) data.add(element);
        });
        data.insert(0, Banner2('assets/images/1.jpeg'));
        if (data.length > 1) data.insert(2, Banner2('assets/images/2.png'));
        if (data.length > 3) data.insert(4, Banner2('assets/images/3.png'));
        if (data.length > 4) data.insert(6, Banner2('assets/images/4.png'));
        if (data.length > 5) data.insert(9, Banner2('assets/images/5.png'));
        loadingCategory(false);
        homeList.assignAll(data);
      } else {
        var error = jsonDecode(response.body);
        print(error['message'] ?? '');
      }
    } on Exception catch (e) {
      loadingCategory(false);
      print(e.toString());
    }
  }

  void getProductsByCategory(String id) async {
    try {
      products.clear();
      loading(true);
      productsEmpty.value = false;
      var url =
          "$baseUrlApi/products?searchCriteria[filter_groups][0][filters][0][field]=category_id&searchCriteria[filter_groups][0][filters][0][value]=$id&searchCriteria[filter_groups][0][filters][0][condition_type]=eq";
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

class Banner2 {
  final String image;

  Banner2(this.image);
}
