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
  final String timezone;

  const ItemTimezone({
    Key key,
    this.dateTime,
    this.onTap,
    this.timezone,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FlatCard(
      borderRadius: BorderRadius.circular(12.w(context)),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {},
          child: Padding(
            padding: EdgeInsets.all(18.w(context)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      timezone.split("/").last,
                      style: Themes(context).blackBold18,
                    ),
                    Text(
                      DateFormat("dd MMMM").format(
                        tz.TZDateTime.from(
                          dateTime,
                          tz.getLocation(timezone),
                        ),
                      ),
                      style: Themes(context).black14,
                    ),
                  ],
                ),
                Text(
                  DateFormat("HH:mm").format(
                    tz.TZDateTime.from(
                      dateTime,
                      tz.getLocation(timezone),
                    ),
                  ),
                  style: Themes(context).black14,
                )
              ],
            ),
          ),
        ),
      ),
    ).addMarginTop(12.h(context));
  }
}
