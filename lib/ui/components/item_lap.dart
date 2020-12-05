import 'dart:ui';

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
      border: Border.all(
        color: Colors.white.withOpacity(0.5),
      ),
      color: Colors.transparent,
      borderRadius: BorderRadius.circular(12.w(context)),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(12.w(context)),
          onTap: onTap,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(12.w(context)),
            child: BackdropFilter(
              filter: ImageFilter.blur(
                sigmaX: 10.0,
                sigmaY: 10.0,
              ),
              child: Container(
                color: Colors.white.withOpacity(0.1),
                padding: EdgeInsets.all(18.w(context)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Lap " + (index + 1).toString(),
                      style: Themes(context).whiteBold14,
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
                      style: Themes(context).white14,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    ).addMarginTop(12.h(context));
  }
}
