import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:lux_global/ui/verify.dart';
import 'package:lux_global/utility/helper.dart';

import '../component/back_navigation.dart';
import '../component/button.dart';
import '../component/label_text_field.dart';
import '../component/text_field.dart';
import '../model/common_model.dart';
import '../utility/app_color.dart';
import '../utility/constants.dart';
import '../utility/network_service.dart';

class Auth extends StatefulWidget {
  const Auth({super.key});

  @override
  State<Auth> createState() => _AuthState();
}

class _AuthState extends State<Auth> {
  final TextEditingController _mobileController = TextEditingController();
  Response _response = Response('', 200);
  CommonModel _commonModel = CommonModel();

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints.expand(),
      decoration: const BoxDecoration(
        image: DecorationImage(
            image: AssetImage("assets/image/background.png"),
            fit: BoxFit.cover),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SafeArea(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const BackNavigation(),
                Padding(
                  padding: EdgeInsets.only(
                      left: Helpers.screenSize(context).width / 3, top: 60),
                  child: LabelTextField(
                    alignment: Alignment.topCenter,
                    label: 'OTP',
                    textSize: 32.0,
                    textColor: AppColor.primaryTextColor,
                  ),
                ),
              ],
            ),
            Expanded(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 60.0, vertical: 20),
                child: Column(
                  children: [
                    const Padding(padding: EdgeInsets.only(top: 100.0)),
                    TextInput(
                      onChanged: (text) {
                        _mobileController.selection =
                            TextSelection.fromPosition(
                          TextPosition(offset: _mobileController.text.length),
                        );
                      },
                      labelText: 'Enter Email',
                      textFieldController: _mobileController,
                      action: TextInputAction.done,
                      textInputType: TextInputType.phone,
                    ),
                    const Padding(
                        padding: EdgeInsets.symmetric(vertical: 10.0)),
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 60.0, right: 60.0, top: 30.0),
                      child: Button(
                        onPressed: () {
                          if (_mobileController.text.isEmpty) {
                            Helpers.showAlertDialog(
                                'Please enter email', context);
                          } else {
                            callForgot();
                          }
                        },
                        label: 'Generate OTP',
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        )),
      ),
    );
  }

  void callForgot() {
    var bodyParam = {'email': _mobileController.text};
    NetworkService.postMethod('${Constants.apiUrl}forgotpassword', context,
            bodyParam: bodyParam, isShowLoader: true)
        .then((value) async => {
              _response = value,
              if (_response.statusCode == 200)
                {
                  _commonModel =
                      CommonModel.fromJson(jsonDecode(_response.body)),
                  if (_commonModel.data?.status == 1)
                    {
                      Helpers.showAlertDialog(
                          _commonModel.data?.message ?? '', context),
                    }
                  else
                    {
                      Helpers.showAlertDialog(
                          _commonModel.data?.message ?? '', context),
                    }
                }
              else
                {
                  Helpers.showAlertDialog('Something went wrong', context),
                }
            });
  }
}
