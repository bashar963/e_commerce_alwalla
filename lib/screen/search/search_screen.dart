import 'package:e_commerce_alwalla/data/app_preference.dart';
import 'package:e_commerce_alwalla/generated/l10n.dart';
import 'package:e_commerce_alwalla/screen/home/home_tab/home_tab_screen.dart';
import 'package:e_commerce_alwalla/screen/product_details/product_details_screen.dart';
import 'package:e_commerce_alwalla/theme/app_theme.dart';
import 'package:e_commerce_alwalla/utils/common.dart';
import 'package:e_commerce_alwalla/widget/search_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  List<Tag> _tags = [
    Tag("Denim Jeans", "id"),
    Tag("Mini Skirt", "id"),
    Tag("Jacket", "id"),
    Tag("Accessories", "id"),
    Tag("Sports Accessories", "id"),
    Tag("Yoga Pants", "id"),
    Tag("Eye Shadow", "id"),
  ];
  List<Product> _products = [
    Product("1", "assets/images/image.png", "BeoPlay Speaker",
        "Bang and Olufsen", "755\$"),
    Product("2", "assets/images/image_2.png", "Leather Wristwatch", "Tag Heuer",
        "455\$"),
    Product("3", "assets/images/image.png", "BeoPlay Speaker",
        "Bang and Olufsen", "755\$"),
    Product("4", "assets/images/image.png", "BeoPlay Speaker",
        "Bang and Olufsen", "755\$"),
    Product("5", "assets/images/image.png", "BeoPlay Speaker",
        "Bang and Olufsen", "755\$"),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        backgroundColor: whiteColor,
        automaticallyImplyLeading: false,
        elevation: 0,
        title: Hero(
          tag: "Search",
          child: SearchBar(
            textController: TextEditingController(),
            onComplete: () {},
            onClose: () {
              Navigator.pop(context);
            },
          ),
        ),
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

  Widget body(BuildContext context) {
    return CustomScrollView(
      physics: BouncingScrollPhysics(),
      slivers: [
        space(32),
        SliverPadding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          sliver: SliverToBoxAdapter(
            child: Text(
              "Recent Searches",
              style: mainTextStyle,
            ),
          ),
        ),
        space(24),
        SliverPadding(
          padding: EdgeInsets.symmetric(horizontal: 24),
          sliver: SliverToBoxAdapter(
            child: Wrap(
              alignment: WrapAlignment.spaceBetween,
              children: _tags.map((e) => tagItem(e)).toList(),
            ),
          ),
        ),
        space(24),
        SliverPadding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          sliver: SliverToBoxAdapter(
            child: Text(
              S.of(context).recommended,
              style: mainTextStyle.copyWith(fontSize: 24),
            ),
          ),
        ),
        space(24),
        SliverToBoxAdapter(
          child: Container(
            height: 370,
            child: ListView.builder(
              itemBuilder: (c, i) => productItem(_products[i], i == 0),
              itemCount: _products.length,
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
    return GestureDetector(
      onTap: () {
        Get.to(ProductDetailsScreen(), transition: Transition.downToUp);
      },
      child: Container(
        padding: isFirst
            ? EdgeInsets.only(
                left: AppPreference.appLanguage == "en" ? 24 : 0,
                right: AppPreference.appLanguage == "en" ? 0 : 24)
            : EdgeInsets.symmetric(horizontal: 12),
        width: (MediaQuery.of(context).size.width / 2),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ClipRRect(
                borderRadius: BorderRadius.circular(6),
                child: SizedBox(
                    height: 240,
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
              style: mainTextStyle,
            ),
            const SizedBox(
              height: 12,
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
                  color: redColor, fontWeight: FontWeight.w400),
            ),
          ],
        ),
      ),
    );
  }

  Widget tagItem(Tag tag) {
    return ActionChip(
      elevation: 0.2,
      label: Text(
        tag.title,
        style: mainTextStyle.copyWith(fontSize: 12),
      ),
      backgroundColor: backgroundColor,
      onPressed: () {},
    );
  }
}

class Tag {
  final String title, id;

  Tag(this.title, this.id);
}
