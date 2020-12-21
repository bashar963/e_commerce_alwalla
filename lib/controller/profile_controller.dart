import 'dart:convert';

import 'package:e_commerce_alwalla/data/app_preference.dart';
import 'package:e_commerce_alwalla/data/main_api/main_api.dart';
import 'package:e_commerce_alwalla/model/customer/customer_response.dart';
import 'package:e_commerce_alwalla/utils/common.dart';
import 'package:get/get.dart';

class ProfileController extends GetxController {
  var user = Customer().obs;
  var loading = false.obs;
  @override
  void onInit() {
    super.onInit();
    loadCustomer();
  }

  void loadCustomer() async {
    if (AppPreference.token != null) {
      try {
        var response = await MainApi.create().getUserData(AppPreference.token);
        print(response.bodyString);
        print(response.error);
        if (response.isSuccessful) {
          user.value = Customer.fromJson(response.body);
        } else {
          var error = jsonDecode(response.error.toString());

          showFailedMessage(Get.context, error['message'] ?? '');
        }
      } on Exception catch (e) {
        showFailedMessage(Get.context, e.toString() ?? '');
      }
    }
  }

  void updateProfile(String firstName, String lastName, String email) async {
    try {
      user.value.firstname = firstName;
      user.value.lastname = lastName;
      user.value.email = email;
      loading(true);
      print(user.toJson());
      var response = await MainApi.create().updateUserProfile(
          AppPreference.token, {"customer": user.value.toJson()});
      print(response.bodyString);
      print(response.error);
      loading(false);
      if (response.isSuccessful) {
        user.value = Customer.fromJson(response.body);
        showSuccessMessage(Get.context, 'Profile updated');
      } else {
        var error = jsonDecode(response.error.toString());

        showFailedMessage(Get.context, error['message'] ?? '');
      }
    } on Exception catch (e) {
      showFailedMessage(Get.context, e.toString() ?? '');
    }
  }
}
