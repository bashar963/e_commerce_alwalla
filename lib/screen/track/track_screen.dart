import 'package:e_commerce_alwalla/screen/order_history/orders_history_screen.dart';
import 'package:e_commerce_alwalla/theme/app_theme.dart';
import 'package:e_commerce_alwalla/utils/common.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TrackOrderScreen extends StatefulWidget {
  final Order order;

  const TrackOrderScreen({Key key, this.order}) : super(key: key);
  @override
  _TrackOrderScreenState createState() => _TrackOrderScreenState();
}

class _TrackOrderScreenState extends State<TrackOrderScreen> {
  List<Track> _tracker = [
    Track("1", "20/18\n10:00 AM", "Order Signed", "2"),
    Track("2", "20/18\n10:00 AM", "Order Processed", "2"),
    Track("3", "20/18\n10:00 AM", "Shipped", "3"),
    Track("4", "20/18\n10:00 AM", "Out for delivery", "1"),
    Track("5", "20/18\n10:00 AM", "Delivered", "1"),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        backgroundColor: whiteColor,
        elevation: 0,
        title: Text(widget.order.title),
        centerTitle: true,
        brightness: Brightness.light,
      ),
      body: GestureDetector(
          onTap: () {
            hideKeyboard(context);
          },
          child: body(context)),
    );
  }

  Widget body(BuildContext context) {
    return Column(
      children: [
        const SizedBox(
          height: 32,
        ),
        ListView.builder(
          physics: BouncingScrollPhysics(),
          itemBuilder: (c, i) =>
              stepItem(_tracker[i], i == _tracker.length - 1),
          itemCount: _tracker.length,
          shrinkWrap: true,
        ),
        const SizedBox(
          height: 32,
        ),
      ],
    );
  }

  BoxDecoration selectedIcon() {
    return BoxDecoration(
        border: Border.all(color: redColor, width: 2),
        borderRadius: BorderRadius.circular(19));
  }

  BoxDecoration doneSelectedIcon() {
    return BoxDecoration(
        border: Border.all(color: blackColor.withOpacity(0.1), width: 2),
        borderRadius: BorderRadius.circular(19));
  }

  Widget step(bool hasChild, BoxDecoration boxDecoration) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 500),
      width: 38,
      height: 38,
      decoration: boxDecoration,
      child: hasChild
          ? Padding(
              padding: const EdgeInsets.all(6.0),
              child: CircleAvatar(
                backgroundColor: redColor,
              ),
            )
          : const SizedBox.shrink(),
    );
  }

  BoxDecoration notSelectedIcon() {
    return BoxDecoration(
        border: Border.all(color: blackColor.withOpacity(0.1), width: 2),
        borderRadius: BorderRadius.circular(19));
  }

  Widget stepItem(Track tracker, isLast) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            tracker.date,
            style: subTextStyle.copyWith(
                fontSize: 12, fontWeight: FontWeight.w400),
          ),
          const SizedBox(
            width: 30,
          ),
          Column(
            children: [
              step(
                  tracker.status != "1",
                  tracker.status == "1"
                      ? notSelectedIcon()
                      : tracker.status == "2"
                          ? doneSelectedIcon()
                          : selectedIcon()),
              isLast
                  ? const SizedBox.shrink()
                  : Container(
                      height: 100,
                      child: VerticalDivider(
                        color: tracker.status == "2"
                            ? redColor
                            : blackColor.withOpacity(0.1),
                        thickness: 2,
                      ))
            ],
          ),
          const SizedBox(
            width: 40,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                tracker.title,
                style: mainTextStyle.copyWith(
                    fontWeight: FontWeight.w400, fontSize: 18),
              ),
              const SizedBox(
                height: 8,
              ),
              Text(
                "Lagos State, Nigeria",
                style: mainTextStyle.copyWith(
                    fontWeight: FontWeight.w400, fontSize: 12),
              ),
            ],
          )
        ],
      ),
    );
  }
}

class Track {
  final String id, date, title, status;

  Track(this.id, this.date, this.title, this.status);
}
