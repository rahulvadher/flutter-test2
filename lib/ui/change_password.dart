import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:lux_global/model/common_model.dart';
import 'package:lux_global/utility/helper.dart';

import '../component/Icon_view.dart';
import '../component/back_navigation.dart';
import '../component/button.dart';
import '../component/label_text_field.dart';
import '../component/text_field.dart';
import '../utility/app_color.dart';
import '../utility/constants.dart';
import '../utility/network_service.dart';
import '../utility/globals.dart' as globals;

class ChangePassword extends StatefulWidget {
  const ChangePassword({super.key});

  @override
  State<ChangePassword> createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  final TextEditingController _oldpassController = TextEditingController();
  final TextEditingController _newpassController = TextEditingController();
  final TextEditingController _confimpassController = TextEditingController();

  Response _response = Response('', 200);
  CommonModel _commonModel = CommonModel();
  bool _obscureOld = true, _obscureNew = true, _obscureConfirm = true;
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
          child: SingleChildScrollView(
              child: Wrap(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const BackNavigation(),
                  Padding(
                    padding: EdgeInsets.only(
                        left: Helpers.screenSize(context).width / 4, top: 60),
                    child: LabelTextField(
                      alignment: Alignment.topCenter,
                      label: 'Password',
                      textSize: 32.0,
                      textColor: AppColor.primaryTextColor,
                    ),
                  ),
                ],
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 60.0, vertical: 50),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextInput(
                      onChanged: (text) {
                        _oldpassController.selection = TextSelection.fromPosition(
                          TextPosition(offset: _oldpassController.text.length),
                        );
                      },
                      labelText: 'Old password',
                      textInputType: TextInputType.visiblePassword,
                      obscure: _obscureOld,
                      textFieldController: _oldpassController,
                      icon1: const IconView(
                        icon: 'lock.png',
                        color: AppColor.primaryColor,
                      ),
                      icon2: GestureDetector(
                        onTap: () {
                          setState(() {
                            _obscureOld = !_obscureOld;
                          });
                        },
                        child: IconView(
                          icon: _obscureOld == true ? 'hide.png' : 'unhide.png',
                        ),
                      ),
                    ),
                    const Padding(
                        padding: EdgeInsets.symmetric(vertical: 15.0)),
                    TextInput(
                      onChanged: (text) {
                        _newpassController.selection = TextSelection.fromPosition(
                          TextPosition(offset: _newpassController.text.length),
                        );
                      },
                      labelText: 'New password',
                      textInputType: TextInputType.visiblePassword,
                      obscure: _obscureNew,
                      textFieldController: _newpassController,
                      icon1: const IconView(
                        icon: 'lock.png',
                        color: AppColor.primaryColor,
                      ),
                      icon2: GestureDetector(
                        onTap: () {
                          setState(() {
                            _obscureNew = !_obscureNew;
                          });
                        },
                        child: IconView(
                          icon: _obscureNew == true ? 'hide.png' : 'unhide.png',
                        ),
                      ),
                    ),
                    const Padding(
                        padding: EdgeInsets.symmetric(vertical: 15.0)),
                    TextInput(
                      onChanged: (text) {
                        _confimpassController.selection = TextSelection.fromPosition(
                          TextPosition(offset: _confimpassController.text.length),
                        );
                      },
                      labelText: 'Confirm password',
                      textInputType: TextInputType.visiblePassword,
                      obscure: _obscureConfirm,
                      textFieldController: _confimpassController,
                      action: TextInputAction.done,
                      icon1: const IconView(
                        icon: 'lock.png',
                        color: AppColor.primaryColor,
                      ),
                      icon2: GestureDetector(
                        onTap: () {
                          setState(() {
                            _obscureConfirm = !_obscureConfirm;
                          });
                        },
                        child: IconView(
                          icon: _obscureConfirm == true ? 'hide.png' : 'unhide.png',
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 0.0, right: 0.0, top: 20.0),
                      child: Button(
                        onPressed: () {
                          if (_oldpassController.text.isEmpty) {
                            Helpers.showAlertDialog(
                                'Please enter old password', context);
                          } else if (_newpassController.text.isEmpty) {
                            Helpers.showAlertDialog(
                                'Please enter new password', context);
                          } else if (_confimpassController.text.isEmpty) {
                            Helpers.showAlertDialog(
                                'Please enter confirm password', context);
                          }else if (_confimpassController.text!=_newpassController.text) {
                            Helpers.showAlertDialog(
                                'Password mismatch', context);
                          }
                          else {
                            callChangePassword();
                          }
                        },
                        label: 'Submit',
                      ),
                    ),
                  ],
                ),
              ),
            ],
          )),
        ),
      ),
    );
  }

  void callChangePassword() {
    var bodyParam = {
      'id': globals.profileModel?.userData?.id,
      'old_password': _oldpassController.text,
      'new_password': _newpassController.text,
      'confirm_password': _confimpassController.text,
    };
    NetworkService.postMethod(
            '${Constants.apiUrl}changepassword',
            context,
            bodyParam: bodyParam,
            isShowLoader: true)
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
