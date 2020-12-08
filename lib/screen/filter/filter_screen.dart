import 'package:e_commerce_alwalla/controller/filter_controller.dart';
import 'package:e_commerce_alwalla/theme/app_theme.dart';
import 'package:e_commerce_alwalla/utils/common.dart';
import 'package:flutter/material.dart';
import 'package:flutter_xlider/flutter_xlider.dart';
import 'package:get/get.dart';

class FilterScreen extends StatefulWidget {
  @override
  _FilterScreenState createState() => _FilterScreenState();
}

class _FilterScreenState extends State<FilterScreen> {
  final FilterController _filterController = Get.put(FilterController());

  @override
  void initState() {
    super.initState();
    _filterController.getBrands();
  }

  List<String> _sizes = [
    'x-small',
    'small',
    'medium',
    'large',
    'x-large',
    'xx-large',
    'xxx-large',
  ];
  List<ColorFilter> _colors = [
    ColorFilter('white', Color(0xFFFFFFFF)),
    ColorFilter('black', Color(0xFF000000)),
    ColorFilter('yellow', Color(0xFFFFFF00)),
    ColorFilter('dark blue', Color(0xFF33427D)),
    ColorFilter('orange', Color(0xFFFF7A06)),
    ColorFilter('brown', Color(0xFF7D3333)),
    ColorFilter('dark pink', Color(0xFF7D3378)),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: whiteColor,
        centerTitle: true,
        title: Text("Filter"),
        leading: IconButton(
            icon: Icon(Icons.keyboard_arrow_down),
            onPressed: () {
              Navigator.pop(context);
            }),
      ),
      body: GestureDetector(
          onTap: () {
            hideKeyboard(context);
          },
          child: body(context)),
      bottomNavigationBar: Container(
        padding: EdgeInsets.symmetric(vertical: 24, horizontal: 24),
        color: whiteColor,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Container(
                height: 50,
                child: OutlineButton(
                  highlightedBorderColor: redColor,
                  highlightColor: whiteColor,
                  color: redColor,
                  borderSide: BorderSide(color: redColor),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text(
                    "CANCEL",
                    style: subTextStyle.copyWith(color: blackColor),
                  ),
                ),
              ),
            ),
            const SizedBox(
              width: 16,
            ),
            Expanded(
              child: Container(
                height: 50,
                child: RaisedButton(
                  elevation: 0,
                  color: redColor,
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text(
                    "APPLY",
                    style: subTextStyle.copyWith(color: whiteColor),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  String _size = '';
  double _lowerValue = 50.0;
  double _upperValue = 250.0;
  double _lowerValueFormatter = 20.0;
  double _upperValueFormatter = 20.0;
  List<String> _selectedBrands = [];
  String _selectedColor = '';
  int star = 5;
  Widget body(BuildContext context) {
    return Obx(() {
      var selectedBrands = '';
      _selectedBrands.forEach((element) {
        selectedBrands += '$element ,';
      });

      return ListView(
        physics: BouncingScrollPhysics(),
        children: [
          ExpansionTile(
            title: Text(
              "Brands",
              style: mainTextStyle.copyWith(
                  fontWeight: FontWeight.w400, fontSize: 18),
            ),
            subtitle: Text(
              selectedBrands.isNotEmpty ? selectedBrands : "No Settings",
              style: subTextStyle.copyWith(fontSize: 12),
            ),
            children: [
              Wrap(
                alignment: WrapAlignment.spaceEvenly,
                spacing: 16,
                children: _filterController.brands.map((element) {
                  return FilterChip(
                    label: Text(element.label),
                    onSelected: (s) {
                      if (!_selectedBrands.contains(element.label)) {
                        _selectedBrands.add(element.label);
                      } else {
                        _selectedBrands.remove(element.label);
                      }
                      setState(() {});
                    },
                    backgroundColor: whiteColor,
                    elevation: 0.6,
                  );
                }).toList(),
              ),
              const SizedBox(
                height: 12,
              )
            ],
          ),
          ExpansionTile(
            title: Text(
              "Price",
              style: mainTextStyle.copyWith(
                  fontWeight: FontWeight.w400, fontSize: 18),
            ),
            subtitle: Text(
              "$_lowerValue - $_upperValue EGP",
              style: subTextStyle.copyWith(fontSize: 12),
            ),
            children: [
              const SizedBox(
                height: 48,
              ),
              FlutterSlider(
                min: 10.0,
                max: 500.0,
                rangeSlider: true,
                tooltip: FlutterSliderTooltip(
                    format: (String value) {
                      return value + ' EGP ';
                    },
                    alwaysShowTooltip: true,
                    positionOffset:
                        FlutterSliderTooltipPositionOffset(top: -20),
                    textStyle: TextStyle(fontSize: 12, color: Colors.white),
                    boxStyle: FlutterSliderTooltipBox(
                        decoration: BoxDecoration(
                            color: redColor,
                            borderRadius: BorderRadius.circular(4)))),
                trackBar: FlutterSliderTrackBar(
                  inactiveTrackBar: BoxDecoration(
                    borderRadius: BorderRadius.circular(6),
                    color: Color(0xFFBDC4CC).withOpacity(0.14),
                  ),
                  activeTrackBar: BoxDecoration(
                    borderRadius: BorderRadius.circular(4),
                    color: Color(0xFFBDC4CC).withOpacity(0.14),
                  ),
                ),
                rightHandler: FlutterSliderHandler(
                  decoration: BoxDecoration(
                      color: whiteColor,
                      border: Border.all(color: redColor, width: 1),
                      borderRadius: BorderRadius.circular(28)),
                  child: Padding(
                    padding: const EdgeInsets.all(6.0),
                    child: Material(
                        type: MaterialType.canvas,
                        color: redColor,
                        shape: CircleBorder(),
                        elevation: 3,
                        child: Container(
                          decoration: BoxDecoration(
                              color: redColor,
                              borderRadius: BorderRadius.circular(28)),
                        )),
                  ),
                ),
                handler: FlutterSliderHandler(
                  decoration: BoxDecoration(
                      color: whiteColor,
                      border: Border.all(color: redColor, width: 1),
                      borderRadius: BorderRadius.circular(28)),
                  child: Padding(
                    padding: const EdgeInsets.all(6.0),
                    child: Material(
                        type: MaterialType.canvas,
                        color: redColor,
                        shape: CircleBorder(),
                        elevation: 3,
                        child: Container(
                          decoration: BoxDecoration(
                              color: redColor,
                              borderRadius: BorderRadius.circular(28)),
                        )),
                  ),
                ),
                values: [_lowerValue, _upperValue],
                onDragging: (handlerIndex, lowerValue, upperValue) {
                  setState(() {
                    _lowerValue = lowerValue;
                    _upperValue = upperValue;
                  });
                },
              ),
              const SizedBox(
                height: 24,
              )
            ],
          ),
          ExpansionTile(
            title: Text(
              "Color",
              style: mainTextStyle.copyWith(
                  fontWeight: FontWeight.w400, fontSize: 18),
            ),
            subtitle: Text(
              _selectedColor.isNotEmpty ? _selectedColor : "No Settings",
              style: subTextStyle.copyWith(fontSize: 12),
            ),
            children: [
              Wrap(
                alignment: WrapAlignment.center,
                spacing: 24,
                runSpacing: 2,
                children: _colors.map((e) {
                  return InkWell(
                    onTap: () {
                      setState(() {
                        _selectedColor = e.name;
                      });
                    },
                    child: Container(
                      width: 35,
                      height: 35,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: e.color),
                    ),
                  );
                }).toList(),
              ),
              const SizedBox(
                height: 12,
              )
            ],
          ),
          ExpansionTile(
            title: Text(
              "Size",
              style: mainTextStyle.copyWith(
                  fontWeight: FontWeight.w400, fontSize: 18),
            ),
            subtitle: Text(
              _size.isEmpty ? 'No Settings' : "$_size",
              style: subTextStyle.copyWith(fontSize: 12),
            ),
            children: [
              Wrap(
                alignment: WrapAlignment.spaceEvenly,
                spacing: 16,
                children: _sizes.map((e) {
                  return ActionChip(
                    label: Text(e),
                    backgroundColor: whiteColor,
                    elevation: 0.6,
                    onPressed: () {
                      setState(() {
                        _size = e;
                      });
                    },
                  );
                }).toList(),
              ),
              const SizedBox(
                height: 12,
              )
            ],
          ),
          ExpansionTile(
            title: Text(
              "Rating",
              style: mainTextStyle.copyWith(
                  fontWeight: FontWeight.w400, fontSize: 18),
            ),
            subtitle: Text(
              "$star Star",
              style: subTextStyle.copyWith(fontSize: 12),
            ),
            children: [
              Wrap(
                alignment: WrapAlignment.spaceEvenly,
                spacing: 16,
                children: [
                  ActionChip(
                    label: Text("1"),
                    backgroundColor: whiteColor,
                    elevation: 0.6,
                    onPressed: () {
                      setState(() {
                        star = 1;
                      });
                    },
                  ),
                  ActionChip(
                    label: Text("2"),
                    backgroundColor: whiteColor,
                    elevation: 0.6,
                    onPressed: () {
                      setState(() {
                        star = 2;
                      });
                    },
                  ),
                  ActionChip(
                    label: Text("3"),
                    backgroundColor: whiteColor,
                    elevation: 0.6,
                    onPressed: () {
                      setState(() {
                        star = 3;
                      });
                    },
                  ),
                  ActionChip(
                    label: Text("4"),
                    backgroundColor: whiteColor,
                    elevation: 0.6,
                    onPressed: () {
                      setState(() {
                        star = 4;
                      });
                    },
                  ),
                  ActionChip(
                    label: Text("5"),
                    backgroundColor: whiteColor,
                    elevation: 0.6,
                    onPressed: () {
                      setState(() {
                        star = 5;
                      });
                    },
                  ),
                ],
              ),
              const SizedBox(
                height: 12,
              )
            ],
          ),
          ExpansionTile(
            title: Text(
              "Seller",
              style: mainTextStyle.copyWith(
                  fontWeight: FontWeight.w400, fontSize: 18),
            ),
            subtitle: Text(
              "No Settings",
              style: subTextStyle.copyWith(fontSize: 12),
            ),
            children: [
              Wrap(
                alignment: WrapAlignment.spaceEvenly,
                spacing: 16,
                children: [
                  Chip(
                    label: Text("data 1"),
                    backgroundColor: whiteColor,
                    elevation: 0.6,
                  ),
                  Chip(
                    label: Text("data 2"),
                    backgroundColor: whiteColor,
                    elevation: 0.6,
                  ),
                  Chip(
                    label: Text("data 3"),
                    backgroundColor: whiteColor,
                    elevation: 0.6,
                  ),
                  Chip(
                    label: Text("data 4"),
                    backgroundColor: whiteColor,
                    elevation: 0.6,
                  ),
                ],
              ),
              const SizedBox(
                height: 12,
              )
            ],
          )
        ],
      );
    });
  }
}

class ColorFilter {
  final String name;
  final Color color;

  ColorFilter(this.name, this.color);
}
