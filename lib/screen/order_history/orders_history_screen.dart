import 'package:e_commerce_alwalla/screen/order_history/orders_bloc.dart';
import 'package:e_commerce_alwalla/screen/track/track_screen.dart';
import 'package:e_commerce_alwalla/theme/app_theme.dart';
import 'package:e_commerce_alwalla/utils/common.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OrdersHistory extends StatefulWidget {
  @override
  _OrdersHistoryState createState() => _OrdersHistoryState();
}

class _OrdersHistoryState extends State<OrdersHistory> {
  final _ordersBloc = OrdersBloc();

  List<OrderSort> _orders = [
    OrderSort([
      Order("1", "12/09/2020", "OD - 424923192 - N", "4500", "1", [
        "assets/images/image.png",
        "assets/images/image_2.png",
        "assets/images/image_demo.png",
        "assets/images/image.png",
        "assets/images/image.png"
      ])
    ], "18/09/2020"),
    OrderSort([
      Order("1", "18/09/2020", "OD - 424923192 - N", "4500", "2", [
        "assets/images/image.png",
        "assets/images/image_2.png",
        "assets/images/image_demo.png",
        "assets/images/image.png",
        "assets/images/image.png"
      ]),
      Order("1", "18/09/2020", "OD - 424923192 - N", "4500", "2", [
        "assets/images/image.png",
        "assets/images/image_2.png",
        "assets/images/image_demo.png",
        "assets/images/image.png",
        "assets/images/image.png"
      ]),
    ], "12/09/2020")
  ];
  @override
  void dispose() {
    _ordersBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text("Orders"),
        centerTitle: true,
        brightness: Brightness.light,
      ),
      body: BlocProvider(
        create: (BuildContext context) {
          return _ordersBloc;
        },
        child: BlocListener(
          cubit: _ordersBloc,
          listener: (c, OrdersState state) async {
            if (state is Loading) {}
            if (state is Success) {}
            if (state is Failed) {
              showFailedMessage(context, state.error);
            }
          },
          child: BlocBuilder(
              cubit: _ordersBloc,
              builder: (c, OrdersState state) {
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
    return ListView.builder(
      physics: BouncingScrollPhysics(),
      itemBuilder: (c, i) => orderItem(_orders[i]),
      itemCount: _orders.length,
      shrinkWrap: true,
    );
  }

  Widget orderItem(OrderSort order) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(
          height: 24,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Text(
            order.date,
            style: mainTextStyle.copyWith(color: subTextColor),
          ),
        ),
        ListView.builder(
          itemBuilder: (c, i) => orderCard(order.orders[i]),
          itemCount: order.orders.length,
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
        )
      ],
    );
  }

  Widget orderCard(Order order) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (c) => TrackOrderScreen(
                      order: order,
                    )));
      },
      child: Card(
        margin: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    order.title,
                    style: mainTextStyle,
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  Text(
                    order.total + " \$",
                    style: mainTextStyle.copyWith(color: redColor),
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  Container(
                    width: 80,
                    height: 30,
                    decoration: BoxDecoration(
                        color: order.status == "1" ? orangeColor : redColor,
                        borderRadius: BorderRadius.circular(6)),
                    child: Center(
                      child: Text(
                        order.status == "1" ? "In Transit" : "Delivered",
                        style: mainTextStyle.copyWith(
                            color: whiteColor, fontSize: 14),
                      ),
                    ),
                  )
                ],
              ),
              const SizedBox(
                width: 16,
              ),
              Container(
                width: 124,
                child: Wrap(
                  spacing: 12,
                  runSpacing: 12,
                  children: [0, 1, 2, 3].map((e) {
                    if (e == 3) {
                      return Container(
                        width: 50,
                        height: 50,
                        child: Center(
                          child: Text(
                            "+" + (order.images.length - 3).toString(),
                            style: mainTextStyle,
                          ),
                        ),
                        decoration: BoxDecoration(
                            color: whiteColor,
                            border: Border.all(
                                width: 2, color: blackColor.withOpacity(0.3)),
                            borderRadius: BorderRadius.circular(6)),
                      );
                    } else {
                      return ClipRRect(
                        borderRadius: BorderRadius.circular(6),
                        child: Image.asset(
                          order.images[e],
                          fit: BoxFit.cover,
                          width: 50,
                          height: 50,
                        ),
                      );
                    }
                  }).toList(),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class OrderSort {
  final List<Order> orders;
  final String date;

  OrderSort(this.orders, this.date);
}

class Order {
  final String id, date, title, total, status;
  final List<String> images;

  Order(this.id, this.date, this.title, this.total, this.status, this.images);
}
