import 'package:ClockApp/data/providers/alarm_provider.dart';
import 'package:ClockApp/data/providers/tick_provider.dart';
import 'package:ClockApp/data/providers/timezone_provider.dart';
import 'package:ClockApp/ui/views/home/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:timezone/data/latest.dart' as tz;

import 'data/providers/tick_stopwatch_provider.dart';
import 'data/providers/tick_timer_provider.dart';

void main() {
  tz.initializeTimeZones();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => TickProvider()),
        ChangeNotifierProvider(create: (_) => TickStopwatchProvider()),
        ChangeNotifierProvider(create: (_) => TimezoneProvider()),
        ChangeNotifierProvider(create: (_) => AlarmProvider()),
        ChangeNotifierProvider(create: (_) => TickTimerProvider()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light,
      ),
    );

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Clock App',
      theme: ThemeData(
        primarySwatch: MaterialColor(
          0xff39C6E4,
          const <int, Color>{
            50: const Color(0xff39C6E4),
            100: const Color(0xff39C6E4),
            200: const Color(0xff39C6E4),
            300: const Color(0xff39C6E4),
            400: const Color(0xff39C6E4),
            500: const Color(0xff39C6E4),
            600: const Color(0xff39C6E4),
            700: const Color(0xff39C6E4),
            800: const Color(0xff39C6E4),
            900: const Color(0xff39C6E4),
          },
        ),
        visualDensity: VisualDensity.adaptivePlatformDensity,
        pageTransitionsTheme: PageTransitionsTheme(builders: {
          TargetPlatform.android: OpenUpwardsPageTransitionsBuilder(),
        }),
      ),
      home: Homescreen(),
    );
  }
}
