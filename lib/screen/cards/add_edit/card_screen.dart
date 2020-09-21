import 'package:e_commerce_alwalla/screen/cards/cards_screen.dart' as car;
import 'package:e_commerce_alwalla/theme/app_theme.dart';
import 'package:e_commerce_alwalla/utils/common.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'card_bloc.dart';

class AddEditCardScreen extends StatefulWidget {
  final car.Card card;

  const AddEditCardScreen({Key key, this.card}) : super(key: key);
  @override
  _AddEditCardScreenState createState() => _AddEditCardScreenState();
}

class _AddEditCardScreenState extends State<AddEditCardScreen> {
  final _cardBloc = CardBloc();
  final _numberController = TextEditingController();
  final _nameController = TextEditingController();
  final _expController = TextEditingController();
  final _cvvController = TextEditingController();
  String numberError, nameError, expError, cvvError;
  @override
  void initState() {
    super.initState();
    if (widget.card != null) {
      _nameController.text = widget.card.name;
      _numberController.text = widget.card.number;
      _expController.text = widget.card.expDate;
    }
  }

  @override
  void dispose() {
    _cardBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: whiteColor,
        title: Text("Edit/Add Cards"),
      ),
      body: BlocProvider(
        create: (BuildContext context) {
          return _cardBloc;
        },
        child: BlocListener(
          cubit: _cardBloc,
          listener: (c, CardState state) async {
            if (state is Loading) {}
            if (state is Success) {}
            if (state is Failed) {
              showFailedMessage(context, state.error);
            }
          },
          child: BlocBuilder(
              cubit: _cardBloc,
              builder: (c, CardState state) {
                return GestureDetector(
                    onTap: () {
                      hideKeyboard(context);
                    },
                    child: body(c));
              }),
        ),
      ),
      bottomNavigationBar: Container(
        padding: EdgeInsets.symmetric(vertical: 24, horizontal: 24),
        color: whiteColor,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: OutlineButton(
                padding: EdgeInsets.symmetric(vertical: 16, horizontal: 12),
                color: redColor,
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text(
                  "CANCEL",
                  style: subTextStyle.copyWith(color: redColor),
                ),
              ),
            ),
            const SizedBox(
              width: 16,
            ),
            Expanded(
              child: RaisedButton(
                padding: EdgeInsets.symmetric(vertical: 16, horizontal: 12),
                color: redColor,
                onPressed: () {},
                child: Text(
                  "SAVE",
                  style: subTextStyle.copyWith(color: whiteColor),
                ),
              ),
            )
          ],
        ),
      ),
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
  Widget body(BuildContext context) {
    return SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      child: Column(
        children: [
          const SizedBox(
            height: 24,
          ),
          Hero(
            tag: "card${widget.card != null ? widget.card.id : 1}",
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
              child: Container(
                height: 170,
                padding: EdgeInsets.symmetric(vertical: 12, horizontal: 24),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  gradient: LinearGradient(
                      colors: widget.card != null
                          ? widget.card.type == "visa" ? _visa : _master
                          : _visa,
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Align(
                      alignment: Alignment.centerRight,
                      child: SvgPicture.asset(widget.card != null
                          ? widget.card.type == "visa"
                              ? "assets/icons/icon_visa.svg"
                              : "assets/icons/icon_mastercard.svg"
                          : "assets/icons/icon_visa.svg"),
                    ),
                    const SizedBox(
                      height: 24,
                    ),
                    Text(
                      widget.card != null
                          ? widget.card.number
                          : _numberController.text,
                      maxLines: 1,
                      style: mainTextStyle.copyWith(
                          color: whiteColor, fontSize: 20, letterSpacing: 3),
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
                              style: subTextStyle.copyWith(color: whiteColor),
                            ),
                            const SizedBox(
                              height: 2,
                            ),
                            Text(
                              widget.card != null
                                  ? widget.card.name
                                  : _nameController.text,
                              style: mainTextStyle.copyWith(color: whiteColor),
                            )
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Expiry",
                              style: subTextStyle.copyWith(color: whiteColor),
                            ),
                            const SizedBox(
                              height: 2,
                            ),
                            Text(
                              widget.card != null
                                  ? widget.card.expDate
                                  : _expController.text,
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
          ),
          const SizedBox(
            height: 32,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: TextFormField(
              controller: _nameController,
              keyboardType: TextInputType.text,
              cursorWidth: 1,
              autofocus: false,
              style: TextStyle(
                  color: mainTextColor,
                  fontWeight: FontWeight.w600,
                  fontSize: 16),
              decoration: InputDecoration(
                labelText: "Card Holder",
                errorText: nameError,
                labelStyle: TextStyle(
                  color: subTextColor,
                  fontWeight: FontWeight.w200,
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 24,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: TextFormField(
              controller: _numberController,
              keyboardType: TextInputType.number,
              cursorWidth: 1,
              autofocus: false,
              style: TextStyle(
                  color: mainTextColor,
                  fontWeight: FontWeight.w600,
                  fontSize: 16),
              decoration: InputDecoration(
                labelText: "Card Number",
                errorText: numberError,
                labelStyle: TextStyle(
                  color: subTextColor,
                  fontWeight: FontWeight.w200,
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 24,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Row(
              children: [
                Expanded(
                    child: TextFormField(
                  controller: _expController,
                  keyboardType: TextInputType.datetime,
                  cursorWidth: 1,
                  autofocus: false,
                  maxLength: 5,
                  style: TextStyle(
                      color: mainTextColor,
                      fontWeight: FontWeight.w600,
                      fontSize: 16),
                  decoration: InputDecoration(
                    labelText: "Expiry Date",
                    errorText: expError,
                    labelStyle: TextStyle(
                      color: subTextColor,
                      fontWeight: FontWeight.w200,
                    ),
                  ),
                )),
                const SizedBox(
                  width: 16,
                ),
                Expanded(
                    child: TextFormField(
                  controller: _cvvController,
                  keyboardType: TextInputType.number,
                  maxLength: 4,
                  cursorWidth: 1,
                  autofocus: false,
                  style: TextStyle(
                      color: mainTextColor,
                      fontWeight: FontWeight.w600,
                      fontSize: 16),
                  decoration: InputDecoration(
                    labelText: "CVV",
                    errorText: cvvError,
                    labelStyle: TextStyle(
                      color: subTextColor,
                      fontWeight: FontWeight.w200,
                    ),
                  ),
                )),
              ],
            ),
          ),
          const SizedBox(
            height: 64,
          ),
        ],
      ),
    );
  }
}
