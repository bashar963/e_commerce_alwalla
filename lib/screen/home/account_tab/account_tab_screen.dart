import 'package:auto_size_text/auto_size_text.dart';

import 'package:e_commerce_alwalla/controller/profile_controller.dart';
import 'package:e_commerce_alwalla/data/app_preference.dart';
import 'package:e_commerce_alwalla/screen/addresses/addresses_screen.dart';
import 'package:e_commerce_alwalla/screen/cards/cards_screen.dart';
import 'package:e_commerce_alwalla/screen/login/login_screen.dart';
import 'package:e_commerce_alwalla/screen/order_history/orders_history_screen.dart';
import 'package:e_commerce_alwalla/screen/profile/profile.dart';
import 'package:e_commerce_alwalla/screen/wishlist/wishlist_screen.dart';
import 'package:e_commerce_alwalla/theme/app_theme.dart';
import 'package:e_commerce_alwalla/utils/common.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class AccountTabScreen extends StatefulWidget {
  @override
  _AccountTabScreenState createState() => _AccountTabScreenState();
}

class _AccountTabScreenState extends State<AccountTabScreen> {
  List<Setting> _settings;
  final ProfileController _profileController = Get.find();
  @override
  void initState() {
    super.initState();
    _profileController.loadCustomer();
    _settings = [
      Setting("assets/icons/edit.svg", "Edit Profile", () {
        Get.to(ProfileScreen());
      }),
      Setting("assets/icons/location.svg", "Shipping Address", () {
        Get.to(AddressesScreen());
      }),
      Setting("assets/icons/fav.svg", "Wishlist", () {
        Get.to(WishListScreen());
      }),
      Setting("assets/icons/history.svg", "Order History", () {
        Get.to(OrdersHistory());
      }),
      Setting("assets/icons/track.svg", "Track Order", () {
        Get.to(OrdersHistory());
      }),
      // Setting("assets/icons/card.svg", "Cards", () {
      //   Get.to(CardsScreen());
      // }),
      // Setting("assets/icons/bill.svg", "Notification", () {}),
      Setting("assets/icons/exit.svg", "Log Out", () {
        AppPreference.token = null;
        Get.offAll(LoginScreen());
      }),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        elevation: 0,
        brightness: Brightness.light,
        backgroundColor: whiteColor,
      ),
      body: GestureDetector(
          onTap: () {
            hideKeyboard(context);
          },
          child: body(context)),
    );
  }

  Widget body(BuildContext context) {
    return Obx(() {
      return SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          children: [
            const SizedBox(
              height: 8,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 14),
              child: Row(
                children: [
                  // Material(
                  //   elevation: 1,
                  //   shape: CircleBorder(),
                  //   child: CircleAvatar(
                  //     radius: 60,
                  //     backgroundImage: AssetImage("assets/icons/image_.png"),
                  //   ),
                  // ),
                  // const SizedBox(
                  //   width: 24,
                  // ),
                  Expanded(
                      child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AutoSizeText(
                        _profileController.user.value != null
                            ? (_profileController.user.value.firstname
                                    .toString() +
                                " " +
                                _profileController.user.value.lastname
                                    .toString())
                            : '',
                        maxLines: 1,
                        maxFontSize: 26,
                        minFontSize: 16,
                        overflow: TextOverflow.ellipsis,
                        style: mainTextStyle.copyWith(fontSize: 24),
                      ),
                      const SizedBox(
                        height: 4,
                      ),
                      Text(
                        _profileController.user.value != null
                            ? _profileController.user.value.email.toString()
                            : '',
                        style: subTextStyle,
                      ),
                      // const SizedBox(
                      //   height: 4,
                      // ),
                      // GestureDetector(
                      //   onTap: () {
                      //     Navigator.push(
                      //       context,
                      //       MaterialPageRoute(
                      //         builder: (c) => LoyaltyScreen(),
                      //       ),
                      //     );
                      //   },
                      //   child: Row(
                      //     crossAxisAlignment: CrossAxisAlignment.center,
                      //     children: [
                      //       SvgPicture.asset("assets/icons/wallaa.svg"),
                      //       const SizedBox(
                      //         width: 4,
                      //       ),
                      //       Padding(
                      //         padding: const EdgeInsets.only(top: 10),
                      //         child: Text(
                      //           "VIP0",
                      //           style: mainTextStyle.copyWith(fontSize: 14),
                      //         ),
                      //       ),
                      //       const SizedBox(
                      //         width: 2,
                      //       ),
                      //       Padding(
                      //         padding: const EdgeInsets.only(top: 6),
                      //         child: Icon(
                      //           Icons.chevron_right,
                      //           color: blackColor,
                      //         ),
                      //       )
                      //     ],
                      //   ),
                      // )
                    ],
                  ))
                ],
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            ListView.builder(
              itemBuilder: (c, i) => settingItem(_settings[i]),
              itemCount: _settings.length,
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
            )
          ],
        ),
      );
    });
  }

  settingItem(Setting setting) {
    return ListTile(
      onTap: setting.onClick,
      contentPadding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      leading: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(6),
            color: redColor.withOpacity(0.07)),
        child: Center(
          child: SvgPicture.asset(
            setting.icon,
          ),
        ),
      ),
      title: Text(
        setting.name,
        style: mainTextStyle.copyWith(fontWeight: FontWeight.w400),
      ),
      trailing: Icon(Icons.chevron_right),
    );
  }
}

class Setting {
  final String icon, name;
  final Function onClick;

  Setting(this.icon, this.name, this.onClick);
}
