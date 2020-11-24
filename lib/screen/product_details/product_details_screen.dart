import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_pro/carousel_pro.dart';
import 'package:e_commerce_alwalla/controller/products_controller.dart';
import 'package:e_commerce_alwalla/model/products_response.dart';
import 'package:e_commerce_alwalla/theme/app_theme.dart';
import 'package:e_commerce_alwalla/utils/common.dart';
import 'package:e_commerce_alwalla/utils/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';

class ProductDetailsScreen extends StatefulWidget {
  final dynamic product;
  final String productId;
  const ProductDetailsScreen({Key key, this.product, @required this.productId})
      : super(key: key);
  @override
  _ProductDetailsScreenState createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  final ProductsController _productsController = Get.find();

  Product _product;
  bool isFav = false;
  String readMore = "Read More";
  String readLess = "Read Less";
  String buttonText;
  String desc =
      "Nike Dri-FIT is a polyester fabric designed to help you keep dry so you can more comfortably";
  String descFull =
      "Nike Dri-FIT is a polyester fabric designed to help you keep dry so you can more comfortably work harder, longer.";
  String descTemp;
  List<Review> _reviews = [
    Review("1", "Samuel Smith", "SS",
        "Wonderful jean, perfect gift for my girl for our anniversary!", 5),
    Review("2", "Beth Aida", "BA",
        "Wonderful jean, perfect gift for my girl for our anniversary!", 4),
    Review("3", "Samuel Smith", "SS",
        "Wonderful jean, perfect gift for my girl for our anniversary!", 5),
    Review("4", "Beth Aida", "BA",
        "Wonderful jean, perfect gift for my girl for our anniversary!", 2),
  ];
  @override
  void initState() {
    super.initState();

    _product = _productsController.getProductById(widget.productId);
    _product.customAttributes.forEach((element) {
      if (element.attributeCode == "short_description")
        desc = element.value ?? '';
    });
    _product.customAttributes.forEach((element) {
      if (element.attributeCode == "description")
        descFull = element.value ?? '';
    });
    descTemp = desc;
    buttonText = readMore;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      body: GestureDetector(
          onTap: () {
            hideKeyboard(context);
          },
          child: body(context)),
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
                    "Price",
                    style: mainTextStyle.copyWith(
                        fontSize: 14, color: subTextColor),
                  ),
                  Text(
                    _product.price.toString() + " EGP",
                    style:
                        mainTextStyle.copyWith(fontSize: 18, color: redColor),
                  ),
                ],
              ),
            ),
            Expanded(
                child: Container(
              height: 50,
              child: RaisedButton(
                elevation: 0,
                padding: EdgeInsets.symmetric(vertical: 16, horizontal: 12),
                color: redColor,
                onPressed: () {},
                child: Text(
                  "ADD",
                  style: subTextStyle.copyWith(color: whiteColor),
                ),
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
        SliverAppBar(
          backgroundColor: whiteColor,
          forceElevated: false,
          elevation: 0,
          actions: [
            GestureDetector(
              onTap: () {
                setState(() {
                  isFav = !isFav;
                });
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: CircleAvatar(
                  backgroundColor: isFav ? redColor : whiteColor,
                  child: Center(
                    child: Icon(
                      Icons.star_border,
                      color: isFav ? whiteColor : blackColor,
                    ),
                  ),
                ),
              ),
            )
          ],
          floating: true,
          pinned: true,
          expandedHeight: 450,
          flexibleSpace: FlexibleSpaceBar(
            background: Carousel(
              dotBgColor: Colors.transparent,
              dotColor: Theme.of(context).accentColor,
              dotIncreasedColor: Theme.of(context).accentColor,
              autoplay: false,
              images: _product.mediaGalleryEntries.map((e) {
                return Hero(
                  tag: "product${widget.productId}+${e.id.toString()}",
                  child: CachedNetworkImage(
                    imageUrl: baseUrlMedia + e.file,
                    width: MediaQuery.of(context).size.width,
                    fit: BoxFit.cover,
                    errorWidget: (c, s, w) {
                      return CachedNetworkImage(
                        imageUrl:
                            'http://mymalleg.com/pub/media/catalog/product/cache/p/r/product_1_2.jpg',
                        fit: BoxFit.cover,
                      );
                    },
                  ),
                );
              }).toList(),
            ),
          ),
        ),
        space(24),
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: AutoSizeText(
              _product.name,
              maxLines: 2,
              maxFontSize: 24,
              minFontSize: 14,
              style: mainTextStyle.copyWith(fontSize: 24),
            ),
          ),
        ),
        space(24),
        SliverPadding(
          padding: EdgeInsets.symmetric(horizontal: 16),
          sliver: SliverToBoxAdapter(
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 12, horizontal: 4),
                    decoration: BoxDecoration(
                        border: Border.all(color: lightGrey),
                        borderRadius: BorderRadius.circular(24)),
                    child: Center(
                      child: Text(
                        "Size",
                        style: subTextStyle,
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 12,
                ),
                Expanded(
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 12, horizontal: 4),
                    decoration: BoxDecoration(
                        border: Border.all(color: lightGrey),
                        borderRadius: BorderRadius.circular(24)),
                    child: Center(
                      child: Text(
                        "Size Chart",
                        style: subTextStyle,
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 12,
                ),
                Expanded(
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 12, horizontal: 4),
                    decoration: BoxDecoration(
                        border: Border.all(color: lightGrey),
                        borderRadius: BorderRadius.circular(24)),
                    child: Center(
                      child: Text(
                        "Colours",
                        style: subTextStyle,
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
        space(12),
        SliverPadding(
          padding: EdgeInsets.symmetric(horizontal: 16),
          sliver: SliverToBoxAdapter(
            child: Row(
              children: [
                Expanded(
                  child: Wrap(
                    alignment: WrapAlignment.center,
                    spacing: 8,
                    runSpacing: 2,
                    children: [
                      Text(
                        "S",
                        style: mainTextStyle.copyWith(fontSize: 14),
                      ),
                      Text(
                        "L",
                        style: mainTextStyle.copyWith(fontSize: 14),
                      ),
                      Text(
                        "XL",
                        style: mainTextStyle.copyWith(fontSize: 14),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  width: 12,
                ),
                Expanded(
                  child: const SizedBox(),
                ),
                const SizedBox(
                  width: 12,
                ),
                Expanded(
                  child: Wrap(
                    alignment: WrapAlignment.center,
                    spacing: 2,
                    runSpacing: 2,
                    children: [
                      Container(
                        width: 22,
                        height: 22,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: Color(0xFF33427D)),
                      ),
                      Container(
                        width: 22,
                        height: 22,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: Color(0xFFFF7A06)),
                      ),
                      Container(
                        width: 22,
                        height: 22,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: Color(0xFF7D3333)),
                      ),
                      Container(
                        width: 22,
                        height: 22,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: Color(0xFF7D3378)),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
        space(24),
        SliverPadding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          sliver: SliverToBoxAdapter(
            child: Text(
              "Details",
              style: mainTextStyle.copyWith(fontSize: 20),
            ),
          ),
        ),
        SliverPadding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          sliver: SliverToBoxAdapter(
            child: Text(
              descTemp,
              style: mainTextStyle.copyWith(
                  fontSize: 14, fontWeight: FontWeight.w400, height: 2),
            ),
          ),
        ),
        space(4),
        SliverPadding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          sliver: SliverToBoxAdapter(
            child: InkWell(
              onTap: () {
                setState(() {
                  if (buttonText == readMore) {
                    buttonText = readLess;
                    descTemp = descFull;
                  } else {
                    buttonText = readMore;
                    descTemp = desc;
                  }
                });
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: Text(
                  buttonText,
                  style: mainTextStyle.copyWith(
                      fontSize: 14,
                      fontWeight: FontWeight.w300,
                      color: redColor),
                ),
              ),
            ),
          ),
        ),
        space(16),
        SliverPadding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          sliver: SliverToBoxAdapter(
            child: Text(
              "Reviews",
              style: mainTextStyle.copyWith(fontSize: 20),
            ),
          ),
        ),
        space(12),
        SliverPadding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          sliver: SliverToBoxAdapter(
              child: Text(
            "Write your review",
            style: subTextStyle.copyWith(color: redColor),
          )),
        ),
        space(12),
        SliverPadding(
          padding: const EdgeInsets.symmetric(horizontal: 14),
          sliver: SliverToBoxAdapter(
            child: ListView.builder(
              itemBuilder: (c, i) => reviewItem(_reviews[i]),
              itemCount: _reviews.length,
              padding: EdgeInsets.zero,
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
            ),
          ),
        )
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

  Widget reviewItem(Review review) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: Row(
        children: [
          CircleAvatar(
            radius: 26,
            backgroundImage: AssetImage("assets/icons/image_.png"),
          ),
          const SizedBox(
            width: 26,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      review.name,
                      style: mainTextStyle.copyWith(fontSize: 14),
                    ),
                    Directionality(
                      textDirection: TextDirection.rtl,
                      child: SmoothStarRating(
                          allowHalfRating: false,
                          onRated: (v) {},
                          starCount: 5,
                          rating: review.stars.toDouble(),
                          defaultIconData: null,
                          filledIconData: FontAwesomeIcons.solidStar,
                          size: 14.0,
                          isReadOnly: true,
                          color: Color(0xFFEBE300),
                          borderColor: Color(0xFFEBE300),
                          spacing: 4.0),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 12,
                ),
                Text(
                  review.text,
                  style: subTextStyle.copyWith(height: 1.5),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}

class Review {
  final String id, name, image, text;
  final int stars;

  Review(this.id, this.name, this.image, this.text, this.stars);
}
