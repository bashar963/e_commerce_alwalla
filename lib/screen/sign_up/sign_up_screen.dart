import 'package:e_commerce_alwalla/generated/l10n.dart';
import 'package:e_commerce_alwalla/screen/sign_up/sign_up_bloc.dart';
import 'package:e_commerce_alwalla/theme/app_theme.dart';
import 'package:e_commerce_alwalla/utils/common.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignUpScreen extends StatefulWidget {
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _singBloc = SignUpBloc();
  String _emailError, _passwordError, _nameError;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();

  @override
  void dispose() {
    _singBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
      ),
      body: BlocProvider(
        create: (BuildContext context) {
          return _singBloc;
        },
        child: BlocListener(
          cubit: _singBloc,
          listener: (c, SignUpState state) async {
            if (state is Loading) {}
            if (state is Success) {}
            if (state is Failed) {
              showFailedMessage(context, state.error);
            }
          },
          child: BlocBuilder(
              cubit: _singBloc,
              builder: (c, SignUpState state) {
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
              height: 60,
            ),
            Card(
              margin: EdgeInsets.symmetric(vertical: 12, horizontal: 24),
              color: whiteColor,
              elevation: 2,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(6)),
              child: Container(
                padding: EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      S.of(context).sign_up,
                      style: mainTextStyle.copyWith(fontSize: 24),
                    ),
                    const SizedBox(
                      height: 32,
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
                      height: 24,
                    ),
                    RaisedButton(
                      onPressed: () {},
                      padding:
                          EdgeInsets.symmetric(vertical: 12, horizontal: 12),
                      color: redColor,
                      child: Text(
                        S.of(context).sign_up,
                        style: subTextStyle.copyWith(
                            color: whiteColor, fontWeight: FontWeight.w800),
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
}
