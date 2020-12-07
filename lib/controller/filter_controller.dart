import 'dart:convert';

import 'package:e_commerce_alwalla/model/brands_response.dart';
import 'package:get/get.dart';
import 'package:http/http.dart';

class FilterController extends GetxController {
  RxList<BrandsResponse> brands = RxList();

  @override
  void onInit() {
    super.onInit();
    getBrands();
  }

  void getBrands() async {
    try {
      var url =
          "http://mymalleg.com/rest/V1/products/attributes/manufacturer/options";
      var response = await get(url);

      print(response.body);

      if (response.statusCode == 200) {
        var jsonString = jsonDecode(response.body);
        if (jsonString is List) {
          brands.clear();
          jsonString.forEach((element) {
            var brand = BrandsResponse.fromJson(element);
            if (brand.value.isNotEmpty) brands.add(brand);
          });
        }
      } else {
        var error = jsonDecode(response.body);
        print(error['message'] ?? '');
      }
    } on Exception catch (e) {
      print(e.toString());
    }
  }
}
