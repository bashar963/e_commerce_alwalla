import 'package:e_commerce_alwalla/controller/card_controller.dart';
import 'package:e_commerce_alwalla/theme/app_theme.dart';
import 'package:e_commerce_alwalla/utils/common.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import 'add_edit/card_screen.dart';

class CardsScreen extends StatefulWidget {
  @override
  _CardsScreenState createState() => _CardsScreenState();
}

class _CardsScreenState extends State<CardsScreen> {
  final _cardsController = Get.put(CardController());

  List<Card> _cards = [
    Card("1", "master", "4512 3213 4243 3213", "09 - 24", "bashar alkaddah"),
    Card("2", "visa", "5214 5432 5324 2421", "02 - 23", "bashar alkaddah"),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: whiteColor,
        title: Text("Cards"),
        centerTitle: true,
      ),
      body: GestureDetector(
          onTap: () {
            hideKeyboard(context);
          },
          child: body(context)),
      bottomNavigationBar: Container(
        padding: EdgeInsets.symmetric(vertical: 24, horizontal: 24),
        color: whiteColor,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: SizedBox(),
            ),
            const SizedBox(
              width: 16,
            ),
            Expanded(
              child: Container(
                height: 50,
                child: RaisedButton(
                  elevation: 0,
                  color: redColor,
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (c) => AddEditCardScreen()));
                  },
                  child: Text(
                    "NEW",
                    style: subTextStyle.copyWith(color: whiteColor),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget body(BuildContext context) {
    return ListView.builder(
      itemBuilder: (c, i) => cardItem(_cards[i]),
      itemCount: _cards.length,
      shrinkWrap: true,
      physics: BouncingScrollPhysics(),
    );
  }

  List<Color> _master = [
    Color(0xFFFAD961),
    Color(0xFFF76B1C),
  ];
  List<Color> _visa = [
    Color(0xFF00C569),
    Color(0xFF2CFF88),
  ];
  Widget cardItem(Card card) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (c) => AddEditCardScreen(
                      card: card,
                    )));
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
        child: Container(
          height: 170,
          padding: EdgeInsets.symmetric(vertical: 12, horizontal: 24),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            gradient: LinearGradient(
                colors: card.type == "visa" ? _visa : _master,
                begin: Alignment.topLeft,
                end: Alignment.bottomRight),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Align(
                alignment: Alignment.centerRight,
                child: SvgPicture.asset(card.type == "visa"
                    ? "assets/icons/icon_visa.svg"
                    : "assets/icons/icon_mastercard.svg"),
              ),
              const SizedBox(
                height: 24,
              ),
              Text(
                card.number,
                maxLines: 1,
                style: mainTextStyle.copyWith(
                    color: whiteColor,
                    fontSize: 20,
                    wordSpacing: MediaQuery.of(context).size.width / 9),
              ),
              const SizedBox(
                height: 24,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Card Holder",
                        style: subTextStyle.copyWith(
                            color: whiteColor, fontSize: 12),
                      ),
                      const SizedBox(
                        height: 2,
                      ),
                      Text(
                        card.name,
                        style: mainTextStyle.copyWith(color: whiteColor),
                      )
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Expiry",
                        style: subTextStyle.copyWith(
                            color: whiteColor, fontSize: 12),
                      ),
                      const SizedBox(
                        height: 2,
                      ),
                      Text(
                        card.expDate,
                        style: mainTextStyle.copyWith(color: whiteColor),
                      )
                    ],
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

class Card {
  final String id, type, number, expDate, name;

  Card(this.id, this.type, this.number, this.expDate, this.name);
}
