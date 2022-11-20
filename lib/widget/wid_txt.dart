import 'package:flutter/material.dart';

class WidText extends StatelessWidget {
  final String? title;
  final String? type;
  final Color widColor;

  final bool isOverflow;
  final bool isMaxLines;
  final int maxLine;
  final TextDecoration? textDecoration;

  const WidText({
    Key? key,
    this.title,
    this.type = "B1",
    this.isOverflow = false,
    this.widColor = Colors.red,
    this.isMaxLines = false,
    this.maxLine = 3,
    this.textDecoration,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      title ?? "",
      overflow: isOverflow ? TextOverflow.ellipsis : null,
      textScaleFactor: 1.0,
      maxLines: isMaxLines ? maxLine : null,
      style: TextStyle(
        color: widColor,
        fontSize: 20,
        decoration: textDecoration,
      ),
    );
  }
}
