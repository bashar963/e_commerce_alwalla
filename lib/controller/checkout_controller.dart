import 'dart:convert';

import 'package:e_commerce_alwalla/data/app_preference.dart';
import 'package:e_commerce_alwalla/data/main_api/main_api.dart';
import 'package:e_commerce_alwalla/model/customer/customer_response.dart';
import 'package:e_commerce_alwalla/model/shipping_methods_response.dart';
import 'package:get/get.dart';

class CheckoutController extends GetxController {
  var isLoading = false.obs;
  RxList<ShippingMethodResponse> shippingMethods = RxList();

  void getShippingMethods(Addresses selectedAddress) async {
    try {
      var response =
          await MainApi.create().getShippingMethods(AppPreference.token, {
        "address": {"country_id": selectedAddress.countryId}
      });
      print('---------getShippingMethods-------');
      print(response.bodyString);
      print(response.error);
      if (response.isSuccessful) {
        var responses = jsonDecode(response.bodyString);
        List<ShippingMethodResponse> list = [];
        if (responses is List) {
          responses.forEach((e) {
            if (e['available'] == true)
              list.add(ShippingMethodResponse.fromJson(e));
          });
        }
        shippingMethods.assignAll(list);
      } else {
        var error = jsonDecode(response.error.toString());
        print(error);
      }
    } on Exception catch (e) {
      print(e.toString());
    }
  }

  void getPaymentMethods() async {
    try {
      print(AppPreference.token);
      var response =
          await MainApi.create().getPaymentMethods(AppPreference.token);
      print('---------getPaymentMethods-------');
      print(response.body);
      print(response.error);
      if (response.isSuccessful) {
      } else {
        var error = jsonDecode(response.error.toString());
        print(error);
      }
    } on Exception catch (e) {
      print(e.toString());
    }
  }
}
