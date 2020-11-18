import 'package:e_commerce_alwalla/controller/login_controller.dart';
import 'package:e_commerce_alwalla/generated/l10n.dart';
import 'package:e_commerce_alwalla/theme/app_theme.dart';
import 'package:e_commerce_alwalla/utils/common.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddEmailScreen extends StatefulWidget {
  @override
  _AddEmailScreenState createState() => _AddEmailScreenState();
}

class _AddEmailScreenState extends State<AddEmailScreen> {
  final LoginController _loginController = Get.find();
  String _emailError;
  final TextEditingController _emailController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
      ),
      body: Stack(
        children: [
          GestureDetector(
              onTap: () {
                hideKeyboard(context);
              },
              child: body(context)),
          Obx(() {
            return _loginController.loading.value
                ? Center(child: RefreshProgressIndicator())
                : SizedBox();
          })
        ],
      ),
    );
  }

  Widget body(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(
              height: 32,
            ),
            Card(
              margin: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
              color: whiteColor,
              elevation: 0.4,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(6)),
              child: Container(
                padding: EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      S.of(context).account_restore,
                      style: mainTextStyle.copyWith(fontSize: 30),
                    ),
                    const SizedBox(
                      height: 6,
                    ),
                    Text(
                      S.of(context).enter_your_email,
                      style: subTextStyle,
                    ),
                    const SizedBox(
                      height: 48,
                    ),
                    TextFormField(
                      controller: _emailController,
                      keyboardType: TextInputType.emailAddress,
                      cursorWidth: 1,
                      textAlign: TextAlign.start,
                      textDirection: TextDirection.ltr,
                      autofocus: false,
                      onChanged: (s) {
                        setState(() {
                          _emailError = null;
                        });
                      },
                      style: TextStyle(
                          color: blackColor,
                          fontWeight: FontWeight.w800,
                          fontSize: 15),
                      decoration: InputDecoration(
                        labelText: S.of(context).email,
                        errorText: _emailError,
                        labelStyle: subTextStyle,
                        focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: colorAccent)),
                        border: UnderlineInputBorder(
                            borderSide: BorderSide(color: lightGrey)),
                      ),
                    ),
                    const SizedBox(
                      height: 60,
                    ),
                    Container(
                      height: 50,
                      child: RaisedButton(
                        elevation: 0,
                        onPressed: verifyEmail,
                        color: redColor,
                        child: Text(
                          S.of(context).restore,
                          style: subTextStyle.copyWith(
                              color: whiteColor, fontWeight: FontWeight.w400),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 24,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void verifyEmail() {
    if (!_emailController.text.isEmail) {
      setState(() {
        _emailError = S.of(context).required_field;
      });
      return;
    }
    _loginController.verifyEmail(_emailController.text);
  }
}
