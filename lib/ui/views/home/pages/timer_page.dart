import 'package:ClockApp/data/providers/tick_timer_provider.dart';
import 'package:ClockApp/ui/components/animated_gradient_background.dart';
import 'package:ClockApp/ui/components/ripple_button.dart';
import 'package:ClockApp/ui/components/timer_button.dart';
import 'package:ClockApp/utils/responsive.dart';
import 'package:ClockApp/utils/themes.dart';
import 'package:ClockApp/utils/widget_helper.dart';
import 'package:animated_background/animated_background.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TimerPage extends StatefulWidget {
  TimerPage({Key key}) : super(key: key);

  @override
  _TimerPageState createState() => _TimerPageState();
}

class _TimerPageState extends State<TimerPage> with TickerProviderStateMixin {
  PageController pageController = PageController();
  final List<int> timer = [];
  int index = 0;

  void onNumberTap(int number) {
    setState(() {
      if (timer.length < 6) {
        if (number == 0) {
          if (timer.isNotEmpty) timer.add(number);
        } else {
          timer.add(number);
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    int curretTimer = context.watch<TickTimerProvider>().timer -
        context.watch<TickTimerProvider>().tick;

    int second = Duration(milliseconds: curretTimer).inSeconds % 60;
    int minutes = Duration(milliseconds: curretTimer).inMinutes % 60;
    int hour = Duration(milliseconds: curretTimer).inHours;

    if (pageController.hasClients) {
      if (context.watch<TickTimerProvider>().isTicking) {
        if (pageController.page == 0) {
          pageController.animateToPage(
            1,
            duration: Duration(milliseconds: 300),
            curve: Curves.easeInOut,
          );
        }
      } else {
        if (pageController.page == 1) {
          timer.clear();
          pageController.animateToPage(
            0,
            duration: Duration(milliseconds: 300),
            curve: Curves.easeInOut,
          );
        }
      }
    }

    return Scaffold(
      body: Stack(
        children: [
          AnimatedGradientBackground(),
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
          PageView(
            controller: pageController,
            scrollDirection: Axis.vertical,
            physics: NeverScrollableScrollPhysics(),
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "${timer.length > 5 ? timer[timer.length - 6] : 0}",
                        style: TextStyle(
                          fontFamily: "NExtraBold",
                          fontSize: 48.f(context),
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        "${timer.length > 4 ? timer[timer.length - 5] : 0}",
                        style: TextStyle(
                          fontFamily: "NExtraBold",
                          fontSize: 48.f(context),
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        "j",
                        style: Themes(context).whiteBold16,
                      ).addMarginTop(12.h(context)),
                      Text(
                        "${timer.length > 3 ? timer[timer.length - 4] : 0}",
                        style: TextStyle(
                          fontFamily: "NExtraBold",
                          fontSize: 48.f(context),
                          color: Colors.white,
                        ),
                      ).addMarginLeft(6.w(context)),
                      Text(
                        "${timer.length > 2 ? timer[timer.length - 3] : 0}",
                        style: TextStyle(
                          fontFamily: "NExtraBold",
                          fontSize: 48.f(context),
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        "m",
                        style: Themes(context).whiteBold16,
                      ).addMarginTop(12.h(context)),
                      Text(
                        "${timer.length > 1 ? timer[timer.length - 2] : 0}",
                        style: TextStyle(
                          fontFamily: "NExtraBold",
                          fontSize: 48.f(context),
                          color: Colors.white,
                        ),
                      ).addMarginLeft(6.w(context)),
                      Text(
                        "${timer.length > 0 ? timer[timer.length - 1] : 0}",
                        style: TextStyle(
                          fontFamily: "NExtraBold",
                          fontSize: 48.f(context),
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        "d",
                        style: Themes(context).whiteBold16,
                      ).addMarginTop(12.h(context)),
                      RippleButton(
                        enableShadow: false,
                        // border: Border.all(color: Colors.white),
                        color: Colors.transparent,
                        onTap: () {
                          setState(() {
                            if (timer.isNotEmpty) timer.removeLast();
                          });
                        },
                        padding: EdgeInsets.all(12.w(context)),
                        radius: 32.w(context),
                        child: Icon(
                          Icons.backspace_rounded,
                          color: Colors.white,
                          size: 24.f(context),
                        ),
                      ).addMarginLeft(6.w(context)),
                    ],
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 12.h(context)),
                    width: double.infinity,
                    height: 1,
                    color: Colors.white,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TimerButton(
                        number: 1,
                        onTapNumber: onNumberTap,
                      ),
                      TimerButton(
                        number: 2,
                        onTapNumber: onNumberTap,
                      ),
                      TimerButton(
                        number: 3,
                        onTapNumber: onNumberTap,
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TimerButton(
                        number: 4,
                        onTapNumber: onNumberTap,
                      ),
                      TimerButton(
                        number: 5,
                        onTapNumber: onNumberTap,
                      ),
                      TimerButton(
                        number: 6,
                        onTapNumber: onNumberTap,
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TimerButton(
                        number: 7,
                        onTapNumber: onNumberTap,
                      ),
                      TimerButton(
                        number: 8,
                        onTapNumber: onNumberTap,
                      ),
                      TimerButton(
                        number: 9,
                        onTapNumber: onNumberTap,
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TimerButton(
                        number: 0,
                        onTapNumber: onNumberTap,
                      ),
                    ],
                  ),
                  AnimatedOpacity(
                    duration: Duration(milliseconds: 100),
                    opacity: timer.isNotEmpty ? 1 : 0,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        RippleButton(
                          onTap: () {
                            var genTimer = [];
                            genTimer.addAll(timer);

                            for (int i = 0; i < 6 - timer.length; i++) {
                              genTimer.insert(0, 0);
                            }

                            print(genTimer);

                            int hour =
                                int.parse("${genTimer[0]}${genTimer[1]}");
                            int minute =
                                int.parse("${genTimer[2]}${genTimer[3]}");
                            int second =
                                int.parse("${genTimer[4]}${genTimer[5]}");

                            print(Duration(hours: hour).inMilliseconds +
                                Duration(minutes: minute).inMilliseconds +
                                Duration(seconds: second).inMilliseconds);

                            context.read<TickTimerProvider>().setTimer(
                                  Duration(hours: hour).inMilliseconds +
                                      Duration(minutes: minute).inMilliseconds +
                                      Duration(seconds: second).inMilliseconds,
                                );
                            context.read<TickTimerProvider>().initTicking();
                            pageController.animateToPage(
                              0,
                              duration: Duration(milliseconds: 300),
                              curve: Curves.easeInOut,
                            );
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
                                Icons.play_arrow_rounded,
                                size: 32.f(context),
                                color: Colors.white,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ).addMarginTop(24.h(context)),
                  ),
                ],
              ).addAllPadding(36.w(context)),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Stack(
                    children: [
                      Align(
                        alignment: Alignment.center,
                        child: SizedBox(
                          width: 50.wp(context),
                          height: 50.wp(context),
                          child: CircularProgressIndicator(
                            value: (1 *
                                        (curretTimer.toDouble() /
                                            context
                                                .watch<TickTimerProvider>()
                                                .timer))
                                    .isNaN
                                ? 0
                                : (1 *
                                    (curretTimer.toDouble() /
                                        context
                                            .watch<TickTimerProvider>()
                                            .timer)),
                            valueColor:
                                AlwaysStoppedAnimation<Color>(Themes.white),
                            backgroundColor: Colors.white.withOpacity(0.5),
                          ),
                        ),
                      ),
                      Positioned.fill(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Column(
                                  children: [
                                    Text(
                                      ("$hour".length == 1
                                          ? "0$hour"
                                          : "$hour"),
                                      style: TextStyle(
                                        fontFamily: "NExtraBold",
                                        fontSize: 24.f(context),
                                        color: Colors.white,
                                      ),
                                    ),
                                    Text(
                                      "jam",
                                      style: Themes(context).whiteBold14,
                                    ),
                                  ],
                                ),
                                Column(
                                  children: [
                                    Text(
                                      ("$minutes".length == 1
                                          ? "0$minutes"
                                          : "$minutes"),
                                      style: TextStyle(
                                        fontFamily: "NExtraBold",
                                        fontSize: 24.f(context),
                                        color: Colors.white,
                                      ),
                                    ),
                                    Text(
                                      "menit",
                                      style: Themes(context).whiteBold14,
                                    ),
                                  ],
                                ).addSymmetricMargin(horizontal: 12.w(context)),
                                Column(
                                  children: [
                                    Text(
                                      ("$second".length == 1
                                          ? "0$second"
                                          : "$second"),
                                      style: TextStyle(
                                        fontFamily: "NExtraBold",
                                        fontSize: 24.f(context),
                                        color: Colors.white,
                                      ),
                                    ),
                                    Text(
                                      "detik",
                                      style: Themes(context).whiteBold14,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      RippleButton(
                        onTap: () {
                          timer.clear();
                          context.read<TickTimerProvider>().resetTimer();
                          pageController.animateToPage(
                            0,
                            duration: Duration(milliseconds: 300),
                            curve: Curves.easeInOut,
                          );
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
                              Icons.stop_rounded,
                              size: 32.f(context),
                              color: Colors.white,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ).addMarginTop(56.h(context))
                ],
              ).addAllPadding(36.w(context)),
            ],
          )
        ],
      ),
    );
  }
}
