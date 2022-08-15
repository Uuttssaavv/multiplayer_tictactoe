import 'package:flutter/material.dart';

extension SpacingExtension on num {
  Widget get verticalSpacer => SizedBox(height: toDouble(), width: 0);
  Widget get horizontalSpacer => SizedBox(height: 0, width: toDouble());
}

extension ContextExtension on BuildContext {
  MediaQueryData get mediaQuery => MediaQuery.of(this);
  double get height => mediaQuery.size.height;
  double get width => mediaQuery.size.width;
  TextTheme get textTheme => Theme.of(this).textTheme;
  void goBack() => Navigator.pop(this);
  void pushReplacement(Widget view) => Navigator.pushReplacement(
        this,
        MaterialPageRoute(
          builder: (context) => view,
        ),
      );
  void push(Widget view) => Navigator.push(
        this,
        MaterialPageRoute(
          builder: (context) => view,
        ),
      );
}
