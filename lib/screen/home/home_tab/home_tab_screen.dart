import 'package:e_commerce_alwalla/data/app_preference.dart';
import 'package:e_commerce_alwalla/generated/l10n.dart';
import 'package:e_commerce_alwalla/screen/category/category_screen.dart';
import 'package:e_commerce_alwalla/screen/home/home_tab/home_bloc.dart';
import 'package:e_commerce_alwalla/screen/product_details/product_details_screen.dart';
import 'package:e_commerce_alwalla/screen/search/search_screen.dart';
import 'package:e_commerce_alwalla/theme/app_theme.dart';
import 'package:e_commerce_alwalla/utils/common.dart';
import 'package:e_commerce_alwalla/widget/search_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:page_transition/page_transition.dart';

class HomeTabScreen extends StatefulWidget {
  @override
  _HomeTabScreenState createState() => _HomeTabScreenState();
}

class _HomeTabScreenState extends State<HomeTabScreen> {
  final _homeBloc = HomeBloc();
  List<Category> _categories = [
    Category("1", "assets/icons/cat_1.svg", "Men"),
    Category("2", "assets/icons/cat_2.svg", "Women"),
    Category("3", "assets/icons/cat_3.svg", "Devices"),
    Category("4", "assets/icons/cat_4.svg", "Gadgets"),
    Category("5", "assets/icons/cat_5.svg", "Gaming"),
  ];
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
  List<Product> _products2 = [
    Product("6", "assets/images/image.png", "BeoPlay Speaker",
        "Bang and Olufsen", "755\$"),
    Product("7", "assets/images/image_2.png", "Leather Wristwatch", "Tag Heuer",
        "455\$"),
    Product("8", "assets/images/image_demo.png", "BeoPlay Speaker",
        "Bang and Olufsen", "755\$"),
    Product("9", "assets/images/image.png", "BeoPlay Speaker",
        "Bang and Olufsen", "755\$"),
    Product("10", "assets/images/image_demo.png", "BeoPlay Speaker",
        "Bang and Olufsen", "755\$"),
  ];
  List<Brand> _brands = [
    Brand("1", "assets/images/bo.png", "B&o", "5693"),
    Brand("2", "assets/images/beats.png", "beats", "1124"),
    Brand("1", "assets/images/bo.png", "B&o", "5693"),
    Brand("2", "assets/images/beats.png", "beats", "1124"),
    Brand("1", "assets/images/bo.png", "B&o", "5693"),
    Brand("2", "assets/images/beats.png", "beats", "1124"),
  ];
  @override
  void dispose() {
    _homeBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      body: BlocProvider(
        create: (BuildContext context) {
          return _homeBloc;
        },
        child: BlocListener(
          cubit: _homeBloc,
          listener: (c, HomeState state) async {
            if (state is Loading) {}
            if (state is Success) {}
            if (state is Failed) {
              showFailedMessage(context, state.error);
            }
          },
          child: BlocBuilder(
              cubit: _homeBloc,
              builder: (c, HomeState state) {
                return GestureDetector(
                    onTap: () {
                      hideKeyboard(context);
                    },
                    child: body(c));
              }),
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
          pinned: true,
          elevation: 0,
          floating: true,
          title: Hero(
            tag: "Search",
            child: SearchBar(
                onTap: () {
                  Navigator.push(
                      context,
                      PageTransition(
                          type: PageTransitionType.downToUp,
                          child: SearchScreen()));
                },
                textController: TextEditingController(),
                onComplete: () {}),
          ),
        ),
        space(32),
        SliverPadding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          sliver: SliverToBoxAdapter(
            child: Text(
              S.of(context).categories,
              style: mainTextStyle.copyWith(fontSize: 24),
            ),
          ),
        ),
        space(24),
        SliverToBoxAdapter(
          child: Container(
            height: 100,
            child: ListView.builder(
              itemBuilder: (c, i) => categoryItem(_categories[i]),
              itemCount: _categories.length,
              shrinkWrap: true,
              physics: BouncingScrollPhysics(),
              scrollDirection: Axis.horizontal,
            ),
          ),
        ),
        space(32),
        SliverPadding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          sliver: SliverToBoxAdapter(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  S.of(context).best_selling,
                  style: mainTextStyle.copyWith(fontSize: 24),
                ),
                FlatButton(
                    onPressed: () {},
                    child: Text(
                      S.of(context).see_all,
                      style: mainTextStyle.copyWith(fontSize: 14),
                    ))
              ],
            ),
          ),
        ),
        space(24),
        SliverToBoxAdapter(
          child: Container(
            height: 370,
            child: ListView.builder(
              itemBuilder: (c, i) => productItem(_products2[i], i == 0),
              itemCount: _products2.length,
              shrinkWrap: true,
              physics: BouncingScrollPhysics(),
              scrollDirection: Axis.horizontal,
            ),
          ),
        ),
        space(12),
        SliverToBoxAdapter(
          child: ClipRRect(
              borderRadius: BorderRadius.circular(6),
              child: Image.asset("assets/images/promo_image.png")),
        ),
        space(32),
        SliverPadding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          sliver: SliverToBoxAdapter(
            child: Text(
              S.of(context).featured_brands,
              style: mainTextStyle.copyWith(fontSize: 24),
            ),
          ),
        ),
        space(24),
        SliverToBoxAdapter(
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
        ),
        space(32),
        SliverPadding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          sliver: SliverToBoxAdapter(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  S.of(context).recommended,
                  style: mainTextStyle.copyWith(fontSize: 24),
                ),
                FlatButton(
                    onPressed: () {},
                    child: Text(
                      S.of(context).see_all,
                      style: mainTextStyle.copyWith(fontSize: 14),
                    ))
              ],
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

  Widget categoryItem(Category category) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (c) => CategoryScreen(category: category),
          ),
        );
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: Column(
          children: [
            CircleAvatar(
              radius: 32,
              backgroundColor: backgroundColor,
              child: Center(
                child: SvgPicture.asset(category.image),
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            Text(
              category.title,
              style: mainTextStyle.copyWith(fontSize: 12),
            )
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
      child: Card(
          elevation: 1,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          margin: isFirst
              ? EdgeInsets.only(
                  left: AppPreference.appLanguage == "en" ? 24 : 0,
                  bottom: 12,
                  top: 12,
                  right: AppPreference.appLanguage == "en" ? 0 : 24)
              : EdgeInsets.symmetric(vertical: 12, horizontal: 8),
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
}

class Category {
  final String id, image, title;

  Category(this.id, this.image, this.title);
}

class Brand {
  final String id, image, title, productCount;

  Brand(this.id, this.image, this.title, this.productCount);
}

class Product {
  final String id, image, title, brand, price;

  Product(this.id, this.image, this.title, this.brand, this.price);
}
