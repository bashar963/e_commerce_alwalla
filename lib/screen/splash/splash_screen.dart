import 'package:e_commerce_alwalla/controller/login_controller.dart';
import 'package:e_commerce_alwalla/data/app_preference.dart';
import 'package:e_commerce_alwalla/screen/home/home_screen.dart';
import 'package:e_commerce_alwalla/screen/login/login_screen.dart';
import 'package:e_commerce_alwalla/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final _loginController = Get.put(LoginController());
  @override
  void initState() {
    super.initState();

    Future.delayed(Duration(seconds: 1), () {
      if (AppPreference.token != null) {
        _loginController.loadUserData(true);
      } else {
        if (AppPreference.guestCartId.isEmpty)
          Get.offAll(LoginScreen());
        else
          Get.offAll(HomeScreen());
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: Center(
        child: SvgPicture.asset(
          'assets/icons/mymall.svg',
          width: 90,
          height: 90,
        ),
      ),
    );
  }
}
