import 'package:ClockApp/ui/components/ripple_button.dart';
import 'package:flutter/material.dart';
import 'package:ClockApp/utils/responsive.dart';
import 'package:ClockApp/utils/themes.dart';

class TimerButton extends StatelessWidget {
  final Function(int number) onTapNumber;
  final int number;

  const TimerButton({
    this.number,
    this.onTapNumber,
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 76.w(context),
      height: 76.w(context),
      child: RippleButton(
        enableShadow: false,
        color: Colors.transparent,
        onTap: () {
          onTapNumber(number);
        },
        radius: 42.w(context),
        child: Text(
          "$number",
          style: Themes(context).whiteBold32,
        ),
      ),
    );
  }
}
