import 'package:e_commerce_alwalla/screen/filter/filter_bloc.dart';
import 'package:e_commerce_alwalla/theme/app_theme.dart';
import 'package:e_commerce_alwalla/utils/common.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FilterScreen extends StatefulWidget {
  @override
  _FilterScreenState createState() => _FilterScreenState();
}

class _FilterScreenState extends State<FilterScreen> {
  final _filterBloc = FilterBloc();

  @override
  void dispose() {
    _filterBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: whiteColor,
        title: Text("Filter"),
        leading: IconButton(
            icon: Icon(Icons.keyboard_arrow_down),
            onPressed: () {
              Navigator.pop(context);
            }),
      ),
      body: BlocProvider(
        create: (BuildContext context) {
          return _filterBloc;
        },
        child: BlocListener(
          cubit: _filterBloc,
          listener: (c, FilterState state) async {
            if (state is Loading) {}
            if (state is Success) {}
            if (state is Failed) {
              showFailedMessage(context, state.error);
            }
          },
          child: BlocBuilder(
              cubit: _filterBloc,
              builder: (c, FilterState state) {
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
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: OutlineButton(
                padding: EdgeInsets.symmetric(vertical: 12, horizontal: 12),
                color: redColor,
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text(
                  "CANCEL",
                  style: subTextStyle.copyWith(color: redColor),
                ),
              ),
            ),
            const SizedBox(
              width: 16,
            ),
            Expanded(
              child: RaisedButton(
                padding: EdgeInsets.symmetric(vertical: 12, horizontal: 12),
                color: redColor,
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text(
                  "APPLY",
                  style: subTextStyle.copyWith(color: whiteColor),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget body(BuildContext context) {
    return ListView(
      physics: BouncingScrollPhysics(),
      children: [
        ExpansionTile(
          title: Text(
            "Popularity",
            style: mainTextStyle,
          ),
          subtitle: Text(
            "No Settings",
            style: subTextStyle,
          ),
        ),
        ExpansionTile(
          title: Text(
            "Brands",
            style: mainTextStyle,
          ),
          subtitle: Text(
            "Apple, Samsung, Huawei ,B&o",
            style: subTextStyle,
          ),
        ),
        ExpansionTile(
          title: Text(
            "Price",
            style: mainTextStyle,
          ),
          subtitle: Text(
            "30 - 120",
            style: subTextStyle,
          ),
        ),
        ExpansionTile(
          title: Text(
            "Color",
            style: mainTextStyle,
          ),
          subtitle: Text(
            "No Settings",
            style: subTextStyle,
          ),
        ),
        ExpansionTile(
          title: Text(
            "Rating",
            style: mainTextStyle,
          ),
          subtitle: Text(
            "4 Star",
            style: subTextStyle,
          ),
        ),
        ExpansionTile(
          title: Text(
            "Shipping From",
            style: mainTextStyle,
          ),
          subtitle: Text(
            "No Settings",
            style: subTextStyle,
          ),
        )
      ],
    );
  }
}

// class Filter {
//   final String id;
// }
