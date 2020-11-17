import 'package:e_commerce_alwalla/data/app_preference.dart';
import 'package:e_commerce_alwalla/generated/l10n.dart';

import 'package:e_commerce_alwalla/screen/filter/filter_screen.dart';
import 'package:e_commerce_alwalla/screen/home/home_tab/home_tab_screen.dart';
import 'package:e_commerce_alwalla/screen/product_details/product_details_screen.dart';
import 'package:e_commerce_alwalla/theme/app_theme.dart';
import 'package:e_commerce_alwalla/utils/common.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CategoryScreen extends StatefulWidget {
  final Category category;
  final Brand brand;

  const CategoryScreen({Key key, this.category, this.brand}) : super(key: key);
  @override
  _CategoryScreenState createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen>
    with SingleTickerProviderStateMixin {
  List<Brand> _brands = [
    Brand("1", "assets/images/bo.png", "B&o", "5693"),
    Brand("2", "assets/images/beats.png", "beats", "1124"),
    Brand("1", "assets/images/bo.png", "B&o", "5693"),
    Brand("2", "assets/images/beats.png", "beats", "1124"),
    Brand("1", "assets/images/bo.png", "B&o", "5693"),
    Brand("2", "assets/images/beats.png", "beats", "1124"),
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

  TabController _tabController;
  List<Tab> _tabs;
  @override
  void initState() {
    super.initState();
    _tabs = [
      Tab(
        text: "All",
      ),
      Tab(
        text: "HeadPhones",
      ),
      Tab(
        text: "Speakers",
      ),
      Tab(
        text: "Microphones",
      ),
    ];
    _tabController = TabController(length: 4, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        backgroundColor: whiteColor,
        elevation: 0,
        title: Text(
          widget.category == null ? widget.brand.title : widget.category.title,
          style: mainTextStyle.copyWith(fontSize: 16),
        ),
        centerTitle: true,
      ),
      body: GestureDetector(
          onTap: () {
            hideKeyboard(context);
          },
          child: body(context)),
      bottomNavigationBar: Container(
        padding: EdgeInsets.symmetric(vertical: 16),
        color: whiteColor,
        child: Row(
          children: [
            Expanded(
              child: Text(
                "No filters applied",
                textAlign: TextAlign.center,
                style: mainTextStyle.copyWith(fontSize: 15),
              ),
            ),
            Expanded(
                child: Container(
              height: 50,
              padding: EdgeInsets.symmetric(horizontal: 24),
              child: RaisedButton(
                elevation: 0,
                color: redColor,
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (c) => FilterScreen(),
                          fullscreenDialog: true));
                },
                child: Text(
                  "FILTER",
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
    double width = (MediaQuery.of(context).size.width) / 2;
    double height = 380;
    double aspect = width / height;
    return CustomScrollView(
      physics: BouncingScrollPhysics(),
      slivers: [
        space(32),
        widget.category != null
            ? SliverPadding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                sliver: SliverToBoxAdapter(
                  child: Text(
                    "Top Brands",
                    style: mainTextStyle.copyWith(fontSize: 18),
                  ),
                ),
              )
            : SliverToBoxAdapter(),
        widget.category != null ? space(24) : space(0),
        widget.category != null
            ? SliverToBoxAdapter(
                child: Container(
                  height: 100,
                  child: ListView.builder(
                    itemBuilder: (c, i) => brandItem(_brands[i], i == 0),
                    itemCount: _brands.length,
                    shrinkWrap: true,
                    physics: BouncingScrollPhysics(),
                    scrollDirection: Axis.horizontal,
                  ),
                ),
              )
            : SliverToBoxAdapter(
                child: TabBar(
                  tabs: _tabs,
                  labelColor: mainTextColor,
                  indicator: BoxDecoration(),
                  unselectedLabelColor: mainTextColor.withOpacity(0.2),
                  labelPadding: EdgeInsets.symmetric(horizontal: 16),
                  labelStyle: mainTextStyle.copyWith(fontSize: 14),
                  isScrollable: _tabs.length > 4,
                  controller: _tabController,
                ),
              ),
        space(32),
        SliverPadding(
          padding: EdgeInsets.symmetric(horizontal: 16),
          sliver: SliverGrid.count(
            crossAxisCount: 2,
            mainAxisSpacing: 12,
            crossAxisSpacing: 16,
            childAspectRatio: aspect,
            children: _products.map((e) => productItem(e)).toList(),
          ),
        ),
      ],
    );
  }

  Widget brandItem(Brand brand, bool isFirst) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (c) => CategoryScreen(
              brand: brand,
            ),
          ),
        );
      },
      child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            boxShadow: [
              BoxShadow(
                  color: Color.fromRGBO(36, 36, 36, 0.05),
                  blurRadius: 10,
                  offset: Offset(0, 5))
            ],
            color: whiteColor,
          ),
          margin: isFirst
              ? EdgeInsets.only(
                  left: AppPreference.appLanguage == "en" ? 16 : 8,
                  bottom: 12,
                  top: 12,
                  right: AppPreference.appLanguage == "en" ? 8 : 16)
              : EdgeInsets.symmetric(vertical: 16, horizontal: 8),
          child: Container(
            width: MediaQuery.of(context).size.width / 2,
            child: ListTile(
              leading: CircleAvatar(
                  backgroundColor: Colors.transparent,
                  child: Image.asset(brand.image)),
              title: Text(brand.title),
              subtitle: Text(S.of(context).products(brand.productCount)),
            ),
          )),
    );
  }

  space(double size) {
    return SliverToBoxAdapter(
      child: SizedBox(
        height: size,
      ),
    );
  }

  Widget productItem(Product product) {
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
                        )))),
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
}
