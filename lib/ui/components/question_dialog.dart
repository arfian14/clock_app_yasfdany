import 'dart:ui';

import 'package:ClockApp/ui/components/ripple_button.dart';
import 'package:ClockApp/utils/responsive.dart';
import 'package:ClockApp/utils/themes.dart';
import 'package:ClockApp/utils/widget_helper.dart';
import 'package:flutter/material.dart';

class QuestionDialog extends StatelessWidget {
  final String title;
  final String message;
  final VoidCallback onConfirm;
  final VoidCallback onCancel;
  final String positiveText;
  final String negativeText;
  final Color positiveButtonColor;
  final Color negativeButtonColor;

  QuestionDialog({
    Key key,
    this.title,
    this.message,
    this.onConfirm,
    this.onCancel,
    this.positiveText = "Hapus",
    this.negativeText = "Batalkan",
    this.positiveButtonColor,
    this.negativeButtonColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Material(
        color: Colors.transparent,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(12.w(context)),
          child: BackdropFilter(
            filter: ImageFilter.blur(
              sigmaX: 10.0,
              sigmaY: 10.0,
            ),
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.white.withOpacity(0.5),
                ),
                color: Colors.white.withOpacity(0.05),
                borderRadius: BorderRadius.circular(12.w(context)),
              ),
              padding: EdgeInsets.all(24.w(context)),
              width: MediaQuery.of(context).size.width * 0.8,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  if (title != null)
                    Text(title, style: Themes(context).whiteBold16),
                  Container(
                    margin: EdgeInsets.only(top: 6.h(context)),
                    child: Text(message, style: Themes(context).white14),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 24.h(context)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        RippleButton(
                          padding: EdgeInsets.symmetric(
                            horizontal: 16.w(context),
                            vertical: 12.h(context),
                          ),
                          color: positiveButtonColor == null
                              ? Themes.red
                              : positiveButtonColor,
                          text: positiveText,
                          onTap: onConfirm,
                        ),
                        Container(
                          margin: EdgeInsets.only(left: 12.w(context)),
                          child: RippleButton(
                            enableShadow: false,
                            padding: EdgeInsets.symmetric(
                              horizontal: 16.w(context),
                              vertical: 12.h(context),
                            ),
                            rippleColor: Themes.black.withOpacity(0.1),
                            textColor: Themes.black,
                            color: negativeButtonColor == null
                                ? Themes.white
                                : negativeButtonColor,
                            text: negativeText,
                            onTap: onCancel,
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
