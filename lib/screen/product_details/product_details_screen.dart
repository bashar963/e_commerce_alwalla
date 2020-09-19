import 'package:e_commerce_alwalla/screen/home/home_tab/home_tab_screen.dart';
import 'package:e_commerce_alwalla/screen/product_details/product_details_bloc.dart';
import 'package:e_commerce_alwalla/theme/app_theme.dart';
import 'package:e_commerce_alwalla/utils/common.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_read_more_text/flutter_read_more_text.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';

class ProductDetailsScreen extends StatefulWidget {
  final Product product;

  const ProductDetailsScreen({Key key, this.product}) : super(key: key);
  @override
  _ProductDetailsScreenState createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  final _productBloc = ProductDetailsBloc();
  bool isFav = false;
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
  @override
  void dispose() {
    _productBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      body: BlocProvider(
        create: (BuildContext context) {
          return _productBloc;
        },
        child: BlocListener(
          cubit: _productBloc,
          listener: (c, ProductDetailsState state) async {
            if (state is Loading) {}
            if (state is Success) {}
            if (state is Failed) {
              showFailedMessage(context, state.error);
            }
          },
          child: BlocBuilder(
              cubit: _productBloc,
              builder: (c, ProductDetailsState state) {
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
                    "1500\$",
                    style:
                        mainTextStyle.copyWith(fontSize: 16, color: redColor),
                  ),
                ],
              ),
            ),
            Expanded(
                child: RaisedButton(
              padding: EdgeInsets.symmetric(vertical: 16, horizontal: 12),
              color: redColor,
              onPressed: () {},
              child: Text(
                "ADD TO CART",
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
            background: Hero(
              tag: widget.product != null ? "product${widget.product.id}" : "p",
              child: Image.asset(
                widget.product != null
                    ? widget.product.image
                    : "assets/images/image_demo.png",
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
        space(32),
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Text(
              "Nike Dri-FIT Long Sleeve",
              style: mainTextStyle.copyWith(fontSize: 24),
            ),
          ),
        ),
        space(24),
        SliverPadding(
          padding: EdgeInsets.symmetric(horizontal: 24),
          sliver: SliverToBoxAdapter(
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 12, horizontal: 12),
                    decoration: BoxDecoration(
                        border: Border.all(color: lightGrey),
                        borderRadius: BorderRadius.circular(24)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Size",
                          style: subTextStyle,
                        ),
                        Text(
                          "XL",
                          style: mainTextStyle.copyWith(fontSize: 14),
                        )
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  width: 24,
                ),
                Expanded(
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 12, horizontal: 12),
                    decoration: BoxDecoration(
                        border: Border.all(color: lightGrey),
                        borderRadius: BorderRadius.circular(24)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Color",
                          style: subTextStyle,
                        ),
                        CircleAvatar(
                          radius: 9,
                          backgroundColor: Color(0xFF33427D),
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
        space(24),
        SliverPadding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          sliver: SliverToBoxAdapter(
            child: Text(
              "Details",
              style: mainTextStyle.copyWith(fontSize: 24),
            ),
          ),
        ),
        SliverPadding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          sliver: SliverToBoxAdapter(
            child: ReadMoreText(
              "Nike Dri-FIT is a polyester fabric designed to help you keep dry so you can more comfortably work harder, longer.",
              expandingButtonColor: redColor,
            ),
          ),
        ),
        space(24),
        SliverPadding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          sliver: SliverToBoxAdapter(
            child: Text(
              "Reviews",
              style: mainTextStyle.copyWith(fontSize: 24),
            ),
          ),
        ),
        SliverToBoxAdapter(
          child: ListView.builder(
            itemBuilder: (c, i) => reviewItem(_reviews[i]),
            itemCount: _reviews.length,
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
          ),
        )
      ],
    );
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
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: backgroundColor,
          child: Center(
            child: Text(
              review.image,
              style: mainTextStyle.copyWith(fontSize: 12),
            ),
          ),
        ),
        title: Text(
          review.name,
          style: mainTextStyle,
        ),
        subtitle: Text(
          review.text,
          style: subTextStyle,
        ),
        trailing: SmoothStarRating(
            allowHalfRating: false,
            onRated: (v) {},
            starCount: 5,
            rating: review.stars.toDouble(),
            size: 12.0,
            isReadOnly: true,
            color: orangeColor,
            borderColor: orangeColor,
            spacing: 0.0),
      ),
    );
  }
}

class Review {
  final String id, name, image, text;
  final int stars;

  Review(this.id, this.name, this.image, this.text, this.stars);
}
