import 'package:e_commerce_alwalla/data/app_preference.dart';
import 'package:e_commerce_alwalla/generated/l10n.dart';
import 'package:e_commerce_alwalla/screen/category/category_bloc.dart';
import 'package:e_commerce_alwalla/screen/filter/filter_screen.dart';
import 'package:e_commerce_alwalla/screen/home/home_tab/home_tab_screen.dart';
import 'package:e_commerce_alwalla/screen/product_details/product_details_screen.dart';
import 'package:e_commerce_alwalla/theme/app_theme.dart';
import 'package:e_commerce_alwalla/utils/common.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CategoryScreen extends StatefulWidget {
  final Category category;
  final Brand brand;

  const CategoryScreen({Key key, this.category, this.brand}) : super(key: key);
  @override
  _CategoryScreenState createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen>
    with SingleTickerProviderStateMixin {
  final _categoryBloc = CategoryBloc();
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
  void dispose() {
    _categoryBloc.close();
    super.dispose();
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
      body: BlocProvider(
        create: (BuildContext context) {
          return _categoryBloc;
        },
        child: BlocListener(
          cubit: _categoryBloc,
          listener: (c, CategoryState state) async {
            if (state is Loading) {}
            if (state is Success) {}
            if (state is Failed) {
              showFailedMessage(context, state.error);
            }
          },
          child: BlocBuilder(
              cubit: _categoryBloc,
              builder: (c, CategoryState state) {
                return GestureDetector(
                    onTap: () {
                      hideKeyboard(context);
                    },
                    child: body(c));
              }),
        ),
      ),
      bottomNavigationBar: Container(
        padding: EdgeInsets.symmetric(vertical: 24, horizontal: 24),
        color: whiteColor,
        child: Row(
          children: [
            Expanded(
              child: Text(
                "No filter applied",
                style: mainTextStyle.copyWith(fontSize: 14),
              ),
            ),
            Expanded(
                child: RaisedButton(
              padding: EdgeInsets.symmetric(vertical: 12, horizontal: 12),
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
            ))
          ],
        ),
      ),
    );
  }

  Widget body(BuildContext context) {
    double width = (MediaQuery.of(context).size.width - 48) / 2;
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
                    style: mainTextStyle.copyWith(fontSize: 24),
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
                  isScrollable: true,
                  controller: _tabController,
                ),
              ),
        space(32),
        SliverPadding(
          padding: EdgeInsets.symmetric(horizontal: 24),
          sliver: SliverGrid.count(
            crossAxisCount: 2,
            childAspectRatio: aspect,
            children: _products.map((e) => productItem(e)).toList(),
          ),
        ),
      ],
    );
  }

  Widget brandItem(Brand brand, bool isFirst) {
    return Card(
        elevation: 1,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
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
        ));
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
        padding: EdgeInsets.symmetric(horizontal: 6),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ClipRRect(
                borderRadius: BorderRadius.circular(6),
                child: SizedBox(
                    height: 240,
                    child: Hero(
                        tag: "product${product.id}",
                        child: Image.asset(product.image)))),
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
