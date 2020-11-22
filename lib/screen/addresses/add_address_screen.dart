import 'package:e_commerce_alwalla/controller/address_controller.dart';
import 'package:e_commerce_alwalla/theme/app_theme.dart';
import 'package:e_commerce_alwalla/utils/common.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddAddressScreen extends StatefulWidget {
  @override
  _AddAddressScreenState createState() => _AddAddressScreenState();
}

class _AddAddressScreenState extends State<AddAddressScreen> {
  final street1Controller = TextEditingController();
  final street2Controller = TextEditingController();
  final cityController = TextEditingController();
  final numberController = TextEditingController();
  final stateController = TextEditingController();
  final countryController = TextEditingController();
  final postCodeController = TextEditingController();

  final AddressController _addressesController = Get.find();
  String street1Error,
      street2Error,
      cityError,
      postCodeError,
      numberError,
      stateError,
      countryError;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        elevation: 0,
        brightness: Brightness.light,
        title: Text("Add Address"),
        centerTitle: true,
        backgroundColor: whiteColor,
      ),
      body: GestureDetector(
          onTap: () {
            hideKeyboard(context);
          },
          child: body(context)),
      bottomNavigationBar: Container(
        padding: EdgeInsets.symmetric(vertical: 24, horizontal: 24),
        color: whiteColor,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: SizedBox(),
            ),
            const SizedBox(
              width: 16,
            ),
            Expanded(
              child: Container(
                height: 50,
                child: RaisedButton(
                  elevation: 0,
                  color: redColor,
                  onPressed: addAddress,
                  child: Text(
                    "Add",
                    style: subTextStyle.copyWith(color: whiteColor),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  body(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SizedBox(
            height: 32,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: TextFormField(
              controller: street1Controller,
              keyboardType: TextInputType.text,
              cursorWidth: 1,
              autofocus: false,
              style: TextStyle(
                  color: mainTextColor,
                  fontWeight: FontWeight.w600,
                  fontSize: 16),
              decoration: InputDecoration(
                labelText: "Street 1",
                errorText: street1Error,
                labelStyle: TextStyle(
                  color: subTextColor,
                  fontWeight: FontWeight.w200,
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 24,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: TextFormField(
              controller: street2Controller,
              keyboardType: TextInputType.text,
              cursorWidth: 1,
              autofocus: false,
              style: TextStyle(
                  color: mainTextColor,
                  fontWeight: FontWeight.w600,
                  fontSize: 16),
              decoration: InputDecoration(
                labelText: "Street 2",
                errorText: street2Error,
                labelStyle: TextStyle(
                  color: subTextColor,
                  fontWeight: FontWeight.w200,
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 24,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: TextFormField(
              controller: numberController,
              keyboardType: TextInputType.number,
              cursorWidth: 1,
              autofocus: false,
              style: TextStyle(
                  color: mainTextColor,
                  fontWeight: FontWeight.w600,
                  fontSize: 16),
              decoration: InputDecoration(
                labelText: "Phone Number",
                errorText: numberError,
                labelStyle: TextStyle(
                  color: subTextColor,
                  fontWeight: FontWeight.w200,
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 24,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: TextFormField(
              controller: postCodeController,
              keyboardType: TextInputType.number,
              cursorWidth: 1,
              autofocus: false,
              style: TextStyle(
                  color: mainTextColor,
                  fontWeight: FontWeight.w600,
                  fontSize: 16),
              decoration: InputDecoration(
                labelText: "Post code",
                errorText: postCodeError,
                labelStyle: TextStyle(
                  color: subTextColor,
                  fontWeight: FontWeight.w200,
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 24,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: TextFormField(
              controller: cityController,
              keyboardType: TextInputType.text,
              cursorWidth: 1,
              autofocus: false,
              style: TextStyle(
                  color: mainTextColor,
                  fontWeight: FontWeight.w600,
                  fontSize: 16),
              decoration: InputDecoration(
                labelText: "City",
                errorText: cityError,
                labelStyle: TextStyle(
                  color: subTextColor,
                  fontWeight: FontWeight.w200,
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 24,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Row(
              children: [
                Expanded(
                    child: TextFormField(
                  controller: stateController,
                  keyboardType: TextInputType.text,
                  cursorWidth: 1,
                  autofocus: false,
                  style: TextStyle(
                      color: mainTextColor,
                      fontWeight: FontWeight.w600,
                      fontSize: 16),
                  decoration: InputDecoration(
                    labelText: "State",
                    errorText: stateError,
                    labelStyle: TextStyle(
                      color: subTextColor,
                      fontWeight: FontWeight.w200,
                    ),
                  ),
                )),
                const SizedBox(
                  width: 16,
                ),
                Expanded(
                    child: TextFormField(
                  controller: countryController,
                  keyboardType: TextInputType.text,
                  cursorWidth: 1,
                  autofocus: false,
                  style: TextStyle(
                      color: mainTextColor,
                      fontWeight: FontWeight.w600,
                      fontSize: 16),
                  decoration: InputDecoration(
                    labelText: "Country",
                    errorText: countryError,
                    labelStyle: TextStyle(
                      color: subTextColor,
                      fontWeight: FontWeight.w200,
                    ),
                  ),
                )),
              ],
            ),
          ),
          const SizedBox(
            height: 64,
          ),
        ],
      ),
    );
  }

  void addAddress() {
    if (street1Controller.text.isEmpty) {
      setState(() {
        street1Error = "Required Field";
      });
      return;
    }

    if (numberController.text.isEmpty) {
      setState(() {
        numberError = "Required Field";
      });
      return;
    }

    if (cityController.text.isEmpty) {
      setState(() {
        cityError = "Required Field";
      });
      return;
    }
    if (stateController.text.isEmpty) {
      setState(() {
        stateError = "Required Field";
      });
      return;
    }
    if (countryController.text.isEmpty) {
      setState(() {
        countryError = "Required Field";
      });
      return;
    }
    if (postCodeController.text.isEmpty) {
      setState(() {
        postCodeError = "Required Field";
      });
      return;
    }
    _addressesController.addAddress(
        street1Controller.text,
        street2Controller.text,
        numberController.text,
        cityController.text,
        stateController.text,
        countryController.text,
        postCodeController.text);
  }
}
