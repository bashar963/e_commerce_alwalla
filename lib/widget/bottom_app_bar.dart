import 'package:e_commerce_alwalla/generated/l10n.dart';
import 'package:e_commerce_alwalla/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AppBottomNavBar extends StatefulWidget {
  final ValueChanged<int> onTap;
  final int selectedIndex;
  const AppBottomNavBar({Key key, @required this.onTap, this.selectedIndex = 0})
      : super(key: key);
  @override
  _AppBottomNavBarState createState() => _AppBottomNavBarState();
}

class _AppBottomNavBarState extends State<AppBottomNavBar> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    setState(() {
      _selectedIndex = widget.selectedIndex;
    });
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(16), topRight: Radius.circular(16)),
          boxShadow: [
            BoxShadow(
                color: Color(0x11000012), offset: Offset(0, 2), blurRadius: 8)
          ]),
      child: ClipRRect(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(16), topRight: Radius.circular(16)),
        child: BottomNavigationBar(
            backgroundColor: whiteColor,
            type: BottomNavigationBarType.fixed,
            onTap: (i) {
              widget.onTap.call(i);
              setState(() {
                _selectedIndex = i;
              });
            }, // new
            currentIndex: _selectedIndex, // new
            items: [
              tabBarItem(
                  0, S.of(context).explore, "assets/icons/icon_home.svg"),
              tabBarItem(1, S.of(context).cart, "assets/icons/icon_cart.svg"),
              tabBarItem(
                  2, S.of(context).account, "assets/icons/icon_user.svg"),
            ]),
      ),
    );
  }

  BottomNavigationBarItem tabBarItem(int index, String title, String image) {
    return BottomNavigationBarItem(
      icon: _selectedIndex != index
          ? SvgPicture.asset(
              image,
              width: 24,
            )
          : const SizedBox.shrink(),
      title: _selectedIndex == index
          ? Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  title,
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w800,
                      color: mainTextColor),
                ),
                Text(
                  ".",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w800,
                      color: mainTextColor),
                ),
              ],
            )
          : const SizedBox.shrink(),
    );
  }
}
