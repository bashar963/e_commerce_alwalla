import 'package:e_commerce_alwalla/controller/login_controller.dart';
import 'package:e_commerce_alwalla/generated/l10n.dart';
import 'package:e_commerce_alwalla/model/singup/sign_up_request.dart';
import 'package:e_commerce_alwalla/theme/app_theme.dart';
import 'package:e_commerce_alwalla/utils/common.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignUpScreen extends StatefulWidget {
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final LoginController _loginController = Get.find();
  String _emailError, _passwordError, _nameError;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();

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
                      "Sign Up",
                      style: mainTextStyle.copyWith(fontSize: 30),
                    ),
                    const SizedBox(
                      height: 48,
                    ),
                    TextFormField(
                      controller: _nameController,
                      keyboardType: TextInputType.text,
                      cursorWidth: 1,
                      textAlign: TextAlign.start,
                      textDirection: TextDirection.ltr,
                      autofocus: false,
                      onChanged: (s) {
                        setState(() {
                          _nameError = null;
                        });
                      },
                      style: TextStyle(
                          color: blackColor,
                          fontWeight: FontWeight.w800,
                          fontSize: 15),
                      decoration: InputDecoration(
                        labelText: S.of(context).name,
                        errorText: _nameError,
                        labelStyle: subTextStyle,
                        focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: colorAccent)),
                        border: UnderlineInputBorder(
                            borderSide: BorderSide(color: lightGrey)),
                      ),
                    ),
                    const SizedBox(
                      height: 32,
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
                      height: 32,
                    ),
                    TextFormField(
                      controller: _passwordController,
                      keyboardType: TextInputType.text,
                      cursorWidth: 1,
                      obscureText: true,
                      textAlign: TextAlign.start,
                      textDirection: TextDirection.ltr,
                      autofocus: false,
                      style: TextStyle(
                          color: blackColor,
                          fontWeight: FontWeight.w800,
                          letterSpacing: 6,
                          fontSize: 16),
                      decoration: InputDecoration(
                        labelText: S.of(context).password,
                        errorText: _passwordError,
                        labelStyle: subTextStyle.copyWith(
                          letterSpacing: 0.7,
                        ),
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
                        onPressed: signUp,
                        color: redColor,
                        child: Text(
                          "SIGN UP",
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

  void signUp() {
    if (_nameController.text.isEmpty) {
      setState(() {
        _nameError = "Required Filed";
      });
      return;
    }
    String name = _nameController.text;
    String lastName = "";
    String firstName = "";
    if (name.split(" ").length > 1) {
      lastName = name.substring(name.lastIndexOf(" ") + 1);
      firstName = name.substring(0, name.lastIndexOf(' '));
      if (firstName.isEmpty || lastName.isEmpty) {
        setState(() {
          _nameError = "يرجى ادخال الاسم الكامل";
        });
        return;
      } else {
        setState(() {
          _nameError = null;
        });
      }
    } else {
      setState(() {
        _nameError = "يرجى ادخال الاسم الكامل";
      });
      return;
    }
    if (!_emailController.text.isEmail) {
      setState(() {
        _emailError = "Required Filed";
      });
      return;
    }

    if (_passwordController.text.isEmpty) {
      setState(() {
        _passwordError = "هذا الحقل مطلوب";
      });
      return;
    }
    if (!RegExp(
            r"^(?=.*[A-Za-z])(?=.*\d)(?=.*[@$!%*#?&])[A-Za-z\d@$!%*#?&]{8,}$")
        .hasMatch(_passwordController.text)) {
      setState(() {
        _passwordError =
            "Minimum eight characters, at least one letter, one number and one special character";
      });
      return;
    }

    _loginController.signUp(SignUpRequest(
        customer: Customer(
            lastname: lastName,
            firstname: firstName,
            email: _emailController.text),
        password: _passwordController.text));
  }
}
