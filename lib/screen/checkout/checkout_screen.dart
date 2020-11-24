import 'package:e_commerce_alwalla/controller/address_controller.dart';
import 'package:e_commerce_alwalla/controller/checkout_controller.dart';
import 'package:e_commerce_alwalla/generated/l10n.dart';
import 'package:e_commerce_alwalla/model/customer/customer_response.dart';
import 'package:e_commerce_alwalla/model/payment_methods_response.dart';
import 'package:e_commerce_alwalla/model/shipping_methods_response.dart';
import 'package:e_commerce_alwalla/screen/addresses/add_address_screen.dart';

import 'package:e_commerce_alwalla/screen/checkout/summary/summary_screen.dart';
import 'package:e_commerce_alwalla/theme/app_theme.dart';
import 'package:e_commerce_alwalla/utils/common.dart';
import 'package:e_commerce_alwalla/widget/my_stepper.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

class CheckoutScreen extends StatefulWidget {
  @override
  _CheckoutScreenState createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  final CheckoutController _checkoutBloc = Get.find();
  final AddressController _addressesController = Get.find();
  int _selectedIndex = 0;

  final street1Controller = TextEditingController();
  final street2Controller = TextEditingController();
  final cityController = TextEditingController();
  final numberController = TextEditingController();
  final stateController = TextEditingController();
  final countryController = TextEditingController();
  final _numberController = TextEditingController();
  final _nameController = TextEditingController();
  final _expController = TextEditingController();
  final _cvvController = TextEditingController();
  String _numberError, nameError, expError, cvvError;
  String street1Error,
      street2Error,
      cityError,
      numberError,
      stateError,
      countryError;

  bool _hasSelectedShippingMethod = false;
  bool _hasSelectedPaymentMethod = false;
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
          backgroundColor: whiteColor,
          title: Text("Checkout"),
          centerTitle: true,
          elevation: 0,
        ),
        body: GestureDetector(
            onTap: () {
              hideKeyboard(context);
            },
            child: body(context)),
        bottomNavigationBar: Obx(() {
          return Container(
            padding: EdgeInsets.symmetric(vertical: 24, horizontal: 24),
            color: whiteColor,
            child: Row(
              children: [
                Expanded(
                    child: _selectedIndex == 0
                        ? const SizedBox()
                        : Container(
                            height: 50,
                            child: OutlineButton(
                              highlightedBorderColor: redColor,
                              highlightColor: whiteColor,
                              color: redColor,
                              borderSide: BorderSide(color: redColor),
                              onPressed: () {
                                setState(() {
                                  if (_selectedIndex > 0) {
                                    _selectedIndex--;
                                  }
                                  if (_selectedIndex == 1) {
                                    _hasSelectedPaymentMethod = false;
                                  }
                                  if (_selectedIndex == 0) {
                                    _hasSelectedShippingMethod = false;
                                  }
                                });
                              },
                              child: Text(
                                "BACK",
                                style: subTextStyle.copyWith(color: blackColor),
                              ),
                            ),
                          )),
                const SizedBox(
                  width: 24,
                ),
                Expanded(
                    child: Container(
                  height: 50,
                  child: RaisedButton(
                    elevation: 0,
                    color: redColor,
                    onPressed: _selectedIndex == 0 &&
                            _addressesController.selectedAddress.value == null
                        ? null
                        : _selectedIndex == 1 && !_hasSelectedShippingMethod
                            ? null
                            : _selectedIndex == 2 && !_hasSelectedPaymentMethod
                                ? null
                                : () async {
                                    if (_selectedIndex < 2) {
                                      setState(() {
                                        _selectedIndex++;
                                      });
                                      if (_selectedIndex == 1) {
                                        _checkoutBloc.getShippingMethods(
                                            _addressesController
                                                .selectedAddress.value);
                                      }
                                      if (_selectedIndex == 2) {
                                        ShippingMethodResponse selectedMethod;
                                        _checkoutBloc.shippingMethods
                                            .forEach((element) {
                                          if (element.isSelected)
                                            selectedMethod = element;
                                        });
                                        _checkoutBloc.getPaymentMethods(
                                            _addressesController
                                                .selectedAddress.value,
                                            selectedMethod.carrierCode,
                                            selectedMethod.methodCode);
                                      }
                                    } else {
                                      int index = await Get.to(SummaryScreen());
                                      setState(() {
                                        _selectedIndex = index ?? 2;
                                        _hasSelectedPaymentMethod = false;

                                        _hasSelectedShippingMethod = false;
                                      });
                                    }
                                  },
                    child: Text(
                      "NEXT",
                      style: subTextStyle.copyWith(color: whiteColor),
                    ),
                  ),
                ))
              ],
            ),
          );
        }));
  }

  Widget body(BuildContext context) {
    return Column(
      children: [
        const SizedBox(
          height: 24,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: MyStepper(
            selectedIndex: _selectedIndex,
          ),
        ),
        Expanded(
          child: IndexedStack(
            children: <Widget>[address(), delivery(), payment()],
            index: _selectedIndex,
          ),
        )
      ],
    );
  }

  bool isSameBilling = true;
  Widget address() {
    return SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      child: Column(
        children: [
          const SizedBox(
            height: 32,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: CheckboxListTile(
                value: isSameBilling,
                title: Text(
                  "Billing address is the same as delivery address",
                  style: subTextStyle.copyWith(fontSize: 18),
                ),
                onChanged: (v) {
                  setState(() {
                    isSameBilling = v;
                  });
                }),
          ),
          const SizedBox(
            height: 16,
          ),
          userAddresses(),
          Text(S.of(context).or),
          const SizedBox(
            height: 32,
          ),
          Container(
            height: 50,
            width: MediaQuery.of(context).size.width,
            margin: const EdgeInsets.symmetric(horizontal: 24),
            child: RaisedButton(
              elevation: 0,
              color: redColor,
              onPressed: () {
                Get.to(AddAddressScreen());
              },
              child: Text(
                "NEW ADDRESS",
                style: subTextStyle.copyWith(color: whiteColor),
              ),
            ),
          ),
          // Padding(
          //   padding: const EdgeInsets.symmetric(horizontal: 24),
          //   child: TextFormField(
          //     controller: street1Controller,
          //     keyboardType: TextInputType.text,
          //     cursorWidth: 1,
          //     autofocus: false,
          //     style: TextStyle(
          //         color: mainTextColor,
          //         fontWeight: FontWeight.w600,
          //         fontSize: 16),
          //     decoration: InputDecoration(
          //       labelText: "Street 1",
          //       errorText: street1Error,
          //       labelStyle: TextStyle(
          //         color: subTextColor,
          //         fontWeight: FontWeight.w200,
          //       ),
          //     ),
          //   ),
          // ),
          // const SizedBox(
          //   height: 24,
          // ),
          // Padding(
          //   padding: const EdgeInsets.symmetric(horizontal: 24),
          //   child: TextFormField(
          //     controller: street2Controller,
          //     keyboardType: TextInputType.text,
          //     cursorWidth: 1,
          //     autofocus: false,
          //     style: TextStyle(
          //         color: mainTextColor,
          //         fontWeight: FontWeight.w600,
          //         fontSize: 16),
          //     decoration: InputDecoration(
          //       labelText: "Street 2",
          //       errorText: street2Error,
          //       labelStyle: TextStyle(
          //         color: subTextColor,
          //         fontWeight: FontWeight.w200,
          //       ),
          //     ),
          //   ),
          // ),
          // const SizedBox(
          //   height: 24,
          // ),
          // Padding(
          //   padding: const EdgeInsets.symmetric(horizontal: 24),
          //   child: TextFormField(
          //     controller: numberController,
          //     keyboardType: TextInputType.number,
          //     cursorWidth: 1,
          //     autofocus: false,
          //     style: TextStyle(
          //         color: mainTextColor,
          //         fontWeight: FontWeight.w600,
          //         fontSize: 16),
          //     decoration: InputDecoration(
          //       labelText: "Phone Number",
          //       errorText: numberError,
          //       labelStyle: TextStyle(
          //         color: subTextColor,
          //         fontWeight: FontWeight.w200,
          //       ),
          //     ),
          //   ),
          // ),
          // const SizedBox(
          //   height: 24,
          // ),
          // Padding(
          //   padding: const EdgeInsets.symmetric(horizontal: 24),
          //   child: TextFormField(
          //     controller: cityController,
          //     keyboardType: TextInputType.text,
          //     cursorWidth: 1,
          //     autofocus: false,
          //     style: TextStyle(
          //         color: mainTextColor,
          //         fontWeight: FontWeight.w600,
          //         fontSize: 16),
          //     decoration: InputDecoration(
          //       labelText: "City",
          //       errorText: cityError,
          //       labelStyle: TextStyle(
          //         color: subTextColor,
          //         fontWeight: FontWeight.w200,
          //       ),
          //     ),
          //   ),
          // ),
          // const SizedBox(
          //   height: 24,
          // ),
          // Padding(
          //   padding: const EdgeInsets.symmetric(horizontal: 24),
          //   child: Row(
          //     children: [
          //       Expanded(
          //           child: TextFormField(
          //         controller: stateController,
          //         keyboardType: TextInputType.text,
          //         cursorWidth: 1,
          //         autofocus: false,
          //         style: TextStyle(
          //             color: mainTextColor,
          //             fontWeight: FontWeight.w600,
          //             fontSize: 16),
          //         decoration: InputDecoration(
          //           labelText: "State",
          //           errorText: stateError,
          //           labelStyle: TextStyle(
          //             color: subTextColor,
          //             fontWeight: FontWeight.w200,
          //           ),
          //         ),
          //       )),
          //       const SizedBox(
          //         width: 16,
          //       ),
          //       Expanded(
          //           child: TextFormField(
          //         controller: countryController,
          //         keyboardType: TextInputType.text,
          //         cursorWidth: 1,
          //         autofocus: false,
          //         style: TextStyle(
          //             color: mainTextColor,
          //             fontWeight: FontWeight.w600,
          //             fontSize: 16),
          //         decoration: InputDecoration(
          //           labelText: "Country",
          //           errorText: countryError,
          //           labelStyle: TextStyle(
          //             color: subTextColor,
          //             fontWeight: FontWeight.w200,
          //           ),
          //         ),
          //       )),
          //     ],
          //   ),
          // ),
          const SizedBox(
            height: 64,
          ),
        ],
      ),
    );
  }

  List<Payment> _payments = [
    Payment("1", "Cash on Delivery", isSelected: true),
    Payment("2", "Credit Card")
  ];
  List<Delivery> _deliveries = [
    Delivery("id", "Standard Delivery",
        "Order will be delivered between 3 - 5 business days",
        isSelected: true),
    Delivery("id", "Next Day Delivery",
        "Place your order before 6pm and your items will be delivered the next day"),
    Delivery("id", "Nominated Delivery",
        "Pick a particular date from the calendar and order will be delivered on selected date"),
  ];
  bool cardSelected = false;
  Widget payment() {
    return Obx(() {
      return Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount:
                  _checkoutBloc.paymentMethods.value.paymentMethods.length,
              shrinkWrap: true,
              physics: BouncingScrollPhysics(),
              itemBuilder: (c, i) => paymentItem(
                _checkoutBloc.paymentMethods.value.paymentMethods[i],
              ),
            ),
          ),
          if (cardSelected)
            const SizedBox(
              height: 32,
            ),
          if (cardSelected)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: TextFormField(
                controller: _nameController,
                keyboardType: TextInputType.text,
                cursorWidth: 1,
                autofocus: false,
                style: TextStyle(
                    color: mainTextColor,
                    fontWeight: FontWeight.w600,
                    fontSize: 16),
                decoration: InputDecoration(
                  labelText: "Card Holder",
                  errorText: nameError,
                  labelStyle: TextStyle(
                    color: subTextColor,
                    fontWeight: FontWeight.w200,
                  ),
                ),
              ),
            ),
          if (cardSelected)
            const SizedBox(
              height: 24,
            ),
          if (cardSelected)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: TextFormField(
                controller: _numberController,
                keyboardType: TextInputType.number,
                cursorWidth: 1,
                autofocus: false,
                style: TextStyle(
                    color: mainTextColor,
                    fontWeight: FontWeight.w600,
                    fontSize: 16),
                decoration: InputDecoration(
                  labelText: "Card Number",
                  errorText: _numberError,
                  labelStyle: TextStyle(
                    color: subTextColor,
                    fontWeight: FontWeight.w200,
                  ),
                ),
              ),
            ),
          if (cardSelected)
            const SizedBox(
              height: 24,
            ),
          if (cardSelected)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Row(
                children: [
                  Expanded(
                      child: TextFormField(
                    controller: _expController,
                    keyboardType: TextInputType.datetime,
                    cursorWidth: 1,
                    autofocus: false,
                    style: TextStyle(
                        color: mainTextColor,
                        fontWeight: FontWeight.w600,
                        fontSize: 16),
                    decoration: InputDecoration(
                      labelText: "Expiry Date",
                      errorText: expError,
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
                    controller: _cvvController,
                    keyboardType: TextInputType.number,
                    cursorWidth: 1,
                    autofocus: false,
                    style: TextStyle(
                        color: mainTextColor,
                        fontWeight: FontWeight.w600,
                        fontSize: 16),
                    decoration: InputDecoration(
                      labelText: "CVV",
                      errorText: cvvError,
                      labelStyle: TextStyle(
                        color: subTextColor,
                        fontWeight: FontWeight.w200,
                      ),
                    ),
                  )),
                ],
              ),
            ),
          if (cardSelected)
            const SizedBox(
              height: 64,
            ),
        ],
      );
    });
  }

  paymentItem(PaymentMethod payment) {
    return ListTile(
      contentPadding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      title: Text(
        payment.title,
        style: mainTextStyle,
      ),
      onTap: () {
        setState(() {
          _payments.forEach((element) {
            element.isSelected = false;
          });
          _hasSelectedPaymentMethod = true;
          // cardSelected = payment.id == "2";

          payment.isSelected = true;
        });
      },
      trailing: Container(
        width: 38,
        height: 38,
        decoration: BoxDecoration(
            color: blackColor.withOpacity(0.06),
            borderRadius: BorderRadius.circular(19)),
        child: payment.isSelected
            ? Padding(
                padding: const EdgeInsets.all(6.0),
                child: CircleAvatar(
                  backgroundColor: redColor,
                ),
              )
            : const SizedBox.shrink(),
      ),
    );
  }

  Widget delivery() {
    return Obx(() {
      print(_checkoutBloc.shippingMethods.length.toString());
      return ListView.builder(
          itemCount: _checkoutBloc.shippingMethods.length,
          shrinkWrap: true,
          physics: BouncingScrollPhysics(),
          itemBuilder: (c, i) =>
              deliveryItem(_checkoutBloc.shippingMethods[i]));
    });
  }

  deliveryItem(ShippingMethodResponse delivery) {
    return ListTile(
      contentPadding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      title: Text(
        delivery.carrierTitle,
        style: mainTextStyle,
      ),
      subtitle: Text(
        delivery.amount.toStringAsFixed(2) + " EGP",
        style: subTextStyle,
      ),
      onTap: () {
        setState(() {
          _deliveries.forEach((element) {
            element.isSelected = false;
          });
          _hasSelectedShippingMethod = true;
          delivery.isSelected = true;
        });
      },
      trailing: Container(
        width: 38,
        height: 38,
        decoration: BoxDecoration(
            color: blackColor.withOpacity(0.06),
            borderRadius: BorderRadius.circular(19)),
        child: delivery.isSelected
            ? Padding(
                padding: const EdgeInsets.all(6.0),
                child: CircleAvatar(
                  backgroundColor: redColor,
                ),
              )
            : const SizedBox.shrink(),
      ),
    );
  }

  Widget userAddresses() {
    return Obx(() {
      return ListView.builder(
          itemCount: _addressesController.addresses.length,
          shrinkWrap: true,
          physics: BouncingScrollPhysics(),
          itemBuilder: (c, i) =>
              addressItem(_addressesController.addresses[i]));
    });
  }

  addressItem(Addresses address) {
    return ListTile(
      contentPadding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      title: Text(
        _addressesController.selectedAddress.value.id == address.id
            ? 'Default Address'
            : "Secondary Address",
        style: mainTextStyle,
      ),
      subtitle: Text(
        getFullAddress(address),
        style: subTextStyle.copyWith(color: mainTextColor),
      ),
      onTap: () {
        _addressesController.selectedAddress.value = address;
        _addressesController.addresses.refresh();
      },
      trailing: Container(
        width: 28,
        height: 28,
        decoration: BoxDecoration(
            color: blackColor.withOpacity(0.06),
            borderRadius: BorderRadius.circular(14)),
        child: _addressesController.selectedAddress.value == address
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

class Delivery {
  final String id, title, desc;
  bool isSelected;

  Delivery(this.id, this.title, this.desc, {this.isSelected = false});
}

class Payment {
  final String id, title;
  bool isSelected;

  Payment(this.id, this.title, {this.isSelected = false});
}
