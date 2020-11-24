import 'package:cached_network_image/cached_network_image.dart';
import 'package:e_commerce_alwalla/controller/cart_controller.dart';
import 'package:e_commerce_alwalla/screen/checkout/checkout_screen.dart';
import 'package:e_commerce_alwalla/theme/app_theme.dart';
import 'package:e_commerce_alwalla/utils/common.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:slide_item/slide_item.dart';

class CartTabScreen extends StatefulWidget {
  @override
  _CartTabScreenState createState() => _CartTabScreenState();
}

class _CartTabScreenState extends State<CartTabScreen> {
  final textController = TextEditingController();
  final CartController _cartController = Get.find();

  @override
  void initState() {
    super.initState();
    _cartController.getCart();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: whiteColor,
        appBar: AppBar(
          backgroundColor: whiteColor,
          elevation: 0,
        ),
        body: Obx(() {
          return Stack(
            children: [
              GestureDetector(
                  onTap: () {
                    hideKeyboard(context);
                  },
                  child: body(context)),
              if (_cartController.isLoading.value)
                Center(child: RefreshProgressIndicator())
            ],
          );
        }),
        bottomNavigationBar: Obx(() {
          if (_cartController.carts.value == null) return SizedBox.shrink();
          return Container(
            padding: EdgeInsets.symmetric(vertical: 16, horizontal: 16),
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
                        style: subTextStyle,
                      ),
                      const SizedBox(
                        height: 4,
                      ),
                      Obx(() {
                        return Text(
                          _cartController.carts.value == null
                              ? ''
                              : "${_cartController.carts.value.total} EGP",
                          style: mainTextStyle.copyWith(
                              fontSize: 18, color: redColor),
                        );
                      }),
                    ],
                  ),
                ),
                Expanded(
                    child: Container(
                  height: 50,
                  child: RaisedButton(
                    elevation: 0,
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
                  ),
                ))
              ],
            ),
          );
        }));
  }

  Widget body(BuildContext context) {
    return Obx(() {
      if (_cartController.carts.value == null) {
        return emptyCart();
      }
      return CustomScrollView(
        physics: BouncingScrollPhysics(),
        slivers: [
          _cartController.carts.value.items.isEmpty
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
                        padding: EdgeInsets.only(top: 16),
                        child: item(_cartController.carts.value.items[i], i),
                      ),
                      itemCount: _cartController.carts.value.items.length,
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
            padding: const EdgeInsets.symmetric(horizontal: 16),
            sliver: SliverToBoxAdapter(
              child: Column(
                children: [
                  Row(
                    children: [
                      Text(
                        "SubTotal",
                        style: mainTextStyle.copyWith(
                            fontSize: 16, fontWeight: FontWeight.w400),
                      ),
                      const SizedBox(
                        width: 12,
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
                      const SizedBox(
                        width: 12,
                      ),
                      Text(
                        _cartController.carts.value.subTotal + " EGP",
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
                        style: mainTextStyle.copyWith(
                            fontSize: 16, fontWeight: FontWeight.w400),
                      ),
                      const SizedBox(
                        width: 12,
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
                      const SizedBox(
                        width: 12,
                      ),
                      Text(
                        _cartController.carts.value.tax + " EGP",
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
            padding: const EdgeInsets.symmetric(horizontal: 16),
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
    });
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
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Row(
            children: [
              Container(
                width: 120,
                height: 120,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(6),
                  child: CachedNetworkImage(
                    imageUrl: item.image,
                    errorWidget: (c, s, w) {
                      return CachedNetworkImage(
                        imageUrl:
                            'http://mymalleg.com/pub/media/catalog/product/cache/p/r/product_1_2.jpg',
                        fit: BoxFit.contain,
                        width: 120,
                        height: 120,
                      );
                    },
                    fit: BoxFit.contain,
                    width: 120,
                    height: 120,
                  ),
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
                  Text(
                    item.title,
                    style: mainTextStyle.copyWith(
                        fontSize: 16, fontWeight: FontWeight.w400),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Text(
                    item.total + " EGP",
                    style: mainTextStyle.copyWith(
                        color: redColor,
                        fontSize: 16,
                        fontWeight: FontWeight.w400),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  Container(
                      width: 95,
                      height: 30,
                      decoration: BoxDecoration(
                          color: Color.fromRGBO(0, 0, 0, 0.06),
                          borderRadius: BorderRadius.circular(4)),
                      child: Material(
                        color: Colors.transparent,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            InkWell(
                              onTap: () {
                                setState(() {
                                  item.quantity++;
                                  _cartController.editItemInCart(
                                      item.itemId, item.quoteId, item.quantity);
                                });
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Icon(
                                  FontAwesomeIcons.plus,
                                  size: 10,
                                  color: Color(0xBB343434),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                item.quantity.toString(),
                                style: mainTextStyle.copyWith(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w400,
                                  color: blackColor,
                                ),
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                setState(() {
                                  if (item.quantity <= 1) {
                                    removeItem(item);
                                  } else {
                                    item.quantity--;
                                    _cartController.editItemInCart(item.itemId,
                                        item.quoteId, item.quantity);
                                  }
                                });
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Icon(
                                  FontAwesomeIcons.minus,
                                  size: 10,
                                  color: Color(0xBB343434),
                                ),
                              ),
                            ),
                          ],
                        ),
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
    _cartController.removeItemInCart(item.itemId);
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
