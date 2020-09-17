import 'package:e_commerce_alwalla/screen/home/account_tab/account_tab_screen.dart';
import 'package:e_commerce_alwalla/screen/home/cart_tab/cart_tab_screen.dart';
import 'package:e_commerce_alwalla/widget/bottom_app_bar.dart';
import 'package:flutter/material.dart';

import 'home_tab/home_tab_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        children: <Widget>[
          HomeTabScreen(),
          CartTabScreen(),
          AccountTabScreen(),
        ],
        index: _selectedIndex,
      ),
      bottomNavigationBar: AppBottomNavBar(
        selectedIndex: _selectedIndex,
        onTap: (int value) {
          setState(() {
            _selectedIndex = value;
          });
        },
      ),
    );
  }
}
