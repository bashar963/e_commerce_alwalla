import 'package:e_commerce_alwalla/theme/app_theme.dart';
import 'package:flutter/material.dart';

class MyStepper extends StatefulWidget {
  final int selectedIndex;

  const MyStepper({Key key, this.selectedIndex}) : super(key: key);
  @override
  _MyStepperState createState() => _MyStepperState();
}

class _MyStepperState extends State<MyStepper> {
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

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(
              height: 16,
            ),
            widget.selectedIndex == 0
                ? step(true, selectedIcon())
                : step(true, doneSelectedIcon()),
            SizedBox(
              height: 12,
            ),
            Text("Delivery")
          ],
        ),
        Expanded(
            child: Divider(
          color:
              widget.selectedIndex > 0 ? redColor : blackColor.withOpacity(0.1),
          thickness: 2,
        )),
        Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(
              height: 16,
            ),
            widget.selectedIndex == 1
                ? step(true, selectedIcon())
                : widget.selectedIndex > 1
                    ? step(true, doneSelectedIcon())
                    : step(false, notSelectedIcon()),
            SizedBox(
              height: 12,
            ),
            Text("Address")
          ],
        ),
        Expanded(
            child: Divider(
          color:
              widget.selectedIndex > 1 ? redColor : blackColor.withOpacity(0.1),
          thickness: 2,
        )),
        Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(
              height: 16,
            ),
            widget.selectedIndex == 2
                ? step(true, selectedIcon())
                : step(false, notSelectedIcon()),
            SizedBox(
              height: 12,
            ),
            Text("Payment")
          ],
        ),
      ],
    );
  }
}
