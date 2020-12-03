import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:e_commerce_alwalla/controller/view_all_controller.dart';
import 'package:e_commerce_alwalla/model/products_response.dart';
import 'package:e_commerce_alwalla/screen/product_details/product_details_screen.dart';
import 'package:e_commerce_alwalla/theme/app_theme.dart';
import 'package:e_commerce_alwalla/utils/common.dart';
import 'package:e_commerce_alwalla/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';

class ViewAllScreen extends StatefulWidget {
  final String name, id;

  const ViewAllScreen({Key key, this.name, this.id}) : super(key: key);
  @override
  _ViewAllScreenState createState() => _ViewAllScreenState();
}

class _ViewAllScreenState extends State<ViewAllScreen> {
  final ViewAllController _viewAllController = Get.put(ViewAllController());

  @override
  void initState() {
    super.initState();
    _viewAllController.getProductsByCategory(widget.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        backgroundColor: whiteColor,
        elevation: 0,
        title: Text(
          widget.name,
          style: mainTextStyle.copyWith(fontSize: 16),
        ),
        centerTitle: true,
      ),
      body: GestureDetector(
          onTap: () {
            hideKeyboard(context);
          },
          child: body(context)),
    );
  }

  Widget body(BuildContext context) {
    return Obx(() {
      return SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          children: [
            const SizedBox(
              height: 32,
            ),
            if (_viewAllController.loading.value)
              Center(
                child: RefreshProgressIndicator(),
              ),
            _viewAllController.productsEmpty.value
                ? Center(
                    child: Text('No Products found'),
                  )
                : Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    child: StaggeredGridView.countBuilder(
                      crossAxisCount: 2,
                      itemCount: _viewAllController.products.length,
                      mainAxisSpacing: 12,
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      crossAxisSpacing: 16,
                      staggeredTileBuilder: (int index) =>
                          new StaggeredTile.fit(1),
                      itemBuilder: (BuildContext context, int index) =>
                          productItem(_viewAllController.products[index]),
                    ),
                  ),
          ],
        ),
      );
    });
  }

  Widget productItem(Product product) {
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
