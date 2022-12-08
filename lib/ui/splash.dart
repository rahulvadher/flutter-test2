import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:lux_global/model/common_model.dart';
import 'package:lux_global/ui/login.dart';
import '../model/profile_model.dart';
import '../utility/app_color.dart';
import '../utility/constants.dart';
import '../utility/globals.dart' as globals;
import '../utility/helper.dart';
import '../utility/network_service.dart';
import 'navigation.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  Response _response = Response('', 200);
  ProfileModel _profileModel = ProfileModel();
  CommonModel _commonModel = CommonModel();

  @override
  void initState() {
    // TODO: implement initState
    getPref();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: AppColor.secondaryColor,
    );
  }

  Future<String> getPref() async {
    await Helpers.getStringSF('accessToken').then((value) => {
          if (value != '')
            {
              globals.profileModel?.userData?.id = value,
              callProfile(value!),
            }
          else
            {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const Login()),
              ),
            }
        });
    return '';
  }

  void callProfile(String id) {
    var bodyParam = {
      'id': id,
    };
    NetworkService.postMethod('${Constants.apiUrl}profile', context,
            bodyParam: bodyParam, isShowLoader: false)
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
                  callSplash(),
                }
              else
                {
                  Helpers.showAlertDialog('Something went wrong', context),
                }
            });
  }

  void callSplash() {
    NetworkService.postMethod('${Constants.apiUrl}splash', context,
            isShowLoader: true)
        .then((value) async => {
              _response = value,
              if (_response.statusCode == 200)
                {
                  _commonModel =
                      CommonModel.fromJson(jsonDecode(_response.body)),
                  if (_commonModel.data?.status == 1)
                    {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const Navigation()),
                      ),
                    }
                }
              else
                {
                  Helpers.showAlertDialog('Something went wrong', context),
                }
            });
  }
}
