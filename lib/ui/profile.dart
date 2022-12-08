import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:lux_global/ui/bank.dart';
import 'package:lux_global/ui/change_password.dart';

import 'package:lux_global/ui/update_profile.dart';
import 'package:lux_global/ui/web.dart';
import 'package:package_info_plus/package_info_plus.dart';

import '../component/Icon_view.dart';
import '../component/back_navigation.dart';
import '../component/label_text_field.dart';
import '../model/common_model.dart';
import '../model/profile_model.dart';
import '../utility/app_color.dart';
import '../utility/constants.dart';
import '../utility/helper.dart';
import '../utility/network_service.dart';
import 'login.dart';
import 'feedback.dart';
import '../utility/globals.dart' as globals;

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  Response _response = Response('', 200);
  ProfileModel _profileModel = ProfileModel();
  CommonModel _commonModel = CommonModel();
  PackageInfo _packageInfo = PackageInfo(
    appName: 'Unknown',
    packageName: 'Unknown',
    version: 'Unknown',
    buildNumber: 'Unknown',
    buildSignature: 'Unknown',

  );

  @override
  void initState() {
    super.initState();
    _initPackageInfo();
  }

  Future<void> _initPackageInfo() async {
    final info = await PackageInfo.fromPlatform();
    setState(() {
      _packageInfo = info;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.secondaryColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const BackNavigation(),
              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5.0),
                ),
                color: AppColor.primaryColor,
                elevation: 5,
                margin: const EdgeInsets.all(15),
                child: Row(
                  children: [
                    Card(
                      semanticContainer: true,
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      shape: RoundedRectangleBorder(
                        side: const BorderSide(
                            color: AppColor.primaryTextColor, width: 1),
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                      margin: const EdgeInsets.all(25),
                      child: Image.network(
                        'https://www.w3schools.com/howto/img_avatar.png',
                        fit: BoxFit.fill,
                        height: 80,
                        width: 80,
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        LabelTextField(
                          label: globals.profileModel?.userData?.username ?? '',
                          textSize: 18.0,
                          textColor: AppColor.primaryTextColor,
                        ),
                        Row(
                          children: [
                            LabelTextField(
                              label: 'Edit Profile',
                              textColor: AppColor.grayColor,
                            ),
                            GestureDetector(
                              onTap: (){
                                Navigator.pop(context,3);
                              },
                              child:  const Padding(
                                padding: EdgeInsets.all(5),
                                child: IconView(
                                  icon: 'pencil.png',
                                  color: AppColor.primaryGrayColor,
                                ),
                              ),
                            ),
                          ],
                        )
                      ],
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 15, right: 15, top: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    LabelTextField(
                      label: 'My Level',
                      textSize: 20,
                      textColor: AppColor.primaryTextColor,
                    ),
                    const IconView(
                      icon: 'right_arrow.png',
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    left: 15, right: 15, top: 20, bottom: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: const [
                    IconView(
                      icon: 'level_1.png',
                      height: 50,
                      width: 50,
                    ),
                    IconView(
                      icon: 'level_2.png',
                      height: 50,
                      width: 50,
                    ),
                    IconView(
                      icon: 'level_3.png',
                      height: 50,
                      width: 50,
                    ),
                    IconView(
                      icon: 'level_4.png',
                      height: 50,
                      width: 50,
                    ),
                    IconView(
                      icon: 'level_5.png',
                      height: 50,
                      width: 50,
                    )
                  ],
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.pop(context,1);
                },
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                  color: AppColor.primaryColor,
                  elevation: 5,
                  margin: const EdgeInsets.all(15),
                  child: Padding(
                    padding: const EdgeInsets.all(25),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            const IconView(
                              icon: 'wallet.png',
                              height: 25,
                              width: 25,
                              color: AppColor.primaryTextColor,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 15),
                              child: LabelTextField(
                                textSize: 22,
                                label: 'Wallet',
                                textColor: AppColor.primaryTextColor,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(right: 10),
                              child: LabelTextField(
                                textSize: 22,
                                label:
                                    '${globals.profileModel?.wallet?.totalEarning ?? 0}',
                                textColor: AppColor.primaryTextColor,
                              ),
                            ),
                            const IconView(
                              icon: 'star.png',
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5.0),
                ),
                color: AppColor.primaryColor,
                elevation: 5,
                margin: const EdgeInsets.all(15),
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Wrap(
                    children: [
                      Row(
                        children: [
                          const IconView(
                            icon: 'notification.png',
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 20),
                            child: LabelTextField(
                              label: 'Notification',
                              textSize: 20,
                              textColor: AppColor.primaryTextColor,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 50),
                      Row(
                        children: [
                          const IconView(
                            icon: 'key_1.png',
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 20),
                            child: LabelTextField(
                              onPressed: (){
                                {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(builder: (context) => const ChangePassword()),
                                  );
                              }
                              },
                              label: 'Change Password',
                              textSize: 20,
                              textColor: AppColor.primaryTextColor,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 50),
                      Row(
                        children: [
                          const IconView(
                            icon: 'info.png',
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 20),
                            child: LabelTextField(
                              label: 'User Manual',
                              textSize: 20,
                              textColor: AppColor.primaryTextColor,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 50),
                      Row(
                        children: [
                          const IconView(
                            icon: 'feedback.png',
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 20),
                            child: LabelTextField(
                              onPressed: (){
                                {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(builder: (context) => const FeedbackForm()),
                                  );
                                }
                              },
                              label: 'Feedback and Queries',
                              textSize: 20,
                              textColor: AppColor.primaryTextColor,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 50),
                      Row(
                        children: [
                          const IconView(
                            icon: 'updating.png',
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 20),
                            child: LabelTextField(
                              onPressed: (){
                                callCheckUpdate();
                              },
                              label: 'Check For Updates',
                              textSize: 20,
                              textColor: AppColor.primaryTextColor,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 50),
                      GestureDetector(
                        onTap: (){
                          Navigator.pop(context,2);
                        },

                        child: Row(
                          children: [
                            const IconView(
                              icon: 'kyc.png',
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 20),
                              child: LabelTextField(
                                label: 'KYC Upload',
                                textSize: 20,
                                textColor: AppColor.primaryTextColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 50),
                      Row(
                        children: [
                          const IconView(
                            icon: 'refund.png',
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 20),
                            child: LabelTextField(
                              onPressed: (){
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) =>  Web(endPoint: 'refundandcancellation',)),
                                );
                              },
                              label: 'Refund & Cancellation',
                              textSize: 20,
                              textColor: AppColor.primaryTextColor,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 50),
                      Row(
                        children: [
                          const IconView(
                            icon: 'bank.png',
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 20),
                            child: LabelTextField(
                              onPressed: (){
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => const Bank()),
                                ).then((value) => {
                                  if(value==1){
                                    callProfile(),
                                  }
                                });
                              },
                              label: 'Bank Detail',
                              textSize: 20,
                              textColor: AppColor.primaryTextColor,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5.0),
                ),
                color: AppColor.primaryColor,
                elevation: 5,
                margin: const EdgeInsets.all(15),
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Wrap(
                    children: [
                      Row(
                        children: [
                          const IconView(
                            icon: 'user_2.png',
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 20),
                            child: LabelTextField(
                              label: 'Manage Your Account',
                              textSize: 20,
                              textColor: AppColor.primaryTextColor,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 50),
                      Row(
                        children: [
                          const IconView(
                            icon: 'settings.png',
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 20),
                            child: LabelTextField(
                              label: 'Setting',
                              textSize: 20,
                              textColor: AppColor.primaryTextColor,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 40),
                child: Wrap(
                  children: [
                    LabelTextField(
                      label: 'FAQs',
                      textSize: 16,
                      textColor: AppColor.primaryTextColor,
                    ),
                    const SizedBox(height: 25),
                    LabelTextField(
                      label: 'About Us',
                      textSize: 16,
                      textColor: AppColor.primaryTextColor,
                    ),
                    const SizedBox(height: 25),
                    LabelTextField(
                      label: 'Contact Us',
                      textSize: 16,
                      textColor: AppColor.primaryTextColor,
                    ),
                    const SizedBox(height: 25),
                    LabelTextField(
                      onPressed: (){
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) =>  Web(endPoint: 'termsandconditions',)),
                        );
                      },
                      label: 'Terms & Conditions',
                      textSize: 16,
                      textColor: AppColor.primaryTextColor,
                    ),
                    const SizedBox(height: 25),
                    LabelTextField(
                      onPressed: (){
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) =>  Web(endPoint: 'refundandcancellation',)),
                        );
                      },
                      label: 'Privacy Policy',
                      textSize: 16,
                      textColor: AppColor.primaryTextColor,
                    ),
                  ],
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.pushAndRemoveUntil<dynamic>(
                    context,
                    MaterialPageRoute<dynamic>(
                      builder: (BuildContext context) => const Login(),
                    ),
                    (route) =>
                        false, //if you want to disable back feature set to false
                  );
                },
                child: Card(
                  shape: RoundedRectangleBorder(
                    side: const BorderSide(
                        color: AppColor.primaryTextColor, width: 1),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  color: Colors.transparent,
                  elevation: 0,
                  margin: const EdgeInsets.all(20),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: LabelTextField(
                      alignment: Alignment.center,
                      label: 'Logout',
                      textSize: 20,
                      textColor: AppColor.primaryTextColor,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
  void callProfile() {
    var bodyParam = {
      'id': globals.profileModel?.userData?.id,
    };
    NetworkService.postMethod('${Constants.apiUrl}profile', context,
        bodyParam: bodyParam, isShowLoader: false)
        .then((value) async => {
      _response = value,
      if (_response.statusCode == 200)
        {

          _profileModel =
              ProfileModel.fromJson(jsonDecode(_response.body)),
          Helpers.saveStringSF('accessToken', _profileModel.userData?.id.toString()??''),
          globals.profileModel =
              ProfileModel.fromJson(jsonDecode(_response.body)),

        }
      else
        {
          Helpers.showAlertDialog('Something went wrong', context),
        }
    });
  }
  void callCheckUpdate() {
    var bodyParam = {
      'id': globals.profileModel?.userData?.id,
      'version':_packageInfo.version,
    };
    NetworkService.postMethod('${Constants.apiUrl}checkforupdate', context,
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
