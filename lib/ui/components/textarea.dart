import 'package:ClockApp/utils/responsive.dart';
import 'package:ClockApp/utils/themes.dart';
import 'package:ClockApp/utils/widget_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'flat_card.dart';

class TextArea extends StatefulWidget {
  final String hint;
  final Widget icon;
  final TextEditingController controller;
  final TextInputAction textInputAction;
  final TextInputType inputType;
  final List<TextInputFormatter> inputFormatter;
  final bool secureInput;
  final int maxLenght;
  final int maxLine;
  final Function(String value) onChangedText;
  final Function(String value) onSubmitText;
  final double width;
  final double height;
  final TextCapitalization textCapitalization;
  final MainAxisAlignment mainAxisAlignment;
  final Color color;
  final Color textColor;
  final bool enable;
  final bool error;
  final String errorMessage;
  final bool autoFocus;
  final TextAlign textAlign;

  TextArea({
    Key key,
    this.hint,
    this.icon,
    this.controller,
    this.inputType,
    this.secureInput = false,
    this.inputFormatter,
    this.maxLenght,
    this.maxLine = 1,
    this.onChangedText,
    this.width,
    this.height,
    this.onSubmitText,
    this.textInputAction,
    this.textCapitalization = TextCapitalization.none,
    this.mainAxisAlignment = MainAxisAlignment.center,
    this.color,
    this.textColor,
    this.enable = true,
    this.error = false,
    this.autoFocus = false,
    this.errorMessage = "",
    this.textAlign = TextAlign.start,
  }) : super(key: key);

  @override
  _TextAreaState createState() => _TextAreaState();
}

class _TextAreaState extends State<TextArea> {
  @override
  Widget build(BuildContext context) {
    return FlatCard(
      color: widget.color,
      width: widget.width,
      height: widget.height,
      child: Padding(
        padding: EdgeInsets.only(
          left: 12.w(context),
          right: 12.w(context),
          top: 12.h(context),
          bottom: 12.h(context),
        ),
        child: Row(
          children: <Widget>[
            widget.icon != null ? widget.icon : Container(),
            Flexible(
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: widget.mainAxisAlignment,
                children: <Widget>[
                  TextField(
                    textAlign: widget.textAlign,
                    autofocus: widget.autoFocus,
                    enabled: widget.enable,
                    minLines: 1,
                    maxLines: widget.maxLine,
                    textCapitalization: widget.textCapitalization,
                    textInputAction: widget.textInputAction,
                    onSubmitted: (value) {
                      if (widget.onSubmitText != null) {
                        widget.onSubmitText(value);
                      }
                    },
                    onChanged: (value) {
                      if (widget.onChangedText != null) {
                        widget.onChangedText(value);
                      }
                    },
                    obscureText: widget.secureInput,
                    controller: widget.controller,
                    keyboardType: widget.inputType,
                    style: Themes(context).black14.apply(
                        color: widget.textColor != null
                            ? widget.textColor
                            : Themes.black),
                    inputFormatters: widget.inputFormatter,
                    maxLength: widget.maxLenght,
                    cursorColor: Themes.primary,
                    decoration: InputDecoration.collapsed(
                      hintText: widget.hint,
                      hintStyle: Themes(context).black14.apply(
                            color: widget.textColor != null
                                ? widget.textColor.withOpacity(0.5)
                                : Themes.black.withOpacity(0.5),
                          ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
