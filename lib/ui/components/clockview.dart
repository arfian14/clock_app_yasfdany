import 'dart:async';
import 'dart:math';
import 'package:ClockApp/data/providers/tick_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ClockView extends StatefulWidget {
  final double size;
  final Color backgroundColor;
  final Color centerDotColor;
  final Color circleDotColor;
  final Color strokeColor;
  final Color dashColor;
  final Color secondNeedleColor;
  final Color minutesNeedleColor;
  final Color hourNeedleColor;

  const ClockView({
    Key key,
    this.size,
    this.backgroundColor,
    this.centerDotColor,
    this.circleDotColor,
    this.strokeColor,
    this.dashColor,
    this.secondNeedleColor,
    this.minutesNeedleColor,
    this.hourNeedleColor,
  }) : super(key: key);

  @override
  _ClockViewState createState() => _ClockViewState();
}

class _ClockViewState extends State<ClockView> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      context.read<TickProvider>().initTicking();
    });
  }

  @override
  Widget build(BuildContext context) {
    DateTime dateTime = context.watch<TickProvider>().dateTime;

    return Align(
      alignment: Alignment.topCenter,
      child: Container(
        width: widget.size,
        height: widget.size,
        child: Transform.rotate(
          angle: -pi / 2,
          child: CustomPaint(
            painter: ClockPainter(
              backgroundColor: widget.backgroundColor,
              centerDotColor: widget.centerDotColor,
              circleDotColor: widget.circleDotColor,
              strokeColor: widget.strokeColor,
              dashColor: widget.dashColor,
              secondNeedleColor: widget.secondNeedleColor,
              minutesNeedleColor: widget.minutesNeedleColor,
              hourNeedleColor: widget.hourNeedleColor,
              dateTime: dateTime,
            ),
          ),
        ),
      ),
    );
  }
}

class ClockPainter extends CustomPainter {
  final Color backgroundColor;
  final Color centerDotColor;
  final Color circleDotColor;
  final Color strokeColor;
  final Color dashColor;
  final Color secondNeedleColor;
  final Color minutesNeedleColor;
  final Color hourNeedleColor;
  final DateTime dateTime;

  ClockPainter({
    Key key,
    this.backgroundColor,
    this.centerDotColor,
    this.circleDotColor,
    this.strokeColor,
    this.dashColor,
    this.secondNeedleColor,
    this.minutesNeedleColor,
    this.hourNeedleColor,
    this.dateTime,
  });

  //60sec - 360, 1 sec - 6degrees
  //60min - 360, 1 min - 6degrees
  //12hours - 360, 1 hour - 30degrees, 60min - 30degrees, 1 min - 0.5degrees

  @override
  void paint(Canvas canvas, Size size) {
    var centerX = size.width / 2;
    var centerY = size.height / 2;
    var center = Offset(centerX, centerY);
    var radius = min(centerX, centerY);

    var fillBrush = Paint()..color = backgroundColor;
    var outlineBrush = Paint()
      ..color = strokeColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = size.width / 32;
    var centerDotBrush = Paint()..color = centerDotColor;
    var circleDotBrush = Paint()..color = circleDotColor;

    var secHandBrush = Paint()
      ..color = secondNeedleColor
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeWidth = size.width / 100;

    var minHandBrush = Paint()
      ..color = minutesNeedleColor
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeWidth = size.width / 100;

    var hourHandBrush = Paint()
      ..color = hourNeedleColor
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeWidth = size.width / 32;

    var dashBrush = Paint()
      ..color = dashColor
      ..style = PaintingStyle.fill
      ..strokeWidth = 1;

    var innerRadius = radius * 0.55;
    for (var i = 0; i < 360; i += 30) {
      var x2 = centerX + innerRadius * cos(i * pi / 180);
      var y2 = centerY + innerRadius * sin(i * pi / 180);
      canvas.drawCircle(Offset(x2, y2), 2, dashBrush);
    }

    canvas.drawCircle(center, radius * 0.75, fillBrush);
    canvas.drawCircle(center, radius * 0.75, outlineBrush);

    var hourHandX = centerX +
        radius *
            0.4 *
            cos((dateTime.hour * 30 + dateTime.minute * 0.5) * pi / 180);
    var hourHandY = centerY +
        radius *
            0.4 *
            sin((dateTime.hour * 30 + dateTime.minute * 0.5) * pi / 180);
    canvas.drawLine(center, Offset(hourHandX, hourHandY), hourHandBrush);

    var minHandX = centerX + radius * 0.6 * cos(dateTime.minute * 6 * pi / 180);
    var minHandY = centerY + radius * 0.6 * sin(dateTime.minute * 6 * pi / 180);
    canvas.drawLine(center, Offset(minHandX, minHandY), minHandBrush);

    var secHandX = centerX + radius * 0.6 * cos(dateTime.second * 6 * pi / 180);
    var secHandY = centerY + radius * 0.6 * sin(dateTime.second * 6 * pi / 180);
    canvas.drawLine(center, Offset(secHandX, secHandY), secHandBrush);

    canvas.drawCircle(center, radius * 0.08, centerDotBrush);
    canvas.drawCircle(center, radius * 0.38, circleDotBrush);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
