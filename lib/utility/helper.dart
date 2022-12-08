
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lux_global/component/loader.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'app_color.dart';
import '../component/label_text_field.dart';
import 'package:flutter_rounded_date_picker/flutter_rounded_date_picker.dart';
class Helpers {

  static Future<void> showAlertDialog(
      String alertMessage, BuildContext context) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Center(
          child: Wrap(
            children: [
              AlertDialog(
                shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10))),
                title: LabelTextField(
                  fontFamily: 'SemiBold',
                  textSize: 16.0,
                  label: alertMessage,
                  textColor: AppColor.secondaryTextColor,
                ),
                actions: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: LabelTextField(
                      alignment: Alignment.topRight,
                      fontFamily: 'Bold',
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      label: 'OK',
                      textSize: 16.0,
                      textColor: AppColor.primaryColor,
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }


  static Size screenSize(BuildContext context) {
    return MediaQuery.of(context).size;
  }

  static Future<String> calendar(
      BuildContext context, DateTime firstDate) async {
    FocusScope.of(context).unfocus();
    final newDateTime = await showRoundedDatePicker(
      initialDate: DateTime.now(),
      firstDate:firstDate,
      lastDate:DateTime.now(),
      context: context,
      height: MediaQuery.of(context).size.height / 2,
      styleDatePicker: MaterialRoundedDatePickerStyle(
        textStyleButtonNegative: const TextStyle(
            fontSize: 16.0,
            color: AppColor.secondaryTextColor,
            fontFamily: 'SemiBold'),
        textStyleButtonPositive: const TextStyle(
            fontSize: 16.0,
            color: AppColor.primaryColor,
            fontFamily: 'SemiBold'),
        paddingMonthHeader: const EdgeInsets.all(10.0),
        textStyleDayButton: const TextStyle(
            fontSize: 18.0,
            color: AppColor.primaryTextColor,
            fontFamily: 'SemiBold'),
        textStyleYearButton: const TextStyle(
          fontSize: 18.0,
          color: AppColor.primaryTextColor,
          fontFamily: 'SemiBold',
        ),
        textStyleMonthYearHeader: const TextStyle(
          fontSize: 18.0,
          color: AppColor.secondaryTextColor,
          fontFamily: 'SemiBold',
        ),
      ),
      theme: ThemeData(
        primaryColor: AppColor.primaryColor,
        accentColor: AppColor.primaryColor,
        dialogBackgroundColor: AppColor.primaryTextColor,
        textTheme: const TextTheme(
          bodyText2: TextStyle(
              color: AppColor.secondaryTextColor, fontFamily: 'SemiBold'),
          caption:
          TextStyle(color: AppColor.primaryColor, fontFamily: 'SemiBold'),
        ),
        disabledColor: AppColor.secondaryTextColor.withOpacity(0.60),
        accentTextTheme: const TextTheme(
          bodyText1: TextStyle(
              color: AppColor.primaryTextColor, fontFamily: 'SemiBold'),
        ),
      ),
    );
    if (newDateTime != null) {
      return DateFormat('dd-MM-yyyy').format(newDateTime);
    } else {
      return DateFormat('dd-MM-yyyy').format(DateTime.now());
    }
  }

  static Future<void> shodLoader(BuildContext context) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Center(
          child: Wrap(
            children: const [
              Loader(),
            ],
          ),
        );
      },
    );
  }

  static String changeDateFormat(
      String inputDate, String inputDateFormat, String expectedDateFormat) {
    return DateFormat(expectedDateFormat)
        .format(DateFormat(inputDateFormat).parse(inputDate));
  }
  static Future<String?> getStringSF(String key) async {
    final prefs = await SharedPreferences.getInstance();
    return (prefs.getString(key));
  }

  static saveStringSF(String key, String value) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString(key, value);
  }
}
