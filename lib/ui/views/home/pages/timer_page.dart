import 'dart:ui';

import 'package:ClockApp/data/models/lap.dart';
import 'package:ClockApp/data/providers/tick_timer_provider.dart';
import 'package:ClockApp/ui/components/flat_card.dart';
import 'package:ClockApp/ui/components/item_lap.dart';
import 'package:ClockApp/ui/components/ripple_button.dart';
import 'package:ClockApp/utils/responsive.dart';
import 'package:ClockApp/utils/themes.dart';
import 'package:ClockApp/utils/widget_helper.dart';
import 'package:animated_background/animated_background.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class TimePage extends StatefulWidget {
  TimePage({Key key}) : super(key: key);

  @override
  _TimePageState createState() => _TimePageState();
}

class _TimePageState extends State<TimePage> with TickerProviderStateMixin {
  ScrollController scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    int tick = context.watch<TickTimerProvider>().tick;
    bool isTicking = context.watch<TickTimerProvider>().isTicking;
    List<Lap> laps = context.watch<TickTimerProvider>().laps;
    GlobalKey<AnimatedListState> listKey =
        context.watch<TickTimerProvider>().listKey;

    int milisecond = tick % 1000;
    int second = (tick ~/ 1000) % 60;
    int minutes = (tick ~/ 1000) ~/ 60;

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
            controller: scrollController,
            padding: EdgeInsets.all(24.w(context)),
            child: Container(
              margin: EdgeInsets.only(
                bottom: laps.isNotEmpty ? 24.hp(context) : 0,
              ),
              width: double.infinity,
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Column(
                        children: [
                          Text(
                            ("$minutes".length == 1 ? "0$minutes" : "$minutes"),
                            style: TextStyle(
                              fontFamily: "NExtraBold",
                              fontSize: 56.f(context),
                              color: Colors.white,
                            ),
                          ),
                          Text(
                            "minutes",
                            style: Themes(context).whiteBold14,
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          Text(
                            ("$second".length == 1 ? "0$second" : "$second"),
                            style: TextStyle(
                              fontFamily: "NExtraBold",
                              fontSize: 56.f(context),
                              color: Colors.white,
                            ),
                          ),
                          Text(
                            "second",
                            style: Themes(context).whiteBold14,
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          Text(
                            ("$milisecond".length == 1 ? "0" : "") +
                                ("$milisecond".length == 3
                                    ? "$milisecond".substring(0, 2)
                                    : "$milisecond"),
                            style: TextStyle(
                              fontFamily: "NExtraBold",
                              fontSize: 56.f(context),
                              color: Colors.white,
                            ),
                          ),
                          Text(
                            "milisecond",
                            style: Themes(context).whiteBold14,
                          ),
                        ],
                      )
                    ],
                  ).addMarginTop(32.hp(context)),
                  AnimatedList(
                    key: listKey,
                    reverse: true,
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    initialItemCount: laps.length,
                    itemBuilder: (context, index, animation) {
                      return laps.isNotEmpty
                          ? SizeTransition(
                              axisAlignment: 1.0,
                              sizeFactor: animation,
                              child: ItemLap(
                                index: index,
                                lap: laps[index],
                                onTap: () {},
                              ),
                            )
                          : Container();
                    },
                  ).addMarginOnly(
                    top: 24.h(context),
                    left: 24.w(context),
                    right: 24.w(context),
                    bottom: 32.h(context),
                  ),
                ],
              ),
            ),
          ).addMarginBottom(102.h(context)),
          IgnorePointer(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  width: double.infinity,
                  height: 25.hp(context),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Themes.lightPrimary.withOpacity(0),
                        Themes.lightPrimary.withOpacity(0.9),
                        Themes.lightPrimary.withOpacity(1),
                        Themes.lightPrimary,
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          AnimatedBackground(
            behaviour: RandomParticleBehaviour(
              options: ParticleOptions(
                baseColor: Colors.white,
                particleCount: 20,
                spawnMaxSpeed: 100,
                spawnMinSpeed: 10,
                minOpacity: 0.1,
                maxOpacity: 0.2,
              ),
            ),
            vsync: this,
            child: Container(),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: 24.wp(context),
                    child: RippleButton(
                      onTap: () async {
                        await scrollController
                            .animateTo(
                          scrollController.offset - 138.h(context),
                          duration: Duration(milliseconds: 300),
                          curve: Curves.easeIn,
                        )
                            .then((value) {
                          context.read<TickTimerProvider>().resetTimer();
                        });
                      },
                      border: Border.all(
                        width: 2,
                        color: Colors.white,
                      ),
                      radius: 32.w(context),
                      padding: EdgeInsets.all(12),
                      enableShadow: false,
                      color: Colors.transparent,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Reset",
                            style: Themes(context).whiteBold14,
                          ).addMarginOnly(
                            left: 6.w(context),
                            right: 6.w(context),
                          )
                        ],
                      ),
                    ),
                  ),
                  RippleButton(
                    onTap: () {
                      if (isTicking) {
                        context.read<TickTimerProvider>().pauseTicking();
                      } else {
                        context.read<TickTimerProvider>().initTicking();
                      }
                    },
                    radius: 32.w(context),
                    border: Border.all(
                      width: 2,
                      color: Colors.white,
                    ),
                    padding: EdgeInsets.all(12),
                    enableShadow: false,
                    color: Colors.transparent,
                    child: Row(
                      children: [
                        Icon(
                          isTicking
                              ? Icons.pause_rounded
                              : Icons.play_arrow_rounded,
                          size: 32.f(context),
                          color: Colors.white,
                        ),
                        if (isTicking)
                          Text(
                            "Pause",
                            style: Themes(context).whiteBold14,
                          ).addMarginOnly(
                            left: 6.w(context),
                            right: 6.w(context),
                          )
                      ],
                    ),
                  ),
                  Container(
                    width: 24.wp(context),
                    child: RippleButton(
                      onTap: () async {
                        context.read<TickTimerProvider>().addLap();
                        if (laps.length == 1) {
                          await scrollController.animateTo(
                            scrollController.offset + 138.h(context),
                            duration: Duration(milliseconds: 300),
                            curve: Curves.easeIn,
                          );
                        }
                      },
                      border: Border.all(
                        width: 2,
                        color: Colors.white,
                      ),
                      radius: 32.w(context),
                      padding: EdgeInsets.all(12),
                      enableShadow: false,
                      color: Colors.transparent,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Lap",
                            style: Themes(context).whiteBold14,
                          ).addMarginOnly(
                            left: 6.w(context),
                            right: 6.w(context),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ).addAllPadding(24.w(context))
        ],
      ),
    );
  }
}
