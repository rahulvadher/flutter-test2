import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:lux_global/utility/app_color.dart';

import '../component/Icon_view.dart';
import '../component/label_text_field.dart';
import '../model/profile_model.dart';
import '../utility/constants.dart';
import '../utility/helper.dart';
import '../utility/network_service.dart';
import '../utility/globals.dart' as globals;

class Wallet extends StatefulWidget {
  const Wallet({super.key});

  @override
  State<Wallet> createState() => _WalletState();
}

class _WalletState extends State<Wallet> {
  Response _response = Response('', 200);
  ProfileModel _profileModel = ProfileModel();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    Future.delayed(Duration.zero, () {
      callProfile(globals.profileModel?.userData?.id??'');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: Helpers.screenSize(context).height,
      color: AppColor.grayLightColor,
      child: Wrap(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 25),
            child: Wrap(
              children: [
                LabelTextField(
                  alignment: Alignment.center,
                  label: 'Total Earned Amount',
                  textSize: 20,
                ),
                const SizedBox(
                  height: 25,
                ),
                LabelTextField(
                  alignment: Alignment.center,
                  label: '${_profileModel.wallet?.totalEarning ?? 0}',
                  textSize: 30,
                  textColor: AppColor.secondaryTextColor,
                ),
                const SizedBox(
                  height: 50,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    LabelTextField(
                      label: 'Your total LuxGlobal is worth',
                      textColor: AppColor.secondaryTextColor,
                    ),
                    LabelTextField(
                      label: ' ${_profileModel.wallet?.totalEarning ?? 0} ',
                      fontFamily: 'Bold',
                      textColor: AppColor.secondaryTextColor,
                    ),
                    const IconView(
                      icon: 'info_1.png',
                      height: 15,
                      width: 15,
                    ),
                  ],
                ),
                const SizedBox(
                  height: 40,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: LabelTextField(
                    alignment: Alignment.center,
                    label:
                        'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum is simply dummy text of the printing and typesetting industry.',
                    textColor: AppColor.grayColor,
                  ),
                ),
                const SizedBox(
                  height: 80,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    LabelTextField(
                      label: 'You have ',
                      textColor: AppColor.secondaryTextColor,
                    ),
                    LabelTextField(
                      label: ' ${_profileModel.wallet?.totalEarning ?? 0} ',
                      fontFamily: 'Bold',
                      textColor: AppColor.secondaryTextColor,
                    ),
                    LabelTextField(
                      label: 'LuxGlobal Pending ',
                      textColor: AppColor.secondaryTextColor,
                    ),
                    const IconView(
                      icon: 'info_1.png',
                      height: 15,
                      width: 15,
                    ),
                  ],
                ),
                const SizedBox(
                  height: 50,
                ),
              ],
            ),
          ),

          Container(
            padding: const EdgeInsets.symmetric(vertical: 25),
            color: AppColor.primaryTextColor,
            child: Wrap(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      LabelTextField(
                        label: 'Description',
                        fontFamily: 'Bold',
                        textColor: AppColor.secondaryTextColor,
                        textSize: 16,
                      ),
                      LabelTextField(
                        label: 'Balance',
                        fontFamily: 'Bold',
                        textColor: AppColor.secondaryTextColor,
                        textSize: 16,
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 45,
                ),
                Container(
                  color: AppColor.secondaryLightColor,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        LabelTextField(
                          label: 'Personal Earning',
                          textColor: AppColor.secondaryTextColor,

                        ),
                        LabelTextField(
                          label:'${ _profileModel.wallet?.personalEarning ?? 0 }',
                          textColor: AppColor.secondaryTextColor,

                        ),
                      ],
                    ),
                  ),

                ),
                const SizedBox(
                  height: 60,
                ),
                Container(
                  color: AppColor.secondaryLightColor,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        LabelTextField(
                          label: 'Team Tree Earning',
                          textColor: AppColor.secondaryTextColor,

                        ),
                        LabelTextField(
                          label:'${ _profileModel.wallet?.teamEarning ?? 0}',
                          textColor: AppColor.secondaryTextColor,

                        ),
                      ],
                    ),
                  ),

                ),
                const SizedBox(
                  height: 60,
                ),
                Container(
                    color: AppColor.secondaryLightColor,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          LabelTextField(
                            label: 'Other Earning',
                            textColor: AppColor.secondaryTextColor,

                          ),
                          LabelTextField(
                            label:'${ _profileModel.wallet?.otherEarning ?? 0 }',
                            textColor: AppColor.secondaryTextColor,

                          ),
                        ],
                      ),
                    ),

                ),
              ],
            ),
          ),
        ],
      ),
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
                  setState(() {
                    _profileModel =
                        ProfileModel.fromJson(jsonDecode(_response.body));
                    globals.profileModel =
                        ProfileModel.fromJson(jsonDecode(_response.body));
                  }),
                }
              else
                {
                  Helpers.showAlertDialog('Something went wrong', context),
                }
            });
  }
}
