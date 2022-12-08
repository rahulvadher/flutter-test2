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

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final TextEditingController _fnController = TextEditingController();
  final TextEditingController _lnController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _mobileController = TextEditingController();
  final TextEditingController _bdController = TextEditingController();
  final TextEditingController _rfController = TextEditingController();
  final TextEditingController _dcController = TextEditingController();
  final TextEditingController _unController = TextEditingController();
  final TextEditingController _passController = TextEditingController();
  final TextEditingController _tpinNameController = TextEditingController();
  late bool _checkTerm = false, _obscurePassword = true, _obscurePin = true;
  Response _response = Response('', 200);
  CommonModel _commonModel = CommonModel();
  LoginModel _loginModel = LoginModel();

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
                        left: Helpers.screenSize(context).width / 4.5, top: 60),
                    child: LabelTextField(
                      alignment: Alignment.topCenter,
                      label: 'Register',
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
                        _fnController.selection = TextSelection.fromPosition(
                          TextPosition(offset: _fnController.text.length),
                        );
                      },
                      labelText: 'First Name',
                      textFieldController: _fnController,
                      icon1: const IconView(
                        icon: 'user_1.png',
                      ),
                    ),
                    const Padding(
                        padding: EdgeInsets.symmetric(vertical: 15.0)),
                    TextInput(
                      onChanged: (text) {
                        _lnController.selection = TextSelection.fromPosition(
                          TextPosition(offset: _lnController.text.length),
                        );
                      },
                      labelText: 'Last Name',
                      textFieldController: _lnController,
                      icon1: const IconView(
                        icon: 'user_1.png',
                      ),
                    ),
                    const Padding(
                        padding: EdgeInsets.symmetric(vertical: 15.0)),
                    TextInput(
                      onChanged: (text) {
                        _emailController.selection = TextSelection.fromPosition(
                          TextPosition(offset: _emailController.text.length),
                        );
                      },
                      labelText: 'Email',
                      textFieldController: _emailController,
                      icon1: const IconView(
                        icon: 'email.png',
                      ),
                    ),
                    const Padding(
                        padding: EdgeInsets.symmetric(vertical: 15.0)),
                    TextInput(
                      onChanged: (text) {
                        _mobileController.selection =
                            TextSelection.fromPosition(
                          TextPosition(offset: _mobileController.text.length),
                        );
                      },
                      labelText: 'Mobile No',
                      textFieldController: _mobileController,
                      textInputType: TextInputType.phone,
                      icon1: const IconView(
                        icon: 'call.png',
                      ),
                    ),
                    const Padding(
                        padding: EdgeInsets.symmetric(vertical: 15.0)),
                    GestureDetector(
                      onTap: () async {
                        FocusScope.of(context).unfocus();
                        await Helpers.calendar(
                          context,
                          DateTime(1950),
                        ).then((value) => _bdController.text = value);
                        setState(() {});
                      },
                      child: TextInput(
                        onChanged: (text) {
                          _bdController.selection = TextSelection.fromPosition(
                            TextPosition(offset: _bdController.text.length),
                          );
                        },
                        labelText: 'Birth Date',
                        textFieldController: _bdController,
                        isEnable: false,
                        icon1: const IconView(
                          icon: 'calendar.png',
                        ),
                      ),
                    ),
                    const Padding(
                        padding: EdgeInsets.symmetric(vertical: 15.0)),
                    TextInput(
                      onChanged: (text) {
                        _rfController.selection = TextSelection.fromPosition(
                          TextPosition(offset: _rfController.text.length),
                        );
                      },
                      labelText: 'Referral Code',
                      textFieldController: _rfController,
                      icon1: const IconView(
                        icon: 'referral_code.png',
                      ),
                    ),
                    const Padding(
                        padding: EdgeInsets.symmetric(vertical: 15.0)),
                    TextInput(
                      onChanged: (text) {
                        _dcController.selection = TextSelection.fromPosition(
                          TextPosition(offset: _dcController.text.length),
                        );
                      },
                      labelText: 'Daily Code',
                      textFieldController: _dcController,
                      icon1: const IconView(
                        icon: 'referral_code.png',
                      ),
                    ),
                    const Padding(
                        padding: EdgeInsets.symmetric(vertical: 15.0)),
                    TextInput(
                      onChanged: (text) {
                        _unController.selection = TextSelection.fromPosition(
                          TextPosition(offset: _unController.text.length),
                        );
                      },
                      labelText: 'User Name',
                      textFieldController: _unController,
                      icon1: const IconView(
                        icon: 'user.png',
                      ),
                    ),
                    const Padding(
                        padding: EdgeInsets.symmetric(vertical: 15.0)),
                    TextInput(
                      onChanged: (text) {
                        _passController.selection = TextSelection.fromPosition(
                          TextPosition(offset: _passController.text.length),
                        );
                      },
                      labelText: 'Password',
                      textInputType: TextInputType.visiblePassword,
                      obscure: _obscurePassword,
                      textFieldController: _passController,
                      icon1: const IconView(
                        icon: 'lock.png',
                      ),
                      icon2: GestureDetector(
                        onTap: () {
                          setState(() {
                            _obscurePassword = !_obscurePassword;
                          });
                        },
                        child: IconView(
                          icon: _obscurePassword == true
                              ? 'hide.png'
                              : 'unhide.png',
                        ),
                      ),
                    ),
                    const Padding(
                        padding: EdgeInsets.symmetric(vertical: 15.0)),
                    TextInput(
                      onChanged: (text) {
                        _tpinNameController.selection =
                            TextSelection.fromPosition(
                          TextPosition(offset: _tpinNameController.text.length),
                        );
                      },
                      labelText: 'T-Pin',
                      textFieldController: _tpinNameController,
                      action: TextInputAction.done,
                      textInputType: TextInputType.visiblePassword,
                      obscure: _obscurePin,
                      icon1: const IconView(
                        icon: 'key.png',
                      ),
                      icon2: GestureDetector(
                        onTap: () {
                          setState(() {
                            _obscurePin = !_obscurePin;
                          });
                        },
                        child: IconView(
                          icon: _obscurePin == true ? 'hide.png' : 'unhide.png',
                        ),
                      ),
                    ),
                    Padding(
                        padding: const EdgeInsets.only(top: 20.0),
                        child: CheckboxListTile(
                          contentPadding: EdgeInsets.zero,
                          title: LabelTextField(
                            label: 'I read & agree to Terms & Conditions.',
                            textSize: 12.0,
                          ),
                          value: _checkTerm,
                          onChanged: (newValue) {
                            setState(() {
                              _checkTerm = newValue!;
                            });
                          },
                          controlAffinity: ListTileControlAffinity.leading,
                          visualDensity: VisualDensity.compact,
                          activeColor: AppColor.primaryColor,
                        )),
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 0.0, right: 0.0, top: 20.0),
                      child: Button(
                        onPressed: () {
                          if (_fnController.text.isEmpty) {
                            Helpers.showAlertDialog(
                                'Please enter first name', context);
                          } else if (_lnController.text.isEmpty) {
                            Helpers.showAlertDialog(
                                'Please enter last name', context);
                          } else if (_emailController.text.isEmpty) {
                            Helpers.showAlertDialog(
                                'Please enter email', context);
                          } else if (_mobileController.text.isEmpty) {
                            Helpers.showAlertDialog(
                                'Please enter mobile number', context);
                          } else if (_bdController.text.isEmpty) {
                            Helpers.showAlertDialog(
                                'Please select DOB', context);
                          } else if (_rfController.text.isEmpty) {
                            Helpers.showAlertDialog(
                                'Please enter referral code', context);
                          } else if (_dcController.text.isEmpty) {
                            Helpers.showAlertDialog(
                                'Please enter daily code', context);
                          } else if (_unController.text.isEmpty) {
                            Helpers.showAlertDialog(
                                'Please enter user name', context);
                          } else if (_passController.text.isEmpty) {
                            Helpers.showAlertDialog(
                                'Please enter password', context);
                          } else if (_tpinNameController.text.isEmpty) {
                            Helpers.showAlertDialog(
                                'Please enter T-Pin', context);
                          } else if (!_checkTerm) {
                            Helpers.showAlertDialog(
                                'Please check term & conditions', context);
                          } else {
                            callRegister();
                          }
                        },
                        label: 'Create Account',
                        fontFamily: 'Regular',
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(top: 20.0),
                        child: RichText(
                          text: const TextSpan(
                            // Note: Styles for TextSpans must be explicitly defined.
                            // Child text spans will inherit styles from parent
                            style: TextStyle(
                                fontSize: 12.0,
                                color: AppColor.secondaryTextColor,
                                fontFamily: 'Regular'),
                            children: <TextSpan>[
                              TextSpan(text: 'Already have an account?'),
                              TextSpan(
                                  text: 'Sign In',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: AppColor.purpleColor,
                                      fontFamily: 'Regular')),
                            ],
                          ),
                        ),
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

  void callRegister() {
    var bodyParam = {
      'first_name': _fnController.text,
      'last_name': _lnController.text,
      'email': _emailController.text,
      'phone': _mobileController.text,
      'dob': Helpers.changeDateFormat(
          _bdController.text, 'dd-MM-yyyy', 'yyyy-MM-dd'),
      // 'referral_code': _rfController.text,
      'referral_code': '',
      'daily_code': _dcController.text,
      'username': _unController.text,
      'password': _passController.text,
      'tpin': _tpinNameController.text,
    };
    NetworkService.postMethod('${Constants.apiUrl}register_user', context,
            bodyParam: bodyParam, isShowLoader: true)
        .then((value) async => {
              _response = value,
              if (_response.statusCode == 200)
                {
                  _commonModel =
                      CommonModel.fromJson(jsonDecode(_response.body)),
                  if (_commonModel.data?.status == 1)
                    {
                     callLogin(),
                    }else{
                    Helpers.showAlertDialog(_commonModel.data?.message??'' , context),
                  }
                }
              else
                {
                  Helpers.showAlertDialog('Something went wrong', context),
                }
            });
  }

  void callLogin() {
    var bodyParam = {
      'username': _unController.text,
      'password': _passController.text,
    };
    NetworkService.postMethod('${Constants.apiUrl}login', context,
        bodyParam: bodyParam, isShowLoader: true)
        .then(
          (value) async => {
        _response = value,
        if (_response.statusCode == 200)
          {
            _loginModel = LoginModel.fromJson(jsonDecode(_response.body)),
            if (_loginModel.data?.status == 1)
              {
                callProfile(_loginModel.data?.id ?? ''),
              }
            else
              {
                Helpers.showAlertDialog(
                    _loginModel.data?.message ?? '', context),
              }
          }
        else
          {
            Helpers.showAlertDialog('Something went wrong', context),
          }
      },
    );
  }

  void callProfile(String id) {
    var bodyParam = {
      'id': id,
    };
    NetworkService.postMethod('${Constants.apiUrl}profile', context,
        bodyParam: bodyParam, isShowLoader: true)
        .then((value) async => {
      _response = value,
      if (_response.statusCode == 200)
        {

          globals.profileModel =
              ProfileModel.fromJson(jsonDecode(_response.body)),
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const Navigation()),
          ),
        }
      else
        {
          Helpers.showAlertDialog('Something went wrong', context),
        }
    });
  }
}
