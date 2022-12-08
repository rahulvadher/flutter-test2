import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../utility/app_color.dart';

class TextInput extends StatelessWidget {
  String labelText;
  TextEditingController textFieldController;
  TextInputType textInputType;
  int textInputLength;
  int maxLine;
  int minLine;
  bool? isEnable;
  ValueChanged<String> onChanged;
  Widget? icon1;
  Widget? icon2;
  bool autoFocus;
  double elevation;
  TextInputAction action;
  bool obscure;

  TextInput({super.key,
    required this.labelText,
    required this.textFieldController,
    this.textInputType = TextInputType.emailAddress,
    this.action = TextInputAction.next,
    this.textInputLength = 50,
    this.isEnable = true,
    this.icon1,
    this.icon2,
    required this.onChanged,
    this.autoFocus = false,
    this.elevation = 3.0,
    this.maxLine = 1,
    this.minLine = 1,
    this.obscure = false,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: AppColor.primaryGrayColor,
      elevation: elevation,
      shadowColor: AppColor.primaryTextColor,
      margin: EdgeInsets.zero,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: Row(
          children: [
            Container(child: icon1),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: TextField(
                  maxLines: maxLine,
                  minLines: minLine,
                  autofocus: autoFocus,
                  onChanged: onChanged,
                  enabled: isEnable,
                  obscureText: obscure,
                  inputFormatters: [
                    LengthLimitingTextInputFormatter(textInputLength),
                  ],
                  style: const TextStyle(
                      fontSize: 14.0,
                      fontFamily: 'Regular',
                      letterSpacing: 0.0),
                  controller: textFieldController,
                  textInputAction: action,
                  keyboardType: textInputType,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    disabledBorder: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    errorBorder: InputBorder.none,
                    hintText: labelText,
                    hintStyle: TextStyle(
                        color: isEnable == true
                            ? AppColor.primaryGrayLightColor
                            : AppColor.primaryGrayLightColor),
                  ),
                ),
              ),
            ),
            Container(child: icon2),
          ],
        ),
      ),
    );
  }
}
