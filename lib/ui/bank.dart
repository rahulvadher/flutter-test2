import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:lux_global/model/common_model.dart';
import 'package:lux_global/model/profile_model.dart';
import 'package:lux_global/ui/navigation.dart';
import 'package:lux_global/utility/helper.dart';

import '../component/Icon_view.dart';
import '../component/back_navigation.dart';
import '../component/button.dart';
import '../component/label_text_field.dart';
import '../component/text_field.dart';
import '../model/account_model.dart';
import '../model/login_model.dart';
import '../utility/app_color.dart';
import '../utility/constants.dart';
import '../utility/network_service.dart';
import '../utility/globals.dart' as globals;

class Bank extends StatefulWidget {
  const Bank({super.key});

  @override
  State<Bank> createState() => _BankState();
}

class _BankState extends State<Bank> {
  final TextEditingController _accnoController = TextEditingController();
  final TextEditingController _accnmController = TextEditingController();
  final TextEditingController _ifscController = TextEditingController();

  Response _response = Response('', 200);
  CommonModel _commonModel = CommonModel();
  LoginModel _loginModel = LoginModel();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(Duration.zero, () {
      _accnoController.text =
          globals.profileModel?.bankDetail?.accountNumber ?? '';
      _accnmController.text =
          globals.profileModel?.bankDetail?.accountHolderName ?? '';
      _ifscController.text = globals.profileModel?.bankDetail?.ifscCode ?? '';
    });
  }

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
                        left: Helpers.screenSize(context).width / 5, top: 60),
                    child: LabelTextField(
                      alignment: Alignment.topCenter,
                      label: 'Bank Detail',
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
                        _accnoController.selection = TextSelection.fromPosition(
                          TextPosition(offset: _accnoController.text.length),
                        );
                      },
                      labelText: 'Account Number',
                      textFieldController: _accnoController,
                      textInputType: TextInputType.number,
                      icon1: const IconView(
                        icon: 'referral_code.png',
                      ),
                    ),
                    const Padding(
                        padding: EdgeInsets.symmetric(vertical: 15.0)),
                    TextInput(
                      onChanged: (text) {
                        _accnmController.selection = TextSelection.fromPosition(
                          TextPosition(offset: _accnmController.text.length),
                        );
                      },
                      labelText: 'Account Holder Name',
                      textFieldController: _accnmController,
                      icon1: const IconView(
                        icon: 'user_1.png',
                      ),
                    ),
                    const Padding(
                        padding: EdgeInsets.symmetric(vertical: 15.0)),
                    TextInput(
                      onChanged: (text) {
                        _ifscController.selection = TextSelection.fromPosition(
                          TextPosition(offset: _ifscController.text.length),
                        );
                      },
                      labelText: 'IFSC',
                      textFieldController: _ifscController,
                      action: TextInputAction.done,
                      icon1: const IconView(
                        icon: 'referral_code.png',
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 0.0, right: 0.0, top: 20.0),
                      child: Button(
                        onPressed: () {
                          if (_accnmController.text.isEmpty) {
                            Helpers.showAlertDialog(
                                'Please enter account number', context);
                          } else if (_accnmController.text.isEmpty) {
                            Helpers.showAlertDialog(
                                'Please enter account holder name', context);
                          } else if (_ifscController.text.isEmpty) {
                            Helpers.showAlertDialog(
                                'Please enter ifsc', context);
                          } else {
                            callBank();
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

  void callBank() {
    var bodyParam = {
      'id': globals.profileModel?.userData?.id,
      'account_number': _accnoController.text,
      'account_holder_name': _accnmController.text,
      'ifsc_code': _ifscController.text,
    };
    NetworkService.postMethod(
            '${Constants.apiUrl}${globals.profileModel?.bankDetail?.accountHolderName == null ? 'bankdetailadd' : 'bankdetailedit'}',
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
                      Navigator.pop(context, 1),
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
