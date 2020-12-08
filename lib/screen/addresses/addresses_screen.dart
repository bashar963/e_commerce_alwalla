import 'package:e_commerce_alwalla/controller/address_controller.dart';
import 'package:e_commerce_alwalla/model/customer/customer_response.dart';
import 'package:e_commerce_alwalla/screen/addresses/add_address_screen.dart';
import 'package:e_commerce_alwalla/screen/addresses/edit_address_screen.dart';
import 'package:e_commerce_alwalla/theme/app_theme.dart';
import 'package:e_commerce_alwalla/utils/common.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:slide_item/slide_item.dart';

class AddressesScreen extends StatefulWidget {
  @override
  _AddressesScreenState createState() => _AddressesScreenState();
}

class _AddressesScreenState extends State<AddressesScreen> {
  final AddressController _addressesController = Get.find();

  @override
  void initState() {
    super.initState();
    _addressesController.loadAddresses();
  }

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
                  onPressed: () {
                    Get.to(AddAddressScreen());
                  },
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
    return Obx(() {
      if (_addressesController.loading.value)
        return Center(
          child: RefreshProgressIndicator(),
        );
      if (_addressesController.addresses.isEmpty) {
        return Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              'No address found add a new to address now',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),
          ),
        );
      }
      return SlideConfiguration(
        config: SlideConfig(
            slideOpenAnimDuration: Duration(milliseconds: 200),
            slideCloseAnimDuration: Duration(milliseconds: 400),
            deleteStep1AnimDuration: Duration(milliseconds: 250),
            deleteStep2AnimDuration: Duration(milliseconds: 300),
            supportElasticity: true,
            closeOpenedItemOnTouch: true,
            slideWidth: 100,
            actionOpenCloseThreshold: 0.3,
            backgroundColor: whiteColor),
        child: ListView.builder(
            itemCount: _addressesController.addresses.length,
            shrinkWrap: true,
            physics: BouncingScrollPhysics(),
            itemBuilder: (c, i) =>
                addressItem(_addressesController.addresses[i], i)),
      );
    });
  }

  addressItem(Addresses address, index) {
    return Builder(builder: (c) {
      return SlideItem(
        slidable: true,
        indexInList: index,
        actions: [
          SlideAction(
              actionWidget: Container(
                decoration: BoxDecoration(
                  color: redColor,
                ),
                child: Center(
                  child: SvgPicture.asset(
                    "assets/icons/ic_delete.svg",
                    color: whiteColor,
                    width: 24,
                  ),
                ),
              ),
              tapCallback: (_) {
                print('debug -> click at  ${_.indexInList}');
                removeItem(address);
                _.close();
              })
        ],
        child: ListTile(
          contentPadding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          title: Text(
            address.city,
            style: mainTextStyle,
          ),
          subtitle: Text(
            getFullAddress(address),
            style: subTextStyle.copyWith(color: mainTextColor),
          ),
          onTap: () {
            Get.to(EditAddressScreen(
              addresses: address,
            ));
          },
          trailing: Container(
            width: 28,
            height: 28,
            decoration: BoxDecoration(
                color: blackColor.withOpacity(0.06),
                borderRadius: BorderRadius.circular(14)),
            child: _addressesController.selectedAddress.value.id == address.id
                ? CircleAvatar(
                    backgroundColor: redColor,
                    child: Icon(
                      Icons.check,
                      color: whiteColor,
                    ),
                  )
                : const SizedBox.shrink(),
          ),
        ),
      );
    });
  }

  void removeItem(Addresses address) {
    _addressesController.deleteAddress(address);
  }
}
