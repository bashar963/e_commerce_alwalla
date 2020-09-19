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
        child: Container(
          height: MediaQuery.of(context).size.height - 90,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(
                height: 60,
              ),
              Card(
                margin: EdgeInsets.symmetric(vertical: 12, horizontal: 24),
                color: whiteColor,
                elevation: 2,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(6)),
                child: Container(
                  padding: EdgeInsets.all(12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                S.of(context).welcome,
                                style: mainTextStyle.copyWith(fontSize: 24),
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
                          FlatButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (c) => SignUpScreen()));
                            },
                            child: Text(
                              S.of(context).sign_up,
                              style: subTextStyle.copyWith(color: redColor),
                            ),
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 12,
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
                        height: 12,
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
                            letterSpacing: 3,
                            fontSize: 16),
                        decoration: InputDecoration(
                          labelText: S.of(context).password,
                          errorText: _passwordError,
                          labelStyle: subTextStyle,
                          focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: colorAccent)),
                          border: UnderlineInputBorder(
                              borderSide: BorderSide(color: lightGrey)),
                        ),
                      ),
                      const SizedBox(
                        height: 6,
                      ),
                      Align(
                        alignment: AppPreference.appLanguage == "en"
                            ? Alignment.centerRight
                            : Alignment.centerLeft,
                        child: FlatButton(
                            onPressed: () {},
                            child: Text(S.of(context).forgot_password)),
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      RaisedButton(
                        onPressed: () {
                          Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                  builder: (BuildContext context) =>
                                      HomeScreen()),
                              ModalRoute.withName('/home'));
                        },
                        padding:
                            EdgeInsets.symmetric(vertical: 16, horizontal: 12),
                        color: redColor,
                        child: Text(
                          S.of(context).sign_in,
                          style: subTextStyle.copyWith(
                              color: whiteColor, fontWeight: FontWeight.w800),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 18,
              ),
              Text(
                S.of(context).or,
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: mainTextColor,
                    fontSize: 18,
                    fontWeight: FontWeight.w800),
              ),
              const SizedBox(
                height: 18,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: OutlineButton.icon(
                    onPressed: () {},
                    padding: EdgeInsets.symmetric(vertical: 12, horizontal: 12),
                    icon: SvgPicture.asset("assets/icons/Icon_facebook.svg"),
                    label: Text(
                      S.of(context).sign_in_facebook,
                      style: subTextStyle.copyWith(
                          color: mainTextColor, fontSize: 16),
                    )),
              ),
              const SizedBox(
                height: 12,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: OutlineButton.icon(
                    onPressed: () {},
                    padding: EdgeInsets.symmetric(vertical: 12, horizontal: 12),
                    icon: SvgPicture.asset("assets/icons/icons_google.svg"),
                    label: Text(
                      S.of(context).sign_in_google,
                      style: subTextStyle.copyWith(
                          color: mainTextColor, fontSize: 16),
                    )),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
