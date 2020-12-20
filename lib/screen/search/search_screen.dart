import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:e_commerce_alwalla/controller/search_controller.dart';
import 'package:e_commerce_alwalla/data/app_preference.dart';
import 'package:e_commerce_alwalla/generated/l10n.dart';
import 'package:e_commerce_alwalla/model/products_response.dart';
import 'package:e_commerce_alwalla/screen/product_details/product_details_screen.dart';
import 'package:e_commerce_alwalla/theme/app_theme.dart';
import 'package:e_commerce_alwalla/utils/common.dart';
import 'package:e_commerce_alwalla/utils/constants.dart';
import 'package:e_commerce_alwalla/widget/search_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final SearchController _searchController = Get.put(SearchController());
  final _searchEditController = TextEditingController();
  List<String> _tags = AppPreference.lastSearches;

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
            textController: _searchEditController,
            onComplete: () {
              hideKeyboard(context);
              _searchController.productsEmpty.value = false;
              var q = _searchEditController.text;
              if (q.isEmpty) {
                _searchController.searchedProducts.clear();
              } else {
                _searchController.searchProducts(q);
                if (AppPreference.lastSearches.length > 10) {
                  _tags.insert(0, q);

                  AppPreference.lastSearches = _tags.sublist(0, 10);
                } else {
                  _tags.add(q);
                  AppPreference.lastSearches = _tags;
                }

                setState(() {
                  _tags = AppPreference.lastSearches;
                });
              }
            },
            onClose: () {
              if (_searchEditController.text.isNotEmpty) {
                _searchController.productsEmpty.value = false;
                _searchEditController.text = '';
                _searchController.searchedProducts.clear();
              } else {
                Get.back();
              }
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
    return Obx(() {
      if (_searchController.loading.value)
        return Center(
          child: RefreshProgressIndicator(),
        );
      if (_searchController.searchedProducts.isNotEmpty)
        return SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 32,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Text(
                  "Search Result",
                  style: mainTextStyle,
                ),
              ),
              const SizedBox(
                height: 32,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: StaggeredGridView.countBuilder(
                  crossAxisCount: 2,
                  itemCount: _searchController.products.length,
                  mainAxisSpacing: 12,
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  crossAxisSpacing: 16,
                  staggeredTileBuilder: (int index) => new StaggeredTile.fit(1),
                  itemBuilder: (BuildContext context, int index) =>
                      productItem2(_searchController.products[index]),
                ),
              ),
            ],
          ),
        );
      return CustomScrollView(
        physics: BouncingScrollPhysics(),
        slivers: [
          space(32),
          if (_searchController.productsEmpty.value)
            SliverPadding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              sliver: SliverToBoxAdapter(
                child: Text(
                  "Could'nt found products for ${_searchEditController.text}",
                  style: subTextStyle,
                ),
              ),
            ),
          if (_searchController.productsEmpty.value) space(32),
          if (_tags.isNotEmpty)
            SliverPadding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              sliver: SliverToBoxAdapter(
                child: Text(
                  "Recent Searches",
                  style: mainTextStyle,
                ),
              ),
            ),
          if (_tags.isNotEmpty) space(24),
          SliverPadding(
            padding: EdgeInsets.symmetric(horizontal: 24),
            sliver: SliverToBoxAdapter(
              child: Wrap(
                alignment: WrapAlignment.start,
                spacing: 12,
                runSpacing: 12,
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
                itemBuilder: (c, i) =>
                    productItem(_searchController.products[i], i == 0),
                itemCount: _searchController.products.length,
                shrinkWrap: true,
                physics: BouncingScrollPhysics(),
                scrollDirection: Axis.horizontal,
              ),
            ),
          ),
          space(32),
        ],
      );
    });
  }

  Widget productItem2(Product product) {
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
                      fit: BoxFit.cover,
                      height: 210,
                    );
                  },
                  fit: BoxFit.cover,
                  height: 210,
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

  Widget productItem(Product product, bool isFirst) {
    var image = '';

    if (product.mediaGalleryEntries != null) {
      if (product.mediaGalleryEntries.isNotEmpty) {
        image = product.mediaGalleryEntries.first.file;
      }
    }
    return GestureDetector(
      onTap: () {
        Get.to(ProductDetailsScreen(
          productId: product.sku,
        ));
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
                child: CachedNetworkImage(
                  imageUrl: baseUrlMedia + image,
                  errorWidget: (c, s, w) {
                    return CachedNetworkImage(
                      imageUrl:
                          'http://mymalleg.com/pub/media/catalog/product/cache/no_image.jpg',
                      fit: BoxFit.cover,
                      height: 210,
                    );
                  },
                  fit: BoxFit.cover,
                  height: 210,
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

  Widget tagItem(String tag) {
    return ActionChip(
      elevation: 0.2,
      label: Text(
        tag,
        style: mainTextStyle.copyWith(fontSize: 12),
      ),
      backgroundColor: backgroundColor,
      onPressed: () {
        hideKeyboard(context);
        _searchController.productsEmpty.value = false;
        _searchEditController.text = tag;
        _searchController.searchProducts(tag);
        if (AppPreference.lastSearches.length > 10) {
          _tags.insert(0, tag);

          AppPreference.lastSearches = _tags.sublist(0, 10);
        } else {
          _tags.add(tag);
          AppPreference.lastSearches = _tags;
        }

        setState(() {
          _tags = AppPreference.lastSearches;
        });
      },
    );
  }
}

class Tag {
  final String title, id;

  Tag(this.title, this.id);
}
