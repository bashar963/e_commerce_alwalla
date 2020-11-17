import 'package:e_commerce_alwalla/controller/checkout_controller.dart';

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
  final _checkoutBloc = Get.put(CheckoutController());
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
      bottomNavigationBar: Container(
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
                onPressed: () async {
                  if (_selectedIndex < 2) {
                    setState(() {
                      _selectedIndex++;
                    });
                  } else {
                    int index = await Navigator.push(context,
                        MaterialPageRoute(builder: (c) => SummaryScreen()));
                    setState(() {
                      _selectedIndex = index ?? 2;
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
      ),
    );
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
            children: <Widget>[delivery(), address(), payment()],
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
    return Column(
      children: [
        Expanded(
          child: ListView.builder(
            itemCount: _payments.length,
            shrinkWrap: true,
            physics: BouncingScrollPhysics(),
            itemBuilder: (c, i) => paymentItem(
              _payments[i],
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
  }

  paymentItem(Payment payment) {
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

          cardSelected = payment.id == "2";

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
    return ListView.builder(
        itemCount: _deliveries.length,
        shrinkWrap: true,
        physics: BouncingScrollPhysics(),
        itemBuilder: (c, i) => deliveryItem(_deliveries[i]));
  }

  deliveryItem(Delivery delivery) {
    return ListTile(
      contentPadding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      title: Text(
        delivery.title,
        style: mainTextStyle,
      ),
      subtitle: Text(
        delivery.desc,
        style: subTextStyle,
      ),
      onTap: () {
        setState(() {
          _deliveries.forEach((element) {
            element.isSelected = false;
          });
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
