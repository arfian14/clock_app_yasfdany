import 'dart:ui';

import 'package:ClockApp/ui/components/flat_card.dart';
import 'package:ClockApp/ui/components/ripple_button.dart';
import 'package:ClockApp/utils/responsive.dart';
import 'package:ClockApp/utils/themes.dart';
import 'package:flutter/material.dart';

class OptionsDialog extends StatelessWidget {
  final List<String> options;
  final Function(String value) onOptionSelected;

  OptionsDialog({
    Key key,
    this.options,
    this.onOptionSelected,
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
                  Text(
                    "Options",
                    style: Themes(context).whiteBold16,
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 8.h(context)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: options.map((e) {
                        return GestureDetector(
                          onTap: () {
                            onOptionSelected(e);
                          },
                          child: Container(
                            color: Colors.transparent,
                            width: double.infinity,
                            padding: EdgeInsets.symmetric(
                              vertical: 8.h(context),
                            ),
                            child: Text(
                              e,
                              style: Themes(context).white14,
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
