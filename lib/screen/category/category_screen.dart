import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:e_commerce_alwalla/controller/categories_controller.dart';
import 'package:e_commerce_alwalla/data/app_preference.dart';
import 'package:e_commerce_alwalla/generated/l10n.dart';
import 'package:e_commerce_alwalla/model/categories_response.dart';
import 'package:e_commerce_alwalla/model/products_response.dart' as p;
import 'package:e_commerce_alwalla/screen/filter/filter_screen.dart';
import 'package:e_commerce_alwalla/screen/home/home_tab/home_tab_screen.dart';
import 'package:e_commerce_alwalla/screen/product_details/product_details_screen.dart';
import 'package:e_commerce_alwalla/theme/app_theme.dart';
import 'package:e_commerce_alwalla/utils/common.dart';
import 'package:e_commerce_alwalla/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';

class CategoryScreen extends StatefulWidget {
  final CategoryChild category;
  final Brand brand;

  const CategoryScreen({Key key, this.category, this.brand}) : super(key: key);
  @override
  _CategoryScreenState createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen>
    with SingleTickerProviderStateMixin {
  final CategoriesController _categoriesController = Get.find();
  List<Brand> _brands = [
    Brand("1", "assets/images/bo.png", "B&o", "5693"),
    Brand("2", "assets/images/beats.png", "beats", "1124"),
    Brand("1", "assets/images/bo.png", "B&o", "5693"),
    Brand("2", "assets/images/beats.png", "beats", "1124"),
    Brand("1", "assets/images/bo.png", "B&o", "5693"),
    Brand("2", "assets/images/beats.png", "beats", "1124"),
  ];

  TabController _tabController;
  List<Tab> _tabs;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    if (widget.category != null)
      _categoriesController
          .getProductsByCategory(widget.category.id.toString());
    _tabs = [
      Tab(
        text: "All",
      )
    ];
    widget.category.children.forEach((element) {
      _tabs.add(Tab(
        text: element.name,
      ));
    });
    _tabController = TabController(length: _tabs.length, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        backgroundColor: whiteColor,
        elevation: 0,
        title: Text(
          widget.category == null ? widget.brand.title : widget.category.name,
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
    return Obx(() {
      return SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 12,
            ),
            if (_tabs.length > 1)
              TabBar(
                tabs: _tabs,
                labelColor: mainTextColor,
                indicator: BoxDecoration(),
                physics: BouncingScrollPhysics(),
                onTap: (index) {
                  if (index == 0) {
                    _categoriesController
                        .getProductsByCategory(widget.category.id.toString());
                  } else {
                    if (widget.category.children[index - 1].children != null &&
                        widget
                            .category.children[index - 1].children.isNotEmpty) {
                      Get.to(CategoryScreen(
                        category: widget.category.children[index - 1],
                      ));
                    } else {
                      _categoriesController.getProductsByCategory(
                          widget.category.children[index - 1].id.toString());
                    }
                  }
                },
                unselectedLabelColor: mainTextColor.withOpacity(0.2),
                labelPadding: EdgeInsets.symmetric(horizontal: 16),
                labelStyle: mainTextStyle.copyWith(fontSize: 14),
                isScrollable: _tabs.length > 4,
                controller: _tabController,
              ),
            const SizedBox(
              height: 12,
            ),
            widget.category != null
                ? Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: Text(
                      "Top Brands",
                      style: mainTextStyle.copyWith(fontSize: 18),
                    ),
                  )
                : const SizedBox.shrink(),
            widget.category != null
                ? const SizedBox(
                    height: 24,
                  )
                : const SizedBox(
                    height: 0,
                  ),
            Container(
              height: 100,
              child: ListView.builder(
                itemBuilder: (c, i) => brandItem(_brands[i], i == 0),
                itemCount: _brands.length,
                shrinkWrap: true,
                physics: BouncingScrollPhysics(),
                scrollDirection: Axis.horizontal,
              ),
            ),
            const SizedBox(
              height: 32,
            ),
            if (_categoriesController.loading.value)
              Center(
                child: RefreshProgressIndicator(),
              ),
            _categoriesController.productsEmpty.value
                ? Center(
                    child: Text('No Products found'),
                  )
                : Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    child: StaggeredGridView.countBuilder(
                      crossAxisCount: 2,
                      itemCount: _categoriesController.products.length,
                      mainAxisSpacing: 12,
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      crossAxisSpacing: 16,
                      staggeredTileBuilder: (int index) =>
                          new StaggeredTile.fit(1),
                      itemBuilder: (BuildContext context, int index) =>
                          productItem(_categoriesController.products[index]),
                    ),
                  ),
          ],
        ),
      );
    });
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

  Widget productItem(p.Product product) {
    var image = '';

    if (product.mediaGalleryEntries != null) {
      if (product.mediaGalleryEntries.isNotEmpty) {
        image = product.mediaGalleryEntries.first.file;
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
                      fit: BoxFit.fill,
                      height: 240,
                    );
                  },
                  fit: BoxFit.fill,
                  height: 240,
                )),
            const SizedBox(
              height: 12,
            ),
            AutoSizeText(
              product.name,
              maxLines: 1,
              maxFontSize: 18,
              minFontSize: 15,
              style: mainTextStyle,
            ),
            const SizedBox(
              height: 12,
            ),
            Text(
              product.sku,
              style: subTextStyle,
            ),
            const SizedBox(
              height: 12,
            ),
            Text(
              product.price.toString() + " EGP",
              style: mainTextStyle.copyWith(
                  color: redColor, fontWeight: FontWeight.w400),
            ),
          ],
        ),
      ),
    );
  }
}
