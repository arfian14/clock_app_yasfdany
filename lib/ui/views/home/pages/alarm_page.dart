import 'package:ClockApp/data/models/alarm.dart';
import 'package:ClockApp/data/providers/alarm_provider.dart';
import 'package:ClockApp/ui/components/bottomsheet_add_alarm.dart';
import 'package:ClockApp/ui/components/flat_card.dart';
import 'package:ClockApp/ui/components/item_alarm.dart';
import 'package:ClockApp/ui/components/question_dialog.dart';
import 'package:ClockApp/ui/components/ripple_button.dart';
import 'package:ClockApp/utils/responsive.dart';
import 'package:ClockApp/utils/themes.dart';
import 'package:flutter/material.dart';
import 'package:ClockApp/utils/widget_helper.dart';
import 'package:provider/provider.dart';

class AlarmPage extends StatefulWidget {
  AlarmPage({Key key}) : super(key: key);

  @override
  _AlarmPageState createState() => _AlarmPageState();
}

class _AlarmPageState extends State<AlarmPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      context.read<AlarmProvider>().loadAlarms();
    });
  }

  @override
  Widget build(BuildContext context) {
    List<Alarm> alarms = context.watch<AlarmProvider>().alarms;

    return Scaffold(
      backgroundColor: Themes.greyBg,
      appBar: AppBar(
        toolbarHeight: 68.h(context),
        elevation: 1,
        backgroundColor: Colors.white,
        title: Text(
          "Alarm",
          style: Themes(context).blackBold18,
        ),
      ),
      body: ListView(
        padding: EdgeInsets.all(14.w(context)),
        children: [
          ListView.builder(
            padding: EdgeInsets.zero,
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            primary: true,
            itemCount: alarms.length,
            itemBuilder: (context, index) {
              Alarm alarm = alarms[index];

              return ItemAlarm(
                onTap: () {
                  showModalBottomSheet(
                    enableDrag: false,
                    isScrollControlled: true,
                    backgroundColor: Colors.transparent,
                    context: context,
                    builder: (context) {
                      return BottomsheetAddAlarm(
                        alarm: alarm,
                      );
                    },
                  );
                },
                onLongTap: () {
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
                          child: QuestionDialog(
                            title: "Hapus Alarm",
                            message: "Yakin ingin menghapus alarm?",
                            onConfirm: () {
                              context.read<AlarmProvider>().removeAlarm(alarm);
                              Navigator.pop(context);
                            },
                            onCancel: () {
                              Navigator.pop(context);
                            },
                            positiveText: "Hapus",
                            positiveButtonColor: Themes.red,
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
                onSwitch: (value) {
                  context
                      .read<AlarmProvider>()
                      .switchAlarm(alarm, !alarm.active);
                },
                alarm: alarm,
              );
            },
          ),
          RippleButton(
            radius: 12.w(context),
            padding: EdgeInsets.all(22.w(context)),
            onTap: () {
              showModalBottomSheet(
                enableDrag: false,
                isScrollControlled: true,
                backgroundColor: Colors.transparent,
                context: context,
                builder: (context) {
                  return BottomsheetAddAlarm();
                },
              );
            },
            rippleColor: Themes.stroke,
            border: Border.all(
              color: Themes.stroke,
              width: 2,
            ),
            enableShadow: false,
            color: Colors.transparent,
            child: Center(
              child: Icon(
                Icons.add_rounded,
                color: Themes.stroke,
                size: 24.f(context),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
