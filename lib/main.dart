import 'package:e_commerce_alwalla/controller/address_controller.dart';
import 'package:e_commerce_alwalla/generated/l10n.dart';
import 'package:e_commerce_alwalla/model/app_language.dart';
import 'package:e_commerce_alwalla/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import 'controller/checkout_controller.dart';
import 'controller/products_controller.dart';
import 'data/app_preference.dart';
import 'model/user_model.dart';
import 'screen/splash/splash_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await AppPreference.init();
  Get.put(CheckoutController());
  Get.put(AddressController());
  Get.put(ProductsController());
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(statusBarColor: Colors.transparent));
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<UserModel>(
          create: (_) => UserModel(),
        ),
        ChangeNotifierProvider<AppLanguage>(
          create: (_) => AppLanguage(),
        ),
      ],
      child: Consumer<AppLanguage>(
        builder: (BuildContext context, value, Widget child) {
          return GetMaterialApp(
            title: 'My Mall',
            defaultTransition: Transition.cupertino,
            localizationsDelegates: [
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
              S.delegate
            ],
            supportedLocales: AppLocalizationDelegate().supportedLocales,
            locale: Get.deviceLocale,
            debugShowCheckedModeBanner: false,
            theme: appTheme,
            home: SplashScreen(),
          );
        },
      ),
    );
  }
}
