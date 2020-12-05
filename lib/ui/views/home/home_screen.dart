import 'package:ClockApp/data/providers/tick_provider.dart';
import 'package:ClockApp/ui/components/clockview.dart';
import 'package:ClockApp/ui/views/home/pages/alarm_page.dart';
import 'package:ClockApp/ui/views/home/pages/clock_page.dart';
import 'package:ClockApp/ui/views/home/pages/timer_page.dart';
import 'package:ClockApp/utils/responsive.dart';
import 'package:ClockApp/utils/themes.dart';
import 'package:flutter/material.dart';
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
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: pageController,
        onPageChanged: (index) {
          page = index;
          setState(() {});
        },
        children: [
          ClockPage(),
          TimePage(),
          AlarmPage(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        onTap: (index) {
          pageController.animateToPage(index,
              duration: Duration(milliseconds: 200), curve: Curves.easeInOut);
        },
        selectedLabelStyle: Themes(context).primaryBold14,
        unselectedLabelStyle: Themes(context).black14,
        currentIndex: page,
        items: [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.access_time_rounded,
              size: 28.f(context),
            ),
            label: "Jam",
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.timer_rounded,
              size: 28.f(context),
            ),
            label: "Timer",
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.alarm_rounded,
              size: 28.f(context),
            ),
            label: "Alarm",
          )
        ],
      ),
    );
  }
}
