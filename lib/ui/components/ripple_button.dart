import 'package:ClockApp/utils/responsive.dart';
import 'package:ClockApp/utils/themes.dart';
import 'package:flutter/material.dart';

class RippleButton extends StatelessWidget {
  String text;
  VoidCallback onTap;
  Color rippleColor;
  Color color;
  Color textColor;
  Widget child;
  EdgeInsets padding;
  Border border;
  double radius;
  bool enableShadow;

  RippleButton({
    Key key,
    this.text,
    this.onTap,
    this.color,
    this.rippleColor,
    this.textColor,
    this.child,
    this.padding,
    this.border,
    this.enableShadow = true,
    this.radius,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (rippleColor == null) rippleColor = Colors.white.withOpacity(0.5);
    if (color == null) color = Themes.primary;
    if (textColor == null) textColor = Colors.white;
    if (padding == null) padding = EdgeInsets.all(16.w(context));

    return AnimatedContainer(
      duration: Duration(milliseconds: 100),
      decoration: BoxDecoration(
        border: border,
        color: onTap != null ? color : Themes.stroke,
        borderRadius:
            BorderRadius.circular(radius != null ? radius : 6.w(context)),
        boxShadow: onTap != null
            ? [
                if (enableShadow)
                  BoxShadow(
                    color: color.withOpacity(0.5),
                    offset: Offset(0, 4),
                    blurRadius: 12,
                  )
              ]
            : [],
      ),
      child: ClipRRect(
        borderRadius:
            BorderRadius.circular(radius != null ? radius : 6.w(context)),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            highlightColor: rippleColor.withOpacity(0.2),
            splashColor: rippleColor,
            onTap: onTap,
            child: Padding(
              padding: padding,
              child: Center(
                child: child != null
                    ? child
                    : Text(
                        text,
                        style: Themes(context).white14.apply(
                              color: onTap != null
                                  ? textColor
                                  : Themes.black.withOpacity(0.6),
                            ),
                      ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
