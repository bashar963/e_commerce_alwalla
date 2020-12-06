import 'package:e_commerce_alwalla/controller/login_controller.dart';
import 'package:e_commerce_alwalla/data/app_preference.dart';
import 'package:e_commerce_alwalla/generated/l10n.dart';
import 'package:e_commerce_alwalla/model/app_language.dart';
import 'package:e_commerce_alwalla/screen/password_restore/email_screen.dart';
import 'package:e_commerce_alwalla/screen/sign_up/sign_up_screen.dart';
import 'package:e_commerce_alwalla/theme/app_theme.dart';
import 'package:e_commerce_alwalla/utils/common.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _loginController = Get.put(LoginController());
  String _emailError, _passwordError;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        brightness: Brightness.light,
        actions: [
          TextButton(
            onPressed: () {
              if (AppPreference.appLanguage == 'en') {
                Provider.of<AppLanguage>(context, listen: false)
                    .setAppLanguage('ar');
                AppPreference.appLanguage = 'ar';
                Get.locale = Locale('ar');
              } else {
                Provider.of<AppLanguage>(context, listen: false)
                    .setAppLanguage('en');
                AppPreference.appLanguage = 'en';
                Get.locale = Locale('en');
              }
            },
            child: Text(
              S.of(context).go_lang,
              style: TextStyle(
                  fontFamily: 'Cairo', color: Theme.of(context).accentColor),
            ),
          )
        ],
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
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              S.of(context).welcome,
                              style: mainTextStyle.copyWith(fontSize: 30),
                            ),
                            const SizedBox(
                              height: 6,
                            ),
                            Text(
                              S.of(context).sign_in_to_continue,
                              style: subTextStyle,
                            ),
                          ],
                        ),
                        InkWell(
                          onTap: () async {
                            var email = await Get.to(SignUpScreen());
                            if (email != null) {
                              _emailController.text = email;
                            }
                            setState(() {});
                          },
                          child: Padding(
                            padding: EdgeInsets.only(top: 8, left: 8),
                            child: Text(
                              S.of(context).sign_up,
                              style: subTextStyle.copyWith(
                                  color: redColor, fontSize: 18),
                            ),
                          ),
                        )
                      ],
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
                        errorMaxLines: 2,
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
                      height: 20,
                    ),
                    Align(
                      alignment: AppPreference.appLanguage == "en"
                          ? Alignment.centerRight
                          : Alignment.centerLeft,
                      child: FlatButton(
                          onPressed: () {
                            Get.to(AddEmailScreen());
                          },
                          padding: EdgeInsets.only(left: 8),
                          child: Text(S.of(context).forgot_password)),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Container(
                      height: 50,
                      child: RaisedButton(
                        elevation: 0,
                        onPressed: login,
                        color: redColor,
                        child: Text(
                          S.of(context).sign_in,
                          style: subTextStyle.copyWith(
                              color: whiteColor,
                              fontWeight: FontWeight.w400,
                              fontSize: 14),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 28,
            ),
            Text(
              S.of(context).or,
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: mainTextColor,
                  fontSize: 18,
                  fontWeight: FontWeight.w400),
            ),
            const SizedBox(
              height: 42,
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              height: 50,
              child: OutlineButton(
                  onPressed: () {},
                  child: Row(
                    children: [
                      const SizedBox(
                        width: 20,
                      ),
                      SvgPicture.asset("assets/icons/Icon_facebook.svg"),
                      Expanded(
                        child: Text(
                          S.of(context).sign_in_facebook,
                          textAlign: TextAlign.center,
                          style: subTextStyle.copyWith(
                              color: mainTextColor,
                              fontSize: 14,
                              fontWeight: FontWeight.w400),
                        ),
                      ),
                    ],
                  )),
            ),
            const SizedBox(
              height: 24,
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              height: 50,
              child: OutlineButton(
                  onPressed: () {},
                  child: Row(
                    children: [
                      const SizedBox(
                        width: 20,
                      ),
                      SvgPicture.asset("assets/icons/icons_google.svg"),
                      Expanded(
                        child: Text(
                          S.of(context).sign_in_google,
                          textAlign: TextAlign.center,
                          style: subTextStyle.copyWith(
                              color: mainTextColor,
                              fontSize: 14,
                              fontWeight: FontWeight.w400),
                        ),
                      ),
                    ],
                  )),
            ),
            const SizedBox(
              height: 32,
            ),
          ],
        ),
      ),
    );
  }

  void login() {
    if (!_emailController.text.isEmail) {
      setState(() {
        _emailError = S.of(context).required_field;
      });
      return;
    }
    if (_passwordController.text.isEmpty) {
      setState(() {
        _passwordError = S.of(context).required_field;
      });
      return;
    }
    if (!RegExp(
            r"^(?=.*[A-Za-z])(?=.*\d)(?=.*[@$!%*#?&])[A-Za-z\d@$!%*#?&]{8,}$")
        .hasMatch(_passwordController.text)) {
      setState(() {
        _passwordError = S.of(context).password_requirements;
      });
      return;
    }
    setState(() {
      _passwordError = null;
      _emailError = null;
    });
    _loginController.login(_emailController.text, _passwordController.text);
  }
}
