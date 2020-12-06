import 'dart:math';

import 'package:ClockApp/data/providers/tick_provider.dart';
import 'package:ClockApp/data/providers/timezone_provider.dart';
import 'package:ClockApp/ui/components/animated_gradient_background.dart';
import 'package:ClockApp/ui/components/animated_wave.dart';
import 'package:ClockApp/ui/components/clockview.dart';
import 'package:ClockApp/ui/components/item_timezone.dart';
import 'package:ClockApp/ui/components/options_dialog.dart';
import 'package:ClockApp/ui/components/question_dialog.dart';
import 'package:ClockApp/ui/components/ripple_button.dart';
import 'package:ClockApp/ui/views/timezone/timezone_screen.dart';
import 'package:ClockApp/utils/responsive.dart';
import 'package:ClockApp/utils/themes.dart';
import 'package:ClockApp/utils/tools.dart';
import 'package:ClockApp/utils/widget_helper.dart';
import 'package:animated_background/animated_background.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class ClockPage extends StatefulWidget {
  ClockPage({Key key}) : super(key: key);

  @override
  _ClockPageState createState() => _ClockPageState();
}

class _ClockPageState extends State<ClockPage> with TickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      context.read<TimezoneProvider>().loadTimezones();
    });
  }

  @override
  Widget build(BuildContext context) {
    DateTime dateTime = context.watch<TickProvider>().dateTime;
    List<String> timeZones = context.watch<TimezoneProvider>().timeZones;

    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light,
      ),
    );

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
          Positioned.fill(
            bottom: 0,
            child: Align(
              alignment: Alignment.bottomCenter,
              child: AnimatedWave(
                height: 120,
                speed: 0.9,
                offset: pi,
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
                offset: pi / 2,
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
                          onLongTap: () {
                            showGeneralDialog(
                              transitionBuilder:
                                  (currentContext, a1, a2, widget) {
                                final curvedValue =
                                    Curves.easeInOutBack.transform(a1.value) -
                                        1.0;
                                return Transform(
                                  transform: Matrix4.translationValues(
                                    0.0,
                                    curvedValue * 300,
                                    0.0,
                                  ),
                                  child: Opacity(
                                    opacity: a1.value,
                                    child: OptionsDialog(
                                      options: [
                                        "Edit",
                                        "Hapus",
                                      ],
                                      onOptionSelected: (selected) {
                                        Navigator.pop(context);

                                        switch (selected) {
                                          case "Edit":
                                            Tools.navigatePush(
                                              context,
                                              TimezoneScreen(
                                                timezone: e,
                                              ),
                                            );
                                            break;
                                          case "Hapus":
                                            showGeneralDialog(
                                              transitionBuilder:
                                                  (currentContext, a1, a2,
                                                      widget) {
                                                final curvedValue = Curves
                                                        .easeInOutBack
                                                        .transform(a1.value) -
                                                    1.0;
                                                return Transform(
                                                  transform:
                                                      Matrix4.translationValues(
                                                    0.0,
                                                    curvedValue * 300,
                                                    0.0,
                                                  ),
                                                  child: Opacity(
                                                    opacity: a1.value,
                                                    child: QuestionDialog(
                                                      title: "Hapus Timezone",
                                                      message:
                                                          "Yakin ingin menghapus timezone?",
                                                      onConfirm: () {
                                                        context
                                                            .read<
                                                                TimezoneProvider>()
                                                            .removeTimezone(e);
                                                        Navigator.pop(context);
                                                      },
                                                      onCancel: () {
                                                        Navigator.pop(context);
                                                      },
                                                      positiveText: "Hapus",
                                                      positiveButtonColor:
                                                          Themes.red,
                                                    ),
                                                  ),
                                                );
                                              },
                                              transitionDuration:
                                                  Duration(milliseconds: 200),
                                              barrierDismissible: true,
                                              barrierLabel: '',
                                              context: context,
                                              pageBuilder: (context, animation1,
                                                  animation2) {},
                                            );

                                            break;
                                        }
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
                          },
                        );
                      }).toList(),
                    ),
                    RippleButton(
                      radius: 12.w(context),
                      padding: EdgeInsets.all(22.w(context)),
                      onTap: () {
                        Tools.navigatePush(context, TimezoneScreen());
                      },
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
