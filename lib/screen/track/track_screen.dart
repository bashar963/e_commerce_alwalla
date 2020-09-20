import 'package:e_commerce_alwalla/screen/order_history/orders_history_screen.dart';
import 'package:e_commerce_alwalla/screen/track/track_bloc.dart';
import 'package:e_commerce_alwalla/theme/app_theme.dart';
import 'package:e_commerce_alwalla/utils/common.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TrackOrderScreen extends StatefulWidget {
  final Order order;

  const TrackOrderScreen({Key key, this.order}) : super(key: key);
  @override
  _TrackOrderScreenState createState() => _TrackOrderScreenState();
}

class _TrackOrderScreenState extends State<TrackOrderScreen> {
  final _trackBloc = TrackBloc();

  List<Track> _tracker = [
    Track("1", "20/18\n10:00 AM", "Order Signed", "2"),
    Track("2", "20/18\n10:00 AM", "Order Processed", "2"),
    Track("3", "20/18\n10:00 AM", "Shipped", "3"),
    Track("4", "20/18\n10:00 AM", "Out for delivery", "1"),
    Track("5", "20/18\n10:00 AM", "Delivered", "1"),
  ];
  @override
  void dispose() {
    _trackBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text(widget.order.title),
        centerTitle: true,
        brightness: Brightness.light,
      ),
      body: BlocProvider(
        create: (BuildContext context) {
          return _trackBloc;
        },
        child: BlocListener(
          cubit: _trackBloc,
          listener: (c, TrackState state) async {
            if (state is Loading) {}
            if (state is Success) {}
            if (state is Failed) {
              showFailedMessage(context, state.error);
            }
          },
          child: BlocBuilder(
              cubit: _trackBloc,
              builder: (c, TrackState state) {
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
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
            width: 100,
            child: Text(
              tracker.date,
              style: subTextStyle.copyWith(fontSize: 18),
            )),
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
        Container(
            width: 150,
            child: Text(
              tracker.title,
              style: mainTextStyle,
            ))
      ],
    );
  }
}

class Track {
  final String id, date, title, status;

  Track(this.id, this.date, this.title, this.status);
}
