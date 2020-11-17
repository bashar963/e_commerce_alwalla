import 'dart:convert';

import 'package:e_commerce_alwalla/data/app_preference.dart';
import 'package:e_commerce_alwalla/data/main_api/main_api.dart';
import 'package:e_commerce_alwalla/model/singup/sign_up_request.dart';
import 'package:e_commerce_alwalla/model/user_model/user_response.dart';
import 'package:e_commerce_alwalla/screen/home/home_screen.dart';
import 'package:e_commerce_alwalla/utils/common.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {
  var loading = false.obs;
  Rx<UserResponse> user = Rx(null);
  void signUp(SignUpRequest request) async {
    try {
      loading(true);
      var response = await MainApi.create().signUp(request.toJson());
      print(response.body);
      print(response.error);
      loading(false);
      if (response.isSuccessful) {
        showSuccessMessage(
            Get.context, "Account created successfully,\nyou can now login.");
        Future.delayed(Duration(seconds: 1), () {
          Get.back();
          Get.back(result: request.customer.email);
        });
      } else {
        var error = jsonDecode(response.error.toString());
        showFailedMessage(Get.context, error['message'] ?? '');
      }
    } on Exception catch (e) {
      loading(false);
      showFailedMessage(Get.context, e.toString());
    }
  }

  void login(String username, String password) async {
    try {
      loading(true);
      var response = await MainApi.create().login(username, password);
      loading(false);
      print(response.body);
      print(response.error);
      if (response.isSuccessful) {
        var token = jsonDecode(response.bodyString);
        AppPreference.token = 'Bearer ' + token.toString();

        loadUserData();
      } else {
        var error = jsonDecode(response.error.toString());
        showFailedMessage(Get.context, error['message'] ?? '');
      }
    } on Exception catch (e) {
      loading(false);
      showFailedMessage(Get.context, e.toString());
    }
  }

  void loadUserData() async {
    try {
      print(AppPreference.token);
      var response = await MainApi.create().getUserData(AppPreference.token);
      print(response.bodyString);
      print(response.error);
      if (response.isSuccessful) {
        user.value = UserResponse.fromJson(response.body);
        Get.offAll(HomeScreen());
      } else {
        var error = jsonDecode(response.error.toString());
        showFailedMessage(Get.context, error['message'] ?? '');
      }
    } on Exception catch (e) {
      showFailedMessage(Get.context, e.toString());
    }
  }
}
