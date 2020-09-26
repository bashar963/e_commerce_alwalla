import 'package:auto_size_text/auto_size_text.dart';
import 'package:e_commerce_alwalla/screen/addresses/addresses_screen.dart';
import 'package:e_commerce_alwalla/screen/cards/cards_screen.dart';
import 'package:e_commerce_alwalla/screen/home/account_tab/account_bloc.dart';
import 'package:e_commerce_alwalla/screen/loyalty/loyalty_screen.dart';
import 'package:e_commerce_alwalla/screen/order_history/orders_history_screen.dart';
import 'package:e_commerce_alwalla/screen/wishlist/wishlist_screen.dart';
import 'package:e_commerce_alwalla/theme/app_theme.dart';
import 'package:e_commerce_alwalla/utils/common.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AccountTabScreen extends StatefulWidget {
  @override
  _AccountTabScreenState createState() => _AccountTabScreenState();
}

class _AccountTabScreenState extends State<AccountTabScreen> {
  final _accountBloc = AccountBloc();

  List<Setting> _settings;
  @override
  void initState() {
    super.initState();
    _settings = [
      Setting("assets/icons/edit.svg", "Edit Profile", () {}),
      Setting("assets/icons/location.svg", "Shipping Address", () {
        Navigator.push(
            context, MaterialPageRoute(builder: (c) => AddressesScreen()));
      }),
      Setting("assets/icons/fav.svg", "Wishlist", () {
        Navigator.push(
            context, MaterialPageRoute(builder: (c) => WishListScreen()));
      }),
      Setting("assets/icons/history.svg", "Order History", () {
        Navigator.push(
            context, MaterialPageRoute(builder: (c) => OrdersHistory()));
      }),
      Setting("assets/icons/track.svg", "Track Order", () {
        Navigator.push(
            context, MaterialPageRoute(builder: (c) => OrdersHistory()));
      }),
      Setting("assets/icons/card.svg", "Cards", () {
        Navigator.push(
            context, MaterialPageRoute(builder: (c) => CardsScreen()));
      }),
      Setting("assets/icons/bill.svg", "Notification", () {}),
      Setting("assets/icons/exit.svg", "Log Out", () {}),
    ];
  }

  @override
  void dispose() {
    _accountBloc.close();
    super.dispose();
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
      body: BlocProvider(
        create: (BuildContext context) {
          return _accountBloc;
        },
        child: BlocListener(
          cubit: _accountBloc,
          listener: (c, AccountState state) async {
            if (state is Loading) {}
            if (state is Success) {}
            if (state is Failed) {
              showFailedMessage(context, state.error);
            }
          },
          child: BlocBuilder(
              cubit: _accountBloc,
              builder: (c, AccountState state) {
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
                Material(
                  elevation: 1,
                  shape: CircleBorder(),
                  child: CircleAvatar(
                    radius: 60,
                    backgroundImage: AssetImage("assets/icons/image_.png"),
                  ),
                ),
                const SizedBox(
                  width: 24,
                ),
                Expanded(
                    child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AutoSizeText(
                      "Mr.Rezk",
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
                      "Rezk@gmail.com",
                      style: subTextStyle,
                    ),
                    const SizedBox(
                      height: 4,
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (c) => LoyaltyScreen(),
                          ),
                        );
                      },
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SvgPicture.asset("assets/icons/wallaa.svg"),
                          const SizedBox(
                            width: 4,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 10),
                            child: Text(
                              "VIP0",
                              style: mainTextStyle.copyWith(fontSize: 14),
                            ),
                          ),
                          const SizedBox(
                            width: 2,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 6),
                            child: Icon(
                              Icons.chevron_right,
                              color: blackColor,
                            ),
                          )
                        ],
                      ),
                    )
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
