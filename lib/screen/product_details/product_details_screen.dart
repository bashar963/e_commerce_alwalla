import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_pro/carousel_pro.dart';
import 'package:e_commerce_alwalla/controller/cart_controller.dart';
import 'package:e_commerce_alwalla/controller/products_controller.dart';
import 'package:e_commerce_alwalla/data/app_preference.dart';
import 'package:e_commerce_alwalla/generated/l10n.dart';
import 'package:e_commerce_alwalla/model/products_response.dart';
import 'package:e_commerce_alwalla/theme/app_theme.dart';
import 'package:e_commerce_alwalla/utils/common.dart';
import 'package:e_commerce_alwalla/utils/constants.dart';
import 'package:e_commerce_alwalla/widget/product_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_svg/flutter_svg.dart';
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
  final CartController _cartController = Get.find();
  List<Product> _relatedProducts = [];
  Product _product;
  bool isFav = false;
  String readMore = "Read More";
  String readLess = "Read Less";
  String buttonText;
  String desc = "";
  String descFull = "";
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
  dynamic _total = 0.0;
  List<dynamic> _options = [];
  @override
  void initState() {
    super.initState();

    _product = _productsController.getProductById(widget.productId);
    if (_product.productLinks != null)
      _product.productLinks.forEach((element) {
        var p = _productsController.getProductById(element.sku);
        if (p != null) _relatedProducts.add(p);
      });
    if (_product.options != null) {
      _product.options.forEach((element) {
        element.values.forEach((v) {
          v.isSelected = false;
        });
      });
    }
    _product.customAttributes.forEach((element) {
      if (element.attributeCode == "short_description")
        desc = element.value ?? '';
    });
    _product.customAttributes.forEach((element) {
      if (element.attributeCode == "description")
        descFull = element.value ?? '';
    });
    _total = _product.price;
    descTemp = desc;
    buttonText = readMore;
  }

  @override
  Widget build(BuildContext context) {
    dynamic options = 0.0;
    _options.forEach((element) {
      options += element;
    });
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
                    (_total + options).toString() + " EGP",
                    style:
                        mainTextStyle.copyWith(fontSize: 18, color: redColor),
                  ),
                ],
              ),
            ),
            Expanded(
                child: RaisedButton(
              elevation: 0,
              padding: EdgeInsets.symmetric(vertical: 16, horizontal: 12),
              color: redColor,
              onPressed: addToCart,
              child: Text(
                "ADD",
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
                            'http://mymalleg.com/pub/media/catalog/product/cache/no_image.jpg',
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
        if (_product.options.isNotEmpty)
          SliverPadding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            sliver: SliverToBoxAdapter(
              child: productOptions(),
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
          padding: const EdgeInsets.symmetric(horizontal: 10),
          sliver: SliverToBoxAdapter(
            child: Html(
              data: descTemp,
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
        ),
        if (_relatedProducts.length > 0) space(32),
        if (_relatedProducts.length > 0)
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            sliver: SliverToBoxAdapter(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Related products',
                    style: mainTextStyle.copyWith(fontSize: 18),
                  ),
                  InkWell(
                    onTap: () {},
                    child: Padding(
                      padding: const EdgeInsets.only(
                          left: 8, right: 0, top: 8, bottom: 8),
                      child: Text(
                        S.of(context).see_all,
                        style: mainTextStyle.copyWith(fontSize: 14),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        if (_relatedProducts.length > 0) space(24),
        if (_relatedProducts.length > 0)
          SliverToBoxAdapter(
            child: Container(
              height: 250,
              child: ListView.builder(
                itemBuilder: (c, i) => productItem(_relatedProducts[i], i == 0),
                itemCount: _relatedProducts.length,
                shrinkWrap: true,
                physics: BouncingScrollPhysics(),
                scrollDirection: Axis.horizontal,
              ),
            ),
          ),
        space(32),
      ],
    );
  }

  Widget productItem(Product product, bool isFirst) {
    var image = '';
    if (product != null) {
      if (product.mediaGalleryEntries != null) {
        if (product.mediaGalleryEntries.isNotEmpty) {
          image = product.mediaGalleryEntries.first.file;
        }
      }
    }
    return GestureDetector(
      onTap: () {
        Get.to(ProductDetailsScreen(
          product: product,
          productId: product.sku,
        ));
      },
      child: Container(
        padding: isFirst
            ? EdgeInsets.only(
                left: AppPreference.appLanguage == "en" ? 16 : 12,
                right: AppPreference.appLanguage == "en" ? 12 : 16)
            : EdgeInsets.symmetric(horizontal: 12),
        width: (MediaQuery.of(context).size.width / 2),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(6),
              child: CachedNetworkImage(
                imageUrl: baseUrlMedia + image,
                errorWidget: (c, s, w) {
                  return CachedNetworkImage(
                    imageUrl:
                        'http://mymalleg.com/pub/media/catalog/product/cache/no_image.jpg',
                    fit: BoxFit.cover,
                    height: 160,
                  );
                },
                fit: BoxFit.cover,
                height: 160,
              ),
            ),
            const SizedBox(
              height: 12,
            ),
            Text(
              product.name,
              style: mainTextStyle.copyWith(
                  fontWeight: FontWeight.w600, fontSize: 16),
            ),
            const SizedBox(
              height: 8,
            ),
            Text(
              product.sku,
              style: subTextStyle,
            ),
            const SizedBox(
              height: 12,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  product.price.toString() + " EGP",
                  style: mainTextStyle.copyWith(
                      color: redColor,
                      fontWeight: FontWeight.w600,
                      fontSize: 16),
                ),
                InkWell(
                    onTap: () {
                      openDialog(product);
                    },
                    child: SvgPicture.asset("assets/icons/shopping-bag.svg"))
              ],
            ),
          ],
        ),
      ),
    );
  }

  void openDialog(Product product) {
    if (product.options.isEmpty) {
      _cartController.addItemToCar(null, product.sku);
    } else
      Get.dialog(ProductDialog(product));
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

  Widget productOptions() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: _product.options.map((e) {
        return Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.symmetric(vertical: 12, horizontal: 4),
                  decoration: BoxDecoration(
                      border: Border.all(color: lightGrey),
                      borderRadius: BorderRadius.circular(24)),
                  child: Center(
                    child: Text(
                      e.title,
                      style: subTextStyle,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
                Wrap(
                  alignment: WrapAlignment.center,
                  spacing: 8,
                  runSpacing: 2,
                  children: e.values.map((val) {
                    if (e.title == 'Color' ||
                        e.title == 'Colors' ||
                        e.title == 'Colour' ||
                        e.title == 'Colours')
                      return InkWell(
                        onTap: () {
                          setState(() {
                            e.values.forEach((element) {
                              if (element.isSelected) {
                                _options.remove(element.price);
                              }
                              element.isSelected = false;
                            });

                            val.isSelected = true;
                            if (!_options.contains(val.price))
                              _options.add(val.price);
                          });
                        },
                        child: Container(
                          width: val.isSelected ? 28 : 26,
                          height: val.isSelected ? 28 : 26,
                          decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                    color: Color.fromRGBO(36, 36, 36, 0.9),
                                    blurRadius: 20,
                                    offset: Offset(0, 5))
                              ],
                              border: val.isSelected
                                  ? Border.all(color: subTextColor, width: 2)
                                  : null,
                              borderRadius: BorderRadius.circular(
                                  val.isSelected ? 11 : 10),
                              color: getColor(val.title)),
                        ),
                      );
                    return InkWell(
                      onTap: () {
                        setState(() {
                          e.values.forEach((element) {
                            if (element.isSelected) {
                              _options.remove(element.price);
                            }
                            element.isSelected = false;
                          });
                          val.isSelected = true;
                          if (!_options.contains(val.price))
                            _options.add(val.price);
                        });
                      },
                      child: Container(
                        padding:
                            EdgeInsets.symmetric(vertical: 4, horizontal: 6),
                        decoration: val.isSelected
                            ? BoxDecoration(
                                border: Border.all(color: lightGrey),
                                borderRadius: BorderRadius.circular(24))
                            : null,
                        child: Text(
                          val.title,
                          style: mainTextStyle.copyWith(fontSize: 14),
                        ),
                      ),
                    );
                  }).toList(),
                )
              ],
            ),
          ),
        );
      }).toList(),
    );
  }

  void addToCart() {
    if (_product.options.isNotEmpty) {
      List<Map<String, dynamic>> itemOptions = [];
      int optionsLength = _product.options.length;
      int selectedOptions = 0;
      _product.options.forEach((element) {
        bool hasSelected = false;
        element.values.forEach((val) {
          if (val.isSelected) {
            hasSelected = true;
            itemOptions.add({
              "optionValue": val.optionTypeId.toString(),
              "optionId": element.optionId.toString()
            });
          }
        });
        if (hasSelected) selectedOptions++;
      });

      if (selectedOptions == optionsLength)
        _cartController.addItemToCar(itemOptions, _product.sku);
      else
        showFailedMessage(context, 'Please choose option');
    } else {
      _cartController.addItemToCar(null, _product.sku);
    }
  }
}

class Review {
  final String id, name, image, text;
  final int stars;

  Review(this.id, this.name, this.image, this.text, this.stars);
}
