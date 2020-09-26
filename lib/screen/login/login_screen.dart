import 'package:e_commerce_alwalla/data/app_preference.dart';
import 'package:e_commerce_alwalla/generated/l10n.dart';
import 'package:e_commerce_alwalla/screen/home/home_screen.dart';
import 'package:e_commerce_alwalla/screen/login/login_bloc.dart';
import 'package:e_commerce_alwalla/screen/sign_up/sign_up_screen.dart';
import 'package:e_commerce_alwalla/theme/app_theme.dart';
import 'package:e_commerce_alwalla/utils/common.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _loginBloc = LoginBloc();
  String _emailError, _passwordError;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    _loginBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        brightness: Brightness.light,
      ),
      body: BlocProvider(
        create: (BuildContext context) {
          return _loginBloc;
        },
        child: BlocListener(
          cubit: _loginBloc,
          listener: (c, LoginState state) async {
            if (state is Loading) {}
            if (state is Success) {}
            if (state is Failed) {
              showFailedMessage(context, state.error);
            }
          },
          child: BlocBuilder(
              cubit: _loginBloc,
              builder: (c, LoginState state) {
                return GestureDetector(
                    onTap: () {
                      hideKeyboard(context);
                    },
                    child: body(c));
              }),
        ),
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
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (c) => SignUpScreen()));
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
                          onPressed: () {},
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
                        onPressed: () {
                          Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                  builder: (BuildContext context) =>
                                      HomeScreen()),
                              ModalRoute.withName('/home'));
                        },
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
}
