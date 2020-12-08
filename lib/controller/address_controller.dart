import 'dart:convert';

import 'package:e_commerce_alwalla/data/app_preference.dart';
import 'package:e_commerce_alwalla/data/main_api/main_api.dart';
import 'package:e_commerce_alwalla/model/customer/customer_response.dart';
import 'package:e_commerce_alwalla/utils/common.dart';
import 'package:get/get.dart';

class AddressController extends GetxController {
  RxList<Addresses> addresses = RxList();
  var user = Customer().obs;
  var loading = false.obs;
  Rx<Addresses> selectedAddress = Rx(null);
  void loadAddresses() async {
    try {
      loading(true);
      var response = await MainApi.create().getUserData(AppPreference.token);
      print(response.bodyString);
      print(response.error);
      loading(false);
      if (response.isSuccessful) {
        user.value = Customer.fromJson(response.body);
        addresses.assignAll(user.value.addresses);

        if (AppPreference.defAddressID.isEmpty) {
          addresses.forEach((element) {
            if (element.defaultBilling != null) {
              AppPreference.defAddressID = element.id.toString();
              selectedAddress.value = element;
            }
          });
          if (AppPreference.defAddressID.isEmpty && addresses.isNotEmpty) {
            selectedAddress.value = addresses.first;
            AppPreference.defAddressID = selectedAddress.value.id.toString();
          }
        } else {
          addresses.forEach((element) {
            if (element.id.toString() == AppPreference.defAddressID) {
              AppPreference.defAddressID = element.id.toString();
              selectedAddress.value = element;
            }
          });
          if (selectedAddress.value == null) {
            selectedAddress.value = addresses.first;
            AppPreference.defAddressID = selectedAddress.value.id.toString();
          }
        }
      } else {
        var error = jsonDecode(response.error.toString());

        showFailedMessage(Get.context, error['message'] ?? '');
      }
    } on Exception catch (e) {
      showFailedMessage(Get.context, e.toString() ?? '');
    }
  }

  void addAddress(String street1, String street2, String number, String city,
      String state, String country, String postcode) async {
    try {
      user.value.addresses.add(Addresses(
          street: [street1, street2],
          telephone: number,
          customerId: user.value.id,
          region: Region(region: state, regionCode: state, regionId: 0),
          countryId: 'EG',
          city: city,
          postcode: postcode,
          defaultBilling: true,
          defaultShipping: true,
          firstname: user.value.firstname,
          lastname: user.value.lastname));
      print(user.toJson());
      var response = await MainApi.create().updateUserProfile(
          AppPreference.token, {"customer": user.value.toJson()});
      print(response.bodyString);
      print(response.error);
      if (response.isSuccessful) {
        user.value = Customer.fromJson(response.body);
        addresses.assignAll(user.value.addresses);
        showSuccessMessage(Get.context, 'Address has ben added successfully');
        Future.delayed(Duration(seconds: 1), () {
          Get.back();
          Get.back();
        });
      } else {
        var error = jsonDecode(response.error.toString());

        showFailedMessage(Get.context, error['message'] ?? '');
      }
    } on Exception catch (e) {
      showFailedMessage(Get.context, e.toString() ?? '');
    }
  }

  void editAddress(
      String addressId,
      bool asDefault,
      String street1,
      String street2,
      String number,
      String city,
      String state,
      String country,
      String postcode) async {
    try {
      user.value.addresses.forEach((element) {
        if (element.id.toString() == addressId) {
          element.street.clear();
          element.street.addAll([street1, street2]);
          element.telephone = number;
          element.region =
              Region(region: state, regionCode: state, regionId: 0);
          element.city = city;
          element.postcode = postcode;
          selectedAddress.value = element;
        }
      });
      print(user.toJson());
      var response = await MainApi.create().updateUserProfile(
          AppPreference.token, {"customer": user.value.toJson()});
      print(response.bodyString);
      print(response.error);
      if (response.isSuccessful) {
        user.value = Customer.fromJson(response.body);
        addresses.assignAll(user.value.addresses);
        showSuccessMessage(Get.context, 'Address has ben Edited successfully');
        Future.delayed(Duration(seconds: 1), () {
          Get.back();
          Get.back();
        });
      } else {
        var error = jsonDecode(response.error.toString());

        showFailedMessage(Get.context, error['message'] ?? '');
      }
    } on Exception catch (e) {
      showFailedMessage(Get.context, e.toString() ?? '');
    }
  }

  void deleteAddress(Addresses address) async {
    try {
      user.value.addresses.remove(address);

      print(user.toJson());
      var response = await MainApi.create().updateUserProfile(
          AppPreference.token, {"customer": user.value.toJson()});
      print(response.bodyString);
      print(response.error);
      if (response.isSuccessful) {
        user.value = Customer.fromJson(response.body);
        addresses.assignAll(user.value.addresses);
      } else {
        var error = jsonDecode(response.error.toString());

        showFailedMessage(Get.context, error['message'] ?? '');
      }
    } on Exception catch (e) {
      showFailedMessage(Get.context, e.toString() ?? '');
    }
  }
}
