import 'package:e_commerce_alwalla/data/app_preference.dart';
import 'package:e_commerce_alwalla/generated/l10n.dart';
import 'package:e_commerce_alwalla/screen/home/home_tab/home_tab_screen.dart';
import 'package:e_commerce_alwalla/screen/product_details/product_details_screen.dart';
import 'package:e_commerce_alwalla/theme/app_theme.dart';
import 'package:e_commerce_alwalla/utils/common.dart';
import 'package:flutter/material.dart';

class WishListScreen extends StatefulWidget {
  @override
  _WishListScreenState createState() => _WishListScreenState();
}

class _WishListScreenState extends State<WishListScreen> {
  List<Product> _products = [
    Product("1", "assets/images/image_demo.png", "BeoPlay Speaker",
        "Bang and Olufsen", "755\$"),
    Product("2", "assets/images/image_2.png", "Leather Wristwatch", "Tag Heuer",
        "455\$"),
    Product("3", "assets/images/image.png", "BeoPlay Speaker",
        "Bang and Olufsen", "755\$",
        inStock: false),
    Product("4", "assets/images/image_demo.png", "BeoPlay Speaker",
        "Bang and Olufsen", "755\$"),
    Product("5", "assets/images/image.png", "BeoPlay Speaker",
        "Bang and Olufsen", "755\$"),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: whiteColor,
        title: Text("WishList"),
        centerTitle: true,
      ),
      body: GestureDetector(
          onTap: () {
            hideKeyboard(context);
          },
          child: body(context)),
    );
  }

  space(double size) {
    return SliverToBoxAdapter(
      child: SizedBox(
        height: size,
      ),
    );
  }

  body(BuildContext context) {
    return CustomScrollView(
      physics: BouncingScrollPhysics(),
      slivers: [
        space(24),
        SliverToBoxAdapter(
          child: ListView.builder(
            itemBuilder: (c, i) => productItem2(_products[i]),
            itemCount: _products.length,
            shrinkWrap: true,
            physics: BouncingScrollPhysics(),
          ),
        ),
        space(24),
        SliverPadding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          sliver: SliverToBoxAdapter(
            child: Text(
              S.of(context).recommended,
              style: mainTextStyle.copyWith(fontSize: 20),
            ),
          ),
        ),
        space(24),
        SliverToBoxAdapter(
          child: Container(
            height: 340,
            child: ListView.builder(
              itemBuilder: (c, i) => productItem(_products[i], i == 0),
              itemCount: _products.length,
              shrinkWrap: true,
              physics: BouncingScrollPhysics(),
              scrollDirection: Axis.horizontal,
            ),
          ),
        ),
        space(24),
      ],
    );
  }

  Widget productItem(Product product, bool isFirst) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (c) => ProductDetailsScreen(product: product),
          ),
        );
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
                child: SizedBox(
                    height: 250,
                    child: Hero(
                      tag: "product${product.id}",
                      child: Image.asset(
                        product.image,
                        fit: BoxFit.fill,
                      ),
                    ))),
            const SizedBox(
              height: 12,
            ),
            Text(
              product.title,
              style: mainTextStyle.copyWith(
                  fontWeight: FontWeight.w600, fontSize: 16),
            ),
            const SizedBox(
              height: 8,
            ),
            Text(
              product.brand,
              style: subTextStyle,
            ),
            const SizedBox(
              height: 12,
            ),
            Text(
              product.price,
              style: mainTextStyle.copyWith(
                  color: redColor, fontWeight: FontWeight.w600, fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }

  productItem2(Product product) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(6),
            child: Image.asset(
              product.image,
              fit: BoxFit.cover,
              width: 120,
              height: 120,
            ),
          ),
          const SizedBox(
            width: 32,
          ),
          Expanded(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                product.title,
                style: mainTextStyle.copyWith(
                    fontSize: 16, fontWeight: FontWeight.w400),
              ),
              const SizedBox(
                height: 6,
              ),
              Text(
                product.price,
                style: mainTextStyle.copyWith(
                    color: redColor, fontSize: 16, fontWeight: FontWeight.w400),
              ),
              const SizedBox(
                height: 24,
              ),
              Container(
                width: 90,
                height: 30,
                decoration: BoxDecoration(
                    color: product.inStock ? greenColor : orangeColor,
                    borderRadius: BorderRadius.circular(2)),
                child: Center(
                    child: Text(
                  product.inStock ? "In Stock" : "Out of Stock",
                  style: mainTextStyle.copyWith(
                      color: whiteColor,
                      fontSize: 13,
                      fontWeight: FontWeight.w400),
                )),
              )
            ],
          ))
        ],
      ),
    );
  }
}
