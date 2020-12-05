import 'package:ClockApp/data/providers/tick_provider.dart';
import 'package:ClockApp/ui/components/clockview.dart';
import 'package:ClockApp/ui/components/flat_card.dart';
import 'package:ClockApp/ui/components/item_timezone.dart';
import 'package:ClockApp/ui/components/ripple_button.dart';
import 'package:ClockApp/utils/responsive.dart';
import 'package:ClockApp/utils/themes.dart';
import 'package:ClockApp/utils/widget_helper.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:timezone/standalone.dart' as tz;

class ClockPage extends StatefulWidget {
  ClockPage({Key key}) : super(key: key);

  @override
  _ClockPageState createState() => _ClockPageState();
}

class _ClockPageState extends State<ClockPage> {
  List<String> timeZones = [
    "Asia/Jakarta",
    "Asia/Pontianak",
    "Asia/Makassar",
    "Asia/Jayapura",
  ];

  void setTimezones() async {
    await SharedPreferences.getInstance().then((prefs) {
      prefs.setStringList("timezones", timeZones);
    });
  }

  void loadTimezones() async {
    await SharedPreferences.getInstance().then((prefs) {
      var prefTimezones = prefs.getStringList("timezones");
      if (prefTimezones != null) {
        if (prefTimezones.isNotEmpty) {
          timeZones.clear();
          timeZones.addAll(prefTimezones);
          setState(() {});
        }
      }
    });
  }

  @override
  void initState() {
    super.initState();
    loadTimezones();
  }

  @override
  Widget build(BuildContext context) {
    DateTime dateTime = context.watch<TickProvider>().dateTime;
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Themes.primary,
                  Themes.lightPrimary,
                ],
              ),
            ),
          ),
          SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 24.w(context)),
            child: Column(
              children: [
                ClockView(
                  size: 60.wp(context),
                  backgroundColor: Themes.transparent,
                  centerDotColor: Themes.white,
                  circleDotColor: Themes.white.withOpacity(0.2),
                  dashColor: Themes.white,
                  strokeColor: Themes.white,
                  secondNeedleColor: Themes.red,
                  minutesNeedleColor: Themes.white,
                  hourNeedleColor: Themes.white,
                ).addMarginTop(12.hp(context)),
                Text(
                  DateFormat('HH:mm').format(dateTime),
                  style: Themes(context).whiteBold22,
                ),
                Text(
                  DateFormat('dd MMMM yyyy').format(dateTime),
                  style: Themes(context).white14,
                ),
                Column(
                  children: [
                    Column(
                      children: timeZones.map((e) {
                        return ItemTimezone(
                          dateTime: dateTime,
                          timezone: e,
                          onTap: () {},
                        );
                      }).toList(),
                    ),
                    RippleButton(
                      radius: 12.w(context),
                      padding: EdgeInsets.all(22.w(context)),
                      onTap: () {},
                      border: Border.all(
                        color: Colors.white,
                        width: 2,
                      ),
                      enableShadow: false,
                      color: Colors.transparent,
                      child: Center(
                        child: Icon(
                          Icons.add_rounded,
                          color: Colors.white,
                          size: 24.f(context),
                        ),
                      ),
                    ).addMarginTop(12.h(context)),
                  ],
                ).addMarginOnly(
                  top: 24.h(context),
                  bottom: 24.h(context),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
