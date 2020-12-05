import 'package:ClockApp/ui/components/ripple_button.dart';
import 'package:ClockApp/utils/responsive.dart';
import 'package:ClockApp/utils/themes.dart';
import 'package:ClockApp/utils/widget_helper.dart';
import 'package:flutter/material.dart';

class CustomAlertDialog extends StatelessWidget {
  CustomAlertDialog({
    Key key,
    this.title,
    this.message,
    this.onConfirm,
    this.buttonText = "Hapus",
  }) : super(key: key);

  final String title;
  final String message;
  final VoidCallback onConfirm;
  final String buttonText;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Material(
        color: Colors.transparent,
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12.w(context)),
          ),
          padding: EdgeInsets.all(24.w(context)),
          width: MediaQuery.of(context).size.width * 0.8,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text(title, style: Themes(context).blackBold16),
              Container(
                margin: EdgeInsets.only(top: 6.h(context)),
                child: Text(message, style: Themes(context).black14),
              ),
              Container(
                margin: EdgeInsets.only(top: 24.h(context)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    RippleButton(
                      padding: EdgeInsets.symmetric(
                        horizontal: 24.w(context),
                        vertical: 12.h(context),
                      ),
                      text: buttonText,
                      onTap: onConfirm,
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
