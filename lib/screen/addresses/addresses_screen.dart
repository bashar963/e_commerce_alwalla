import 'package:e_commerce_alwalla/controller/address_controller.dart';
import 'package:e_commerce_alwalla/theme/app_theme.dart';
import 'package:e_commerce_alwalla/utils/common.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddressesScreen extends StatefulWidget {
  @override
  _AddressesScreenState createState() => _AddressesScreenState();
}

class _AddressesScreenState extends State<AddressesScreen> {
  final _addressesController = Get.put(AddressController());
  List<Address> _address = [
    Address(
        "Home Address",
        "21, Alex Davidson Avenue, Opposite Omegatron, Vicent Smith Quarters, Victoria Island, Lagos, Nigeria",
        "1",
        isSelected: true),
    Address("Work Address",
        "19, Martins Crescent, Bank of Nigeria, Abuja, Nigeria", "2"),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        elevation: 0,
        brightness: Brightness.light,
        title: Text("Shipping Address"),
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
                  onPressed: () {},
                  child: Text(
                    "NEW",
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

  Widget body(BuildContext context) {
    return ListView.builder(
        itemCount: _address.length,
        shrinkWrap: true,
        physics: BouncingScrollPhysics(),
        itemBuilder: (c, i) => addressItem(_address[i]));
  }

  addressItem(Address address) {
    return ListTile(
      contentPadding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      title: Text(
        address.title + "\n",
        style: mainTextStyle,
      ),
      subtitle: Text(
        address.address,
        style: subTextStyle.copyWith(color: mainTextColor),
      ),
      onTap: () {
        setState(() {
          _address.forEach((element) {
            element.isSelected = false;
          });
          address.isSelected = true;
        });
      },
      trailing: Container(
        width: 28,
        height: 28,
        decoration: BoxDecoration(
            color: blackColor.withOpacity(0.06),
            borderRadius: BorderRadius.circular(14)),
        child: address.isSelected
            ? CircleAvatar(
                backgroundColor: redColor,
                child: Icon(
                  Icons.check,
                  color: whiteColor,
                ),
              )
            : const SizedBox.shrink(),
      ),
    );
  }
}

class Address {
  final String title, address, id;
  bool isSelected;
  Address(this.title, this.address, this.id, {this.isSelected = false});
}
