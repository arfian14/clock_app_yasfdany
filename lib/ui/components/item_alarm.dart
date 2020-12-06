import 'dart:math';

import 'package:ClockApp/data/models/alarm.dart';
import 'package:ClockApp/data/providers/alarm_provider.dart';
import 'package:ClockApp/ui/components/animated_wave.dart';
import 'package:ClockApp/ui/components/bottomsheet_add_alarm.dart';
import 'package:ClockApp/ui/components/flat_card.dart';
import 'package:ClockApp/utils/responsive.dart';
import 'package:ClockApp/utils/themes.dart';
import 'package:animated_background/animated_background.dart';
import 'package:flutter/material.dart';
import 'package:ClockApp/utils/widget_helper.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class ItemAlarm extends StatefulWidget {
  final Alarm alarm;
  final VoidCallback onTap;
  final VoidCallback onLongTap;
  final Function(bool value) onSwitch;

  ItemAlarm({
    Key key,
    this.alarm,
    this.onTap,
    this.onLongTap,
    this.onSwitch,
  }) : super(key: key);

  @override
  _ItemAlarmState createState() => _ItemAlarmState();
}

class _ItemAlarmState extends State<ItemAlarm> with TickerProviderStateMixin {
  final List<AlarmColor> colors = [
    AlarmColor(Themes.blue, selected: true),
    AlarmColor(Themes.reddish),
    AlarmColor(Themes.cyan),
    AlarmColor(Themes.orange),
    AlarmColor(Themes.purple),
    AlarmColor(Themes.magenta),
    AlarmColor(Themes.primary),
  ];

  final List<AlarmSound> ringtones = [
    AlarmSound(Themes.blue, "Classic", selected: true),
    AlarmSound(Themes.reddish, "Wind"),
    AlarmSound(Themes.cyan, "Ocean"),
    AlarmSound(Themes.orange, "Orange"),
    AlarmSound(Themes.purple, "Grapes"),
    AlarmSound(Themes.magenta, "Koi"),
    AlarmSound(Themes.primary, "River"),
  ];

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: widget.alarm.active ? 1 : 0.5,
      child: FlatCard(
        borderRadius: BorderRadius.circular(12.w(context)),
        color: colors[widget.alarm.color].color,
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onLongPress: widget.onLongTap,
            onTap: widget.onTap,
            child: Stack(
              children: [
                Positioned.fill(
                  child: AnimatedBackground(
                    behaviour: RandomParticleBehaviour(
                      options: ParticleOptions(
                        baseColor: Colors.white,
                        particleCount: 10,
                        spawnMaxSpeed: 100,
                        spawnMinSpeed: 10,
                        minOpacity: 0.1,
                        maxOpacity: 0.2,
                      ),
                    ),
                    vsync: this,
                    child: Container(),
                  ),
                ),
                Positioned.fill(
                  bottom: 0,
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: AnimatedWave(
                      height: 120,
                      speed: 0.9,
                      offset: pi * widget.alarm.color,
                    ),
                  ),
                ),
                Positioned.fill(
                  bottom: 0,
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: AnimatedWave(
                      height: 220,
                      speed: 1.2,
                      offset: pi / 2 * widget.alarm.color,
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(18.w(context)),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.alarm.title,
                              style: Themes(context).whiteBold14,
                            ),
                            Text(
                              DateFormat("HH:mm").format(widget.alarm.time),
                              style: Themes(context).whiteBold32,
                            ),
                            Wrap(
                              children: widget.alarm.dayLoop.keys
                                  .where((key) => widget.alarm.dayLoop[key])
                                  .map((e) {
                                return Text(
                                  e.substring(0, 1).toUpperCase() +
                                      e.substring(1),
                                  style: Themes(context).whiteBold14,
                                ).addMarginRight(12.w(context));
                              }).toList(),
                            )
                                .addMarginTop(6.h(context))
                                .addMarginRight(36.w(context)),
                          ],
                        ),
                      ),
                      Switch(
                        activeTrackColor: Colors.white.withOpacity(0.3),
                        activeColor: Colors.white,
                        value: widget.alarm.active,
                        onChanged: widget.onSwitch,
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ).addMarginBottom(12.h(context)),
    );
  }
}
