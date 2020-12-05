import 'package:ClockApp/utils/themes.dart';
import 'package:flutter/material.dart';
import 'package:simple_animations/simple_animations.dart';

class AnimatedBackground extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final tween = MultiTrackTween([
      Track("color1").add(Duration(seconds: 3),
          ColorTween(begin: Themes.primary, end: Themes.lightPrimary)),
      Track("color2").add(Duration(seconds: 3),
          ColorTween(begin: Themes.lightPrimary, end: Color(0xff4593EF)))
    ]);

    return ControlledAnimation(
      playback: Playback.MIRROR,
      tween: tween,
      duration: tween.duration,
      builder: (context, animation) {
        return Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [animation["color1"], animation["color2"]],
            ),
          ),
        );
      },
    );
  }
}
