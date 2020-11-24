import 'dart:convert';

import 'package:e_commerce_alwalla/data/app_preference.dart';
import 'package:e_commerce_alwalla/data/main_api/main_api.dart';
import 'package:e_commerce_alwalla/model/customer/customer_response.dart';
import 'package:e_commerce_alwalla/model/payment_methods_response.dart';
import 'package:e_commerce_alwalla/model/shipping_methods_response.dart';
import 'package:get/get.dart';

class CheckoutController extends GetxController {
  var isLoading = false.obs;
  RxList<ShippingMethodResponse> shippingMethods = RxList();
  Rx<PaymentMethodResponse> paymentMethods =
      Rx(PaymentMethodResponse(paymentMethods: []));
  void getShippingMethods(Addresses selectedAddress) async {
    try {
      isLoading(true);
      var response =
          await MainApi.create().getShippingMethods(AppPreference.token, {
        "address": {"country_id": selectedAddress.countryId}
      });
      isLoading(false);
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

  void getPaymentMethods(
      Addresses address, String shippingId, String shippingMethodId) async {
    try {
      isLoading(true);
      var response =
          await MainApi.create().getPaymentMethods(AppPreference.token, {
        "addressInformation": {
          "shippingAddress": {
            "region": address.region?.region ?? '',
            "region_id": address.regionId ?? '',
            "country_id": address.countryId ?? '',
            "street": address.street ?? [],
            "company": address.firstname ?? '',
            "telephone": address.telephone ?? '',
            "postcode": address.postcode ?? '',
            "city": address.city ?? '',
            "firstname": address.firstname ?? '',
            "lastname": address.lastname ?? '',
            "email": "abc@abc.com",
            "prefix": "address_",
            "region_code": address.region.regionCode ?? '',
            "sameAsBilling": 1
          },
          "billingAddress": {
            "region": address.region?.region ?? '',
            "region_id": address.regionId ?? '',
            "country_id": address.countryId ?? '',
            "street": address.street ?? [],
            "company": address.firstname ?? '',
            "telephone": address.telephone ?? '',
            "postcode": address.postcode ?? '',
            "city": address.city ?? '',
            "firstname": address.firstname ?? '',
            "lastname": address.lastname ?? '',
            "email": "abc@abc.com",
            "prefix": "address_",
            "region_code": address.region.regionCode ?? '',
          },
          "shipping_method_code": shippingMethodId,
          "shipping_carrier_code": shippingId
        }
      });
      print('---------getPaymentMethods-------');
      print(response.body);
      print(response.error);
      isLoading(false);
      if (response.isSuccessful) {
        paymentMethods.value = PaymentMethodResponse.fromJson(response.body);
      } else {
        var error = jsonDecode(response.error.toString());
        print(error);
      }
    } on Exception catch (e) {
      print(e.toString());
    }
  }

  void placeOrder() async {
    try {
      isLoading(true);
      var method = '';
      paymentMethods.value.paymentMethods.forEach((element) {
        if (element.isSelected) method = element.code;
      });
      var response = await MainApi.create().placeOrder(AppPreference.token, {
        "paymentMethod": {"method": method}
      });
      print('---------place order-------');
      print(response.bodyString);
      print(response.error);
      isLoading(false);
      if (response.isSuccessful) {
        Get.close(2);
      } else {
        var error = jsonDecode(response.error.toString());
        print(error);
      }
    } on Exception catch (e) {
      print(e.toString());
    }
  }
}
