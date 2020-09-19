import 'package:e_commerce_alwalla/data/app_preference.dart';
import 'package:e_commerce_alwalla/screen/home/home_screen.dart';
import 'package:e_commerce_alwalla/screen/home/home_tab/home_tab_screen.dart';
import 'package:e_commerce_alwalla/screen/product_details/product_details_screen.dart';
import 'package:e_commerce_alwalla/theme/app_theme.dart';
import 'package:flutter/material.dart';

class SummaryScreen extends StatefulWidget {
  @override
  _SummaryScreenState createState() => _SummaryScreenState();
}

class _SummaryScreenState extends State<SummaryScreen> {
  List<Product> _products = [
    Product("1", "assets/images/image_demo.png", "BeoPlay Speaker",
        "Bang and Olufsen", "755\$"),
    Product("2", "assets/images/image_2.png", "Leather Wristwatch", "Tag Heuer",
        "455\$"),
    Product("3", "assets/images/image.png", "BeoPlay Speaker",
        "Bang and Olufsen", "755\$"),
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
        backgroundColor: whiteColor,
        title: Text("Summary"),
        centerTitle: true,
        elevation: 0,
      ),
      body: body(context),
      bottomNavigationBar: Container(
        padding: EdgeInsets.symmetric(vertical: 24, horizontal: 24),
        color: whiteColor,
        child: Row(
          children: [
            Expanded(
                child: OutlineButton(
              padding: EdgeInsets.symmetric(vertical: 16, horizontal: 12),
              color: redColor,
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text(
                "BACK",
                style: subTextStyle.copyWith(color: redColor),
              ),
            )),
            const SizedBox(
              width: 24,
            ),
            Expanded(
                child: RaisedButton(
              padding: EdgeInsets.symmetric(vertical: 16, horizontal: 12),
              color: redColor,
              onPressed: () {
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext context) => HomeScreen()),
                    ModalRoute.withName('/home'));
              },
              child: Text(
                "PAY",
                style: subTextStyle.copyWith(color: whiteColor),
              ),
            ))
          ],
        ),
      ),
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
        SliverToBoxAdapter(
          child: Container(
            height: 200,
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
        SliverToBoxAdapter(
          child: Divider(),
        ),
        space(32),
        SliverToBoxAdapter(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Text(
                  "Shipping Address",
                  style: mainTextStyle.copyWith(fontSize: 24),
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Text(
                  "21, Alex Davidson Avenue, Opposite Omegatron, Vicent Smith Quarters, Victoria Island, Lagos, Nigeria",
                  style: subTextStyle.copyWith(fontSize: 18),
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              FlatButton(
                  onPressed: () {
                    Navigator.pop(context, 1);
                  },
                  child: Text(
                    "Change",
                    style: subTextStyle.copyWith(color: redColor, fontSize: 18),
                  ))
            ],
          ),
        ),
        space(32),
        SliverToBoxAdapter(
          child: Divider(),
        ),
        space(32),
        SliverToBoxAdapter(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Text(
                  "Payment",
                  style: mainTextStyle.copyWith(fontSize: 24),
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Text(
                  "Cash on Delivery",
                  style: subTextStyle.copyWith(fontSize: 18),
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              FlatButton(
                  onPressed: () {
                    Navigator.pop(context, 2);
                  },
                  child: Text(
                    "Change",
                    style: subTextStyle.copyWith(color: redColor, fontSize: 18),
                  ))
            ],
          ),
        ),
        space(32),
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
                left: AppPreference.appLanguage == "en" ? 24 : 0,
                right: AppPreference.appLanguage == "en" ? 0 : 24)
            : EdgeInsets.symmetric(horizontal: 12),
        width: ((MediaQuery.of(context).size.width - 48) / 2),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ClipRRect(
                borderRadius: BorderRadius.circular(6),
                child: SizedBox(
                    height: 150,
                    child: Hero(
                      tag: "product${product.id}",
                      child: Image.asset(
                        product.image,
                        fit: BoxFit.cover,
                      ),
                    ))),
            const SizedBox(
              height: 6,
            ),
            Text(
              product.title,
              style: mainTextStyle,
            ),
            const SizedBox(
              height: 6,
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
