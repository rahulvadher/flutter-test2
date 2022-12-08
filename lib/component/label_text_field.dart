import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../utility/app_color.dart';

class LabelTextField extends StatelessWidget {
  final GestureTapCallback? onPressed;
  final String label, fontFamily;
  final Color textColor;
  final double textSize;
  final Alignment alignment;
  final TextOverflow overflow;
  final TextAlign textAlign;
  final TextDecoration decoration;


  LabelTextField({
    this.label = '',
    this.textColor = AppColor.primaryColor,
    this.fontFamily = 'Regular',
    this.textSize = 14.0,
    this.alignment = Alignment.topLeft,
    this.overflow = TextOverflow.visible,
    this.onPressed,
    this.textAlign = TextAlign.start,
    this.decoration = TextDecoration.none,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Align(
        alignment: alignment,
        child: Text(
          label,
          textAlign: textAlign,
          overflow: overflow,
          style: TextStyle(
              decoration: decoration,
              color: textColor,
              fontFamily: fontFamily,
              fontSize: textSize,
              letterSpacing: 0.0),
        ),
      ),
    );
  }
}
