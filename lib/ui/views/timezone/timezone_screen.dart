import 'package:ClockApp/data/providers/timezone_provider.dart';
import 'package:ClockApp/ui/components/custom_alert_dialog.dart';
import 'package:ClockApp/ui/components/flat_card.dart';
import 'package:ClockApp/ui/components/textarea.dart';
import 'package:ClockApp/utils/responsive.dart';
import 'package:ClockApp/utils/themes.dart';
import 'package:ClockApp/utils/widget_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:timezone/standalone.dart' as tz;
import 'package:provider/provider.dart';

class TimezoneScreen extends StatefulWidget {
  final timezone;

  TimezoneScreen({
    Key key,
    this.timezone,
  }) : super(key: key);

  @override
  _TimezoneScreenState createState() => _TimezoneScreenState();
}

class _TimezoneScreenState extends State<TimezoneScreen> {
  List<tz.Location> timezones = [];
  List<tz.Location> filteredTimezones = [];
  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    for (String key in tz.timeZoneDatabase.locations.keys) {
      timezones.add(tz.timeZoneDatabase.locations[key]);
      filteredTimezones.add(tz.timeZoneDatabase.locations[key]);
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    List<String> currentTimezone = context.watch<TimezoneProvider>().timeZones;

    return Container(
      color: Colors.white,
      child: Scaffold(
        backgroundColor: Themes.black.withOpacity(0.96),
        appBar: AppBar(
          brightness: Brightness.dark,
          iconTheme: IconThemeData(
            color: Colors.white.withOpacity(0.7),
          ),
          elevation: 1,
          backgroundColor: Themes.black,
          titleSpacing: 0,
          title: TextArea(
            controller: searchController,
            hint: "Cari wilayah disini",
            textColor: Colors.white.withOpacity(0.8),
            color: Colors.transparent,
            onChangedText: (text) {
              filteredTimezones.clear();
              filteredTimezones.addAll(timezones.where((element) => element.name
                  .trim()
                  .toLowerCase()
                  .contains(text.trim().toLowerCase())));
              setState(() {});
            },
          ),
        ),
        body: ListView.builder(
          padding: EdgeInsets.only(
            left: 14.w(context),
            right: 14.w(context),
            bottom: 14.h(context),
          ),
          itemCount: filteredTimezones.length,
          itemBuilder: (context, index) {
            tz.Location timezone = filteredTimezones[index];

            return FlatCard(
              borderRadius: BorderRadius.circular(8.w(context)),
              border: Border.all(
                color: Themes.black,
                width: 1,
              ),
              color: Themes.black.withOpacity(0.6),
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  borderRadius: BorderRadius.circular(8.w(context)),
                  onTap: () {
                    if (!currentTimezone.contains(timezone.name)) {
                      if (widget.timezone != null) {
                        context
                            .read<TimezoneProvider>()
                            .replaceTimezone(widget.timezone, timezone.name);
                      } else {
                        context
                            .read<TimezoneProvider>()
                            .addTimezone(timezone.name);
                      }

                      Navigator.pop(context);
                    } else {
                      showGeneralDialog(
                        transitionBuilder: (currentContext, a1, a2, widget) {
                          final curvedValue =
                              Curves.easeInOutBack.transform(a1.value) - 1.0;
                          return Transform(
                            transform: Matrix4.translationValues(
                              0.0,
                              curvedValue * 300,
                              0.0,
                            ),
                            child: Opacity(
                              opacity: a1.value,
                              child: CustomAlertDialog(
                                title: "Terjadi Kesalahan",
                                message: "Timezone sudah ada",
                                buttonText: "Ok",
                                onConfirm: () {
                                  Navigator.pop(context);
                                },
                              ),
                            ),
                          );
                        },
                        transitionDuration: Duration(milliseconds: 200),
                        barrierDismissible: true,
                        barrierLabel: '',
                        context: context,
                        pageBuilder: (context, animation1, animation2) {},
                      );
                    }
                  },
                  child: Padding(
                    padding: EdgeInsets.all(14.w(context)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          timezone.name.replaceAll("/", ", "),
                          style: Themes(context)
                              .whiteBold14
                              .apply(color: Colors.white.withOpacity(0.6)),
                        ),
                        Text(
                          timezone.currentTimeZone.abbr,
                          style: Themes(context)
                              .white14
                              .apply(color: Colors.white.withOpacity(0.6)),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ).addMarginOnly(
              top: 14.h(context),
            );
          },
        ),
      ),
    );
  }
}
