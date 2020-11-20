import 'dart:convert';

import 'package:e_commerce_alwalla/data/app_preference.dart';
import 'package:e_commerce_alwalla/data/main_api/main_api.dart';
import 'package:e_commerce_alwalla/model/customer/customer_response.dart';
import 'package:e_commerce_alwalla/utils/common.dart';
import 'package:get/get.dart';

class AddressController extends GetxController {
  RxList<Address> addresses = RxList();
  Rx<Address> selectedAddress = Rx(null);
  void loadAddresses() async {
    try {
      var response = await MainApi.create().getUserData(AppPreference.token);
      print(response.bodyString);
      print(response.error);
      if (response.isSuccessful) {
        var user = Customer.fromJson(response.body);
        addresses.assignAll(user.addresses);
      } else {
        var error = jsonDecode(response.error.toString());

        showFailedMessage(Get.context, error['message'] ?? '');
      }
    } on Exception catch (e) {
      showFailedMessage(Get.context, e.toString() ?? '');
    }
  }
}
