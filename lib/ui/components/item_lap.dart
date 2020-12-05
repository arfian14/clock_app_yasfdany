import 'package:ClockApp/data/models/lap.dart';
import 'package:ClockApp/ui/components/flat_card.dart';
import 'package:flutter/material.dart';
import 'package:ClockApp/utils/responsive.dart';
import 'package:ClockApp/utils/themes.dart';
import 'package:ClockApp/utils/widget_helper.dart';
import 'package:intl/intl.dart';

class ItemLap extends StatelessWidget {
  final index;
  final Lap lap;
  final VoidCallback onTap;

  const ItemLap({
    Key key,
    this.index,
    this.lap,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FlatCard(
      borderRadius: BorderRadius.circular(12.w(context)),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          child: Padding(
            padding: EdgeInsets.all(18.w(context)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Lap " + (index + 1).toString(),
                  style: Themes(context).blackBold16,
                ),
                Text(
                  DateFormat("mm:ss").format(
                        DateTime.fromMillisecondsSinceEpoch(
                          lap.lap,
                        ),
                      ) +
                      ":" +
                      ("${lap.lap % 1000}".length == 1 ? "0" : "") +
                      ("${lap.lap % 1000}".length == 3
                          ? "${lap.lap % 1000}".substring(0, 2)
                          : "${lap.lap % 1000}"),
                  style: Themes(context).blackBold16,
                ),
              ],
            ),
          ),
        ),
      ),
    ).addMarginTop(12.h(context));
  }
}
