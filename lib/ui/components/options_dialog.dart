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
    return Material(
      color: Colors.transparent,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FlatCard(
              color: Colors.white,
              shadow: BoxShadow(),
              borderRadius: BorderRadius.circular(14.w(context)),
              width: MediaQuery.of(context).size.width * 0.8,
              child: Container(
                padding: EdgeInsets.all(18.w(context)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Options",
                      style: Themes(context).blackBold18,
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 8.h(context)),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: options.map((e) {
                          return InkWell(
                            onTap: () {
                              onOptionSelected(e);
                            },
                            child: Container(
                              color: Colors.white,
                              width: double.infinity,
                              padding: EdgeInsets.symmetric(
                                vertical: 12.h(context),
                              ),
                              child: Text(
                                e,
                                style: Themes(context).black16,
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
          ],
        ),
      ),
    );
  }
}
