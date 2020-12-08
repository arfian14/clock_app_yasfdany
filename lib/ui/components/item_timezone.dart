import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:ClockApp/utils/responsive.dart';
import 'package:ClockApp/utils/themes.dart';
import 'package:ClockApp/utils/widget_helper.dart';
import 'package:intl/intl.dart';
import 'package:timezone/standalone.dart' as tz;
import 'flat_card.dart';

class ItemTimezone extends StatelessWidget {
  final DateTime dateTime;
  final VoidCallback onTap;
  final VoidCallback onLongTap;
  final String timezone;

  const ItemTimezone({
    Key key,
    this.dateTime,
    this.onTap,
    this.onLongTap,
    this.timezone,
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
          onLongPress: onLongTap,
          splashColor: Themes.white.withOpacity(0.3),
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
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          timezone.split("/").last.replaceAll("_", " "),
                          style: Themes(context).whiteBold16,
                        ),
                        Text(
                          DateFormat("dd MMMM", "id").format(
                            tz.TZDateTime.from(
                              dateTime,
                              tz.getLocation(timezone),
                            ),
                          ),
                          style: Themes(context).white14,
                        ),
                      ],
                    ),
                    Text(
                      DateFormat("HH:mm", "id").format(
                        tz.TZDateTime.from(
                          dateTime,
                          tz.getLocation(timezone),
                        ),
                      ),
                      style: Themes(context).white14,
                    )
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
