import 'package:flutter/material.dart';

import '../utility/app_color.dart';

class Button extends StatelessWidget {
  final GestureTapCallback onPressed;
  final String label, fontFamily;
  final Color? backGroundColor, textColor,shadowColors;
  final double borderWidth;

  Button({
    required this.onPressed,
    this.label = 'Submit',
    this.backGroundColor = AppColor.primaryColor,
    this.textColor = AppColor.primaryTextColor,
    this.fontFamily = 'Regular',
    this.borderWidth = 1.0,
    this.shadowColors = AppColor.primaryColor,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Align(
        alignment: Alignment.topLeft,
        child: Container(
          height: 45,
          margin: const EdgeInsets.only(right: 0.0),
          child: Card(
            elevation: 5.0,
            shape: RoundedRectangleBorder(
                side: BorderSide(color: AppColor.primaryColor, width: borderWidth),
                borderRadius: BorderRadius.circular(5.0)),
            shadowColor: shadowColors,
            color: backGroundColor,
            child: Container(
              alignment: Alignment.center,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0,vertical: 7.0),
                    child: Text(
                      label,
                      maxLines: 1,
                      style: TextStyle(
                          color: textColor,
                          fontFamily: fontFamily,
                          fontSize: 15.0),
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
