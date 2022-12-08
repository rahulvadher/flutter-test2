import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:lux_global/model/account_model.dart';
import 'package:lux_global/model/login_model.dart';
import 'package:lux_global/model/profile_model.dart';
import 'package:lux_global/ui/auth.dart';
import 'package:lux_global/utility/network_service.dart';

import '../component/Icon_view.dart';
import '../component/button.dart';
import '../component/label_text_field.dart';
import '../component/text_field.dart';
import '../utility/app_color.dart';
import '../utility/constants.dart';
import '../utility/helper.dart';
import 'navigation.dart';
import 'register.dart';
import '../utility/globals.dart' as globals;

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final TextEditingController _unController = TextEditingController();
  final TextEditingController _passController = TextEditingController();
  bool _obscureText = true;
  Response _response = Response('', 200);
  LoginModel _loginModel = LoginModel();
  ProfileModel _profileModel = ProfileModel();

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/image/background.png"),
              fit: BoxFit.fill,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 70.0),
          child: LabelTextField(
            alignment: Alignment.topCenter,
            label: 'Login',
            textSize: 32.0,
            textColor: AppColor.primaryTextColor,
          ),
        ),
        SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 60.0),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
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
                const Padding(padding: EdgeInsets.symmetric(vertical: 15.0)),
                TextInput(
                  onChanged: (text) {
                    _passController.selection = TextSelection.fromPosition(
                      TextPosition(offset: _passController.text.length),
                    );
                  },
                  labelText: 'Password',
                  action: TextInputAction.done,
                  textInputType: TextInputType.visiblePassword,
                  obscure: _obscureText,
                  textFieldController: _passController,
                  icon1: const IconView(
                    icon: 'lock.png',
                    color: AppColor.primaryColor,
                  ),
                  icon2: GestureDetector(
                    onTap: () {
                      setState(() {
                        _obscureText = !_obscureText;
                      });
                    },
                    child: IconView(
                      icon: _obscureText == true ? 'hide.png' : 'unhide.png',
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 30.0),
                  child: LabelTextField(
                    alignment: Alignment.center,
                    label: 'Forgot Password?',
                    textSize: 12.0,
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const Auth()),
                      );
                    },
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(left: 0.0, right: 0.0, top: 30.0),
                  child: Button(
                    onPressed: () {
                      if (_unController.text.isEmpty) {
                        Helpers.showAlertDialog(
                            'Please enter user name', context);
                      } else if (_passController.text.isEmpty) {
                        Helpers.showAlertDialog(
                            'Please enter password', context);
                      } else {
                        callLogin();
                      }
                    },
                    label: 'Sign In',
                    fontFamily: 'Regular',
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20.0),
                  child: LabelTextField(
                    alignment: Alignment.center,
                    label: 'Create new account?',
                    textSize: 12.0,
                    textColor: AppColor.secondaryTextColor,
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const Register()),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        )
      ],
    );
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
                  _profileModel =
                      ProfileModel.fromJson(jsonDecode(_response.body)),
                  Helpers.saveStringSF('accessToken',
                      _profileModel.userData?.id.toString() ?? ''),
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
