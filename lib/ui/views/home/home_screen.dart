import 'package:ClockApp/data/providers/tick_provider.dart';
import 'package:ClockApp/ui/components/clockview.dart';
import 'package:ClockApp/ui/views/home/pages/alarm_page.dart';
import 'package:ClockApp/ui/views/home/pages/clock_page.dart';
import 'package:ClockApp/ui/views/home/pages/stopwatch_page.dart';
import 'package:ClockApp/utils/responsive.dart';
import 'package:ClockApp/utils/themes.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class Homescreen extends StatefulWidget {
  Homescreen({Key key}) : super(key: key);

  @override
  _HomescreenState createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen> {
  int page = 0;
  PageController pageController = PageController();

  @override
  void initState() {
    super.initState();
    initializeDateFormatting();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: pageController,
        onPageChanged: (index) {
          SystemChrome.setSystemUIOverlayStyle(
            SystemUiOverlayStyle(
              statusBarColor: Colors.transparent,
              statusBarIconBrightness: (index == 0 || index == 1)
                  ? Brightness.light
                  : Brightness.dark,
            ),
          );

          page = index;
          setState(() {});
        },
        children: [
          ClockPage(),
          StopwatchPage(),
          AlarmPage(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Themes.primary,
        unselectedItemColor: Themes.black.withOpacity(0.3),
        onTap: (index) {
          pageController.animateToPage(index,
              duration: Duration(milliseconds: 200), curve: Curves.easeInOut);
        },
        selectedLabelStyle: Themes(context).primaryBold12,
        unselectedLabelStyle: Themes(context).black12,
        currentIndex: page,
        items: [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.access_time_rounded,
              size: 24.f(context),
            ),
            label: "Jam",
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.timer_rounded,
              size: 24.f(context),
            ),
            label: "Stopwatch",
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.alarm_rounded,
              size: 24.f(context),
            ),
            label: "Alarm",
          )
        ],
      ),
    );
  }
}
