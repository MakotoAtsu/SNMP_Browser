import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class WidgetTool {
  static Widget createPadding(
    List<Widget> children, {
    EdgeInsetsGeometry padding =
        const EdgeInsets.symmetric(vertical: 16, horizontal: 30),
  }) =>
      Padding(
          padding: padding,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: children,
          ));
}
