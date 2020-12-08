import 'dart:ui';

import 'package:ClockApp/data/models/alarm.dart';
import 'package:ClockApp/data/providers/alarm_provider.dart';
import 'package:ClockApp/ui/components/ripple_button.dart';
import 'package:ClockApp/ui/components/textarea.dart';
import 'package:ClockApp/utils/responsive.dart';
import 'package:ClockApp/utils/themes.dart';
import 'package:ClockApp/utils/tools.dart';
import 'package:flutter/material.dart';
import 'package:ClockApp/utils/widget_helper.dart';
import 'package:provider/provider.dart';
import 'flutter_time_picker_spinner.dart';

class BottomsheetAddAlarm extends StatefulWidget {
  final Alarm alarm;

  BottomsheetAddAlarm({
    Key key,
    this.alarm,
  }) : super(key: key);

  @override
  _BottomsheetAddAlarmState createState() => _BottomsheetAddAlarmState();
}

class AlarmSound {
  Color color;
  bool selected;
  String title;

  AlarmSound(this.color, this.title, {this.selected = false});
}

class AlarmColor {
  Color color;
  bool selected;

  AlarmColor(this.color, {this.selected = false});
}

class _BottomsheetAddAlarmState extends State<BottomsheetAddAlarm> {
  DateTime dateTime;
  Map loopDay = {
    "sen": true,
    "sel": true,
    "rab": true,
    "kam": true,
    "jum": true,
    "sab": false,
    "min": false,
  };
  List<AlarmColor> colors = [
    AlarmColor(Themes.blue, selected: true),
    AlarmColor(Themes.reddish),
    AlarmColor(Themes.cyan),
    AlarmColor(Themes.orange),
    AlarmColor(Themes.purple),
    AlarmColor(Themes.magenta),
    AlarmColor(Themes.primary),
  ];
  List<AlarmSound> ringtones = [
    AlarmSound(Themes.blue, "Classic", selected: true),
    AlarmSound(Themes.reddish, "Wind"),
    AlarmSound(Themes.cyan, "Ocean"),
    AlarmSound(Themes.orange, "Orange"),
    AlarmSound(Themes.purple, "Grapes"),
    AlarmSound(Themes.magenta, "Koi"),
    AlarmSound(Themes.primary, "River"),
  ];
  TextEditingController titleController = TextEditingController();
  bool enableButton = false;

  void onTextChange() {
    setState(() {
      enableButton = titleController.text.isNotEmpty;
    });
  }

  @override
  void initState() {
    super.initState();
    titleController.addListener(onTextChange);

    if (widget.alarm != null) {
      setState(() {
        dateTime = widget.alarm.time;
        loopDay = widget.alarm.dayLoop;
        for (AlarmColor color in colors) {
          color.selected = false;
        }
        colors[widget.alarm.color].selected = true;
        for (AlarmSound ringtone in ringtones) {
          ringtone.selected = false;
        }
        ringtones[widget.alarm.ringtone].selected = true;
        titleController.text = widget.alarm.title;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        top: 32.h(context),
      ),
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: Material(
        color: Colors.transparent,
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(24.w(context)),
              topRight: Radius.circular(24.w(context)),
            ),
          ),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  RippleButton(
                    padding: EdgeInsets.symmetric(
                      horizontal: 14.w(context),
                      vertical: 12.h(context),
                    ),
                    enableShadow: false,
                    rippleColor: Themes.stroke,
                    onTap: () {
                      Navigator.pop(context);
                    },
                    color: Colors.transparent,
                    child: Text(
                      "Batal",
                      style: Themes(context).primaryBold14,
                    ),
                  ),
                  Text(
                    "Tambah Alarm",
                    style: Themes(context).blackBold16,
                  ),
                  RippleButton(
                    padding: EdgeInsets.symmetric(
                      horizontal: 12.w(context),
                      vertical: 12.h(context),
                    ),
                    enableShadow: false,
                    rippleColor: Themes.stroke,
                    onTap: () {
                      if (enableButton) {
                        Alarm alarm = Alarm(
                          title: titleController.text,
                          color: colors.indexOf(colors
                              .singleWhere((element) => element.selected)),
                          ringtone: ringtones.indexOf(ringtones
                              .singleWhere((element) => element.selected)),
                          dayLoop: loopDay,
                          time: dateTime,
                        );

                        if (widget.alarm != null) {
                          context
                              .read<AlarmProvider>()
                              .replaceAlarm(widget.alarm, alarm);
                        } else {
                          context.read<AlarmProvider>().addAlarm(alarm);
                        }

                        Navigator.pop(context);
                      } else {
                        Tools.showToast(text: "Label harus diisi");
                      }
                    },
                    color: Colors.transparent,
                    child: Text(
                      "Simpan",
                      style: Themes(context).primaryBold14,
                    ),
                  ),
                ],
              ).addAllPadding(14.w(context)),
              Container(
                width: double.infinity,
                height: 1,
                color: Themes.stroke,
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(vertical: 24.h(context)),
                        child: TimePickerSpinner(
                          itemWidth: 56.w(context),
                          normalTextStyle: TextStyle(
                            fontFamily: "NExtraBold",
                            fontSize: 24.f(context),
                            color: Themes.black.withOpacity(0.1),
                          ),
                          highlightedTextStyle: TextStyle(
                            fontFamily: "NExtraBold",
                            fontSize: 32.f(context),
                            color: Themes.black,
                          ),
                          spacing: 50,
                          itemHeight: 80,
                          isForce2Digits: true,
                          time: dateTime,
                          onTimeChange: (time) {
                            setState(() {
                              dateTime = time;
                            });
                          },
                        ),
                      ),
                      Container(
                        width: double.infinity,
                        height: 1,
                        color: Themes.stroke,
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(
                          vertical: 7.h(context),
                          horizontal: 7.w(context),
                        ),
                        child: TextArea(
                          controller: titleController,
                          icon: Icon(
                            Icons.edit_rounded,
                            size: 24.f(context),
                            color: Themes.stroke,
                          ).addMarginRight(12.w(context)),
                          color: Colors.white,
                          hint: "masukkan label",
                        ),
                      ),
                      Container(
                        width: double.infinity,
                        height: 1,
                        color: Themes.stroke,
                      ),
                      Container(
                        padding: EdgeInsets.all(18.w(context)),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Ulangi Alarm",
                              style: Themes(context).blackBold16,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: loopDay.keys.map((e) {
                                return RippleButton(
                                  rippleColor: loopDay[e]
                                      ? Colors.white.withOpacity(0.5)
                                      : Themes.stroke,
                                  padding: EdgeInsets.zero,
                                  radius: 32.w(context),
                                  onTap: () {
                                    setState(() {
                                      loopDay[e] = !loopDay[e];
                                    });
                                  },
                                  color:
                                      loopDay[e] ? Themes.primary : Themes.grey,
                                  child: Container(
                                    width: 34.w(context),
                                    height: 34.w(context),
                                    alignment: Alignment.center,
                                    child: Text(
                                      e,
                                      style: loopDay[e]
                                          ? Themes(context).whiteBold12
                                          : Themes(context).blackBold12,
                                    ),
                                  ),
                                );
                              }).toList(),
                            ).addMarginTop(14.h(context)),
                          ],
                        ),
                      ),
                      Container(
                        width: double.infinity,
                        height: 1,
                        color: Themes.stroke,
                      ),
                      Container(
                        padding: EdgeInsets.all(18.w(context)),
                        alignment: Alignment.centerLeft,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Pilih Warna",
                              style: Themes(context).blackBold16,
                            ),
                            SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                children: colors.map((e) {
                                  return Container(
                                    width: 34.w(context),
                                    height: 34.w(context),
                                    child: RippleButton(
                                      padding: EdgeInsets.zero,
                                      radius: 32.w(context),
                                      onTap: () {
                                        setState(() {
                                          for (AlarmColor alarmColor
                                              in colors) {
                                            alarmColor.selected = false;
                                          }
                                          e.selected = true;
                                        });
                                      },
                                      color: e.color,
                                      child: Container(
                                        child: e.selected
                                            ? Icon(
                                                Icons.check_rounded,
                                                color: Colors.white,
                                                size: 24.f(context),
                                              )
                                            : null,
                                      ),
                                    ),
                                  ).addMarginRight(12.w(context));
                                }).toList(),
                              ),
                            ).addMarginTop(14.h(context)),
                          ],
                        ),
                      ),
                      Container(
                        width: double.infinity,
                        height: 1,
                        color: Themes.stroke,
                      ),
                      Container(
                        alignment: Alignment.centerLeft,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Pilih Ringtone",
                              style: Themes(context).blackBold16,
                            ).addMarginOnly(
                              left: 18.w(context),
                              top: 14.w(context),
                            ),
                            SingleChildScrollView(
                              padding: EdgeInsets.symmetric(
                                horizontal: 18.w(context),
                                vertical: 14.h(context),
                              ),
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                children: ringtones.map((e) {
                                  return Column(
                                    children: [
                                      RippleButton(
                                        border: e.selected
                                            ? Border.all(
                                                color: Themes.black,
                                                width: 2,
                                              )
                                            : null,
                                        padding: EdgeInsets.all(
                                          e.selected
                                              ? 16.w(context)
                                              : 12.w(context),
                                        ),
                                        onTap: () {
                                          setState(() {
                                            for (AlarmSound ringtone
                                                in ringtones) {
                                              ringtone.selected = false;
                                            }
                                            e.selected = true;
                                          });
                                        },
                                        color: e.color,
                                        child: Container(
                                          child: Icon(
                                            Icons.music_note_rounded,
                                            color: Colors.white,
                                            size: 24.f(context),
                                          ),
                                        ),
                                      ),
                                      Text(
                                        e.title,
                                        style: e.selected
                                            ? Themes(context).blackBold14
                                            : Themes(context).black14,
                                      ).addMarginTop(6.h(context)),
                                    ],
                                  ).addMarginRight(18.w(context));
                                }).toList(),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
