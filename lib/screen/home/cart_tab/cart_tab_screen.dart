import 'package:e_commerce_alwalla/screen/checkout/checkout_screen.dart';
import 'package:e_commerce_alwalla/screen/home/cart_tab/cart_bloc.dart';
import 'package:e_commerce_alwalla/theme/app_theme.dart';
import 'package:e_commerce_alwalla/utils/common.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:slide_item/slide_item.dart';

class CartTabScreen extends StatefulWidget {
  @override
  _CartTabScreenState createState() => _CartTabScreenState();
}

class _CartTabScreenState extends State<CartTabScreen> {
  final _cartBloc = CartBloc();
  final textController = TextEditingController();
  Cart cart;

  @override
  void initState() {
    super.initState();
    cart = Cart("3950", "50", "4500", [
      Item("1", "Tag Heuer Wristwatch", "1100", "assets/images/image.png", 1),
      Item("2", "BeoPlay Speaker", "450", "assets/images/image_2.png", 2),
      Item("3", "Electric Kettle", "95", "assets/images/image_demo.png", 4),
      Item("4", "Tag Heuer Wristwatch", "1100", "assets/images/image.png", 1),
      Item("5", "Tag Heuer Wristwatch", "1100", "assets/images/image_demo.png",
          5),
      Item("6", "Tag Heuer Wristwatch", "1100", "assets/images/image_2.png", 7),
    ]);
  }

  @override
  void dispose() {
    _cartBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        backgroundColor: whiteColor,
        elevation: 0,
      ),
      body: BlocProvider(
        create: (BuildContext context) {
          return _cartBloc;
        },
        child: BlocListener(
          cubit: _cartBloc,
          listener: (c, CartState state) async {
            if (state is Loading) {}
            if (state is Success) {}
            if (state is Failed) {
              showFailedMessage(context, state.error);
            }
          },
          child: BlocBuilder(
              cubit: _cartBloc,
              builder: (c, CartState state) {
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
          children: [
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    "TOTAL",
                    style: mainTextStyle.copyWith(color: subTextColor),
                  ),
                  Text(
                    "3500\$",
                    style:
                        mainTextStyle.copyWith(fontSize: 16, color: redColor),
                  ),
                ],
              ),
            ),
            Expanded(
                child: RaisedButton(
              padding: EdgeInsets.symmetric(vertical: 16, horizontal: 12),
              color: redColor,
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (c) => CheckoutScreen(),
                  ),
                );
              },
              child: Text(
                "CHECKOUT",
                style: subTextStyle.copyWith(color: whiteColor),
              ),
            ))
          ],
        ),
      ),
    );
  }

  Widget body(BuildContext context) {
    return CustomScrollView(
      physics: BouncingScrollPhysics(),
      slivers: [
        cart.items.isEmpty
            ? SliverFillRemaining(
                child: emptyCart(),
              )
            : SliverToBoxAdapter(
                child: SlideConfiguration(
                  config: SlideConfig(
                      slideOpenAnimDuration: Duration(milliseconds: 200),
                      slideCloseAnimDuration: Duration(milliseconds: 400),
                      deleteStep1AnimDuration: Duration(milliseconds: 250),
                      deleteStep2AnimDuration: Duration(milliseconds: 300),
                      supportElasticity: true,
                      closeOpenedItemOnTouch: true,
                      slideWidth: 100,
                      actionOpenCloseThreshold: 0.3,
                      backgroundColor: whiteColor),
                  child: ListView.builder(
                    itemBuilder: (c, i) => Padding(
                      padding: EdgeInsets.only(top: 24),
                      child: item(cart.items[i], i),
                    ),
                    itemCount: cart.items.length,
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                  ),
                ),
              ),
        space(24),
        SliverToBoxAdapter(
          child: Divider(),
        ),
        space(24),
        SliverPadding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          sliver: SliverToBoxAdapter(
            child: Column(
              children: [
                Row(
                  children: [
                    Text(
                      "SubTotal",
                      style: subTextStyle.copyWith(fontSize: 16),
                    ),
                    Expanded(
                        child: Text(
                      "-" * 40,
                      textAlign: TextAlign.center,
                      maxLines: 1,
                      overflow: TextOverflow.fade,
                      style: mainTextStyle.copyWith(
                          letterSpacing: 2, color: subTextColor),
                    )),
                    Text(
                      cart.subTotal + "\$",
                      style: mainTextStyle,
                    )
                  ],
                ),
                const SizedBox(
                  height: 32,
                ),
                Row(
                  children: [
                    Text(
                      "TAX",
                      style: subTextStyle.copyWith(fontSize: 16),
                    ),
                    Expanded(
                        child: Text(
                      "-" * 40,
                      textAlign: TextAlign.center,
                      maxLines: 1,
                      overflow: TextOverflow.fade,
                      style: mainTextStyle.copyWith(
                          letterSpacing: 2, color: subTextColor),
                    )),
                    Text(
                      cart.tax + "\$",
                      style: mainTextStyle,
                    )
                  ],
                )
              ],
            ),
          ),
        ),
        space(24),
        SliverToBoxAdapter(
          child: Divider(),
        ),
        space(24),
        SliverPadding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          sliver: SliverToBoxAdapter(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: blackColor.withOpacity(0.1))),
              child: Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: textController,
                      keyboardType: TextInputType.text,
                      cursorWidth: 1,
                      autofocus: false,
                      style: TextStyle(
                          color: mainTextColor,
                          fontWeight: FontWeight.w600,
                          fontSize: 16),
                      decoration: InputDecoration(
                        hintText: "Enter Voucher Code",
                        hintStyle: TextStyle(
                          color: subTextColor,
                          fontWeight: FontWeight.w300,
                        ),
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 12,
                  ),
                  FlatButton(
                    onPressed: () {},
                    child: Text(
                      "Apply",
                      style: mainTextStyle,
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
        space(48),
      ],
    );
  }

  space(double size) {
    return SliverToBoxAdapter(
      child: SizedBox(
        height: size,
      ),
    );
  }

  Widget item(Item item, int index) {
    return Builder(builder: (c) {
      return SlideItem(
        slidable: true,
        indexInList: index,
        leftActions: [
          SlideAction(
              actionWidget: Container(
                decoration: BoxDecoration(
                  color: orangeColor,
                ),
                child: Center(
                  child: SvgPicture.asset(
                    "assets/icons/ic_star.svg",
                    width: 24,
                  ),
                ),
              ),
              tapCallback: (_) {
                print('debug -> click at  ${_.indexInList}');

                _.close();
              })
        ],
        actions: [
          SlideAction(
              actionWidget: Container(
                decoration: BoxDecoration(
                  color: redColor,
                ),
                child: Center(
                  child: SvgPicture.asset(
                    "assets/icons/ic_delete.svg",
                    color: whiteColor,
                    width: 24,
                  ),
                ),
              ),
              tapCallback: (_) {
                print('debug -> click at  ${_.indexInList}');
                removeItem(item);
                _.close();
              })
        ],
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
          child: Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(6),
                child: Image.asset(
                  item.image,
                  fit: BoxFit.cover,
                  width: 120,
                  height: 120,
                ),
              ),
              const SizedBox(
                width: 16,
              ),
              Expanded(
                  child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.title,
                    style: mainTextStyle,
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  Text(
                    item.total + "\$",
                    style: mainTextStyle.copyWith(color: redColor),
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  Container(
                      decoration: BoxDecoration(
                          color: Color.fromRGBO(0, 0, 0, 0.06),
                          borderRadius: BorderRadius.circular(3)),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                item.quantity++;
                              });
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(6.0),
                              child: Icon(
                                Icons.add,
                                color: Color(0xBB343434),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(6.0),
                            child: Text(
                              item.quantity.toString(),
                              style: mainTextStyle.copyWith(
                                color: Color(0xBB343434),
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                if (item.quantity <= 1) {
                                  removeItem(item);
                                } else {
                                  item.quantity--;
                                }
                              });
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(6.0),
                              child: Icon(
                                Icons.remove,
                                color: Color(0xBB343434),
                              ),
                            ),
                          ),
                        ],
                      ))
                ],
              ))
            ],
          ),
        ),
      );
    });
  }

  void removeItem(Item item) {
    setState(() {
      cart.items.remove(item);
    });
  }

  Widget emptyCart() {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SvgPicture.asset(
            "assets/icons/icon_cart.svg",
            width: 48,
          ),
          const SizedBox(
            height: 24,
          ),
          Text(
            "Cart is empty",
            style: mainTextStyle,
          ),
        ],
      ),
    );
  }
}

class Cart {
  final String subTotal, tax, total;
  final List<Item> items;

  Cart(this.subTotal, this.tax, this.total, this.items);
}

class Item {
  final String id, title, total, image;
  int quantity = 1;

  Item(this.id, this.title, this.total, this.image, this.quantity);
}
