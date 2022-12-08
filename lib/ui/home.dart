import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:lux_global/model/member_model.dart';
import 'package:lux_global/utility/helper.dart';

import '../component/Icon_view.dart';
import '../component/label_text_field.dart';
import '../model/profile_model.dart';
import '../utility/app_color.dart';
import '../utility/constants.dart';
import '../utility/network_service.dart';
import '../utility/globals.dart' as globals;

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Response _response = Response('', 200);
  MemberModel _memberModel = MemberModel();

  @override
  void initState() {
    // TODO: implement initState
    callMember();
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: Card(
                    semanticContainer: true,
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    child: Padding(
                      padding: const EdgeInsets.all(12),
                      child: Wrap(
                        direction: Axis.vertical,
                        children: [
                          LabelTextField(
                            label: 'Company Statistics\n',
                            textSize: 16,
                            textColor: AppColor.secondaryTextColor,
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          const IconView(
                            icon: 'clipboard.png',
                            height: 50,
                            width: 50,
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          LabelTextField(
                            label: _memberModel.data?.companyTatistics ?? '',
                            textSize: 18,
                            fontFamily: 'Bold',
                          ),
                        ],
                      ),
                    )),
              ),
              const SizedBox(width: 20,),
              Expanded(
                child: Card(
                    semanticContainer: true,
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    child: Padding(
                      padding: const EdgeInsets.all(12),
                      child: Wrap(
                        direction: Axis.vertical,
                        children: [
                          LabelTextField(
                            label: 'Joining Date\n',
                            textSize: 16,
                            textColor: AppColor.secondaryTextColor,
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          const IconView(
                            icon: 'calendar_1.png',
                            height: 50,
                            width: 50,
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          LabelTextField(
                            label:_memberModel.data?.joiningDate!=null? Helpers.changeDateFormat(_memberModel.data?.joiningDate ?? '', 'yyyy-MM-dd HH:mm:ss', 'MM-dd-yyyy'):'',
                            textSize: 18,
                            fontFamily: 'Bold',
                          ),
                        ],
                      ),
                    )),
              ),
            ],
          ),
          const SizedBox(height: 10,),
          Row(
            children: [
              Expanded(
                child: Card(
                    semanticContainer: true,
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    child: Padding(
                      padding: const EdgeInsets.all(12),
                      child: Wrap(
                        direction: Axis.vertical,
                        children: [
                          LabelTextField(
                            label: 'Total Count of Team\nMembers',

                            textSize: 16,
                            textColor: AppColor.secondaryTextColor,
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          const IconView(
                            icon: 'team.png',
                            height: 50,
                            width: 50,
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          LabelTextField(
                            label: _memberModel.data?.totalMember ?? '',
                            textSize: 18,
                            fontFamily: 'Bold',
                          ),
                        ],
                      ),
                    )),
              ),
              const SizedBox(width: 20,),
              Expanded(
                child: Card(
                    semanticContainer: true,
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    child: Padding(
                      padding: const EdgeInsets.all(12),
                      child: Wrap(
                        direction: Axis.vertical,
                        children: [
                          LabelTextField(
                            label: 'Total Active Members\n',
                            textSize: 16,
                            textColor: AppColor.secondaryTextColor,
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          const IconView(
                            icon: 'leader.png',
                            height: 50,
                            width: 50,
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          LabelTextField(
                            label: _memberModel.data?.totalActiveMember ?? '',
                            textSize: 18,
                            fontFamily: 'Bold',
                          ),
                        ],
                      ),
                    )),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void callMember() {
    Helpers.saveStringSF('accessToken',
        globals.profileModel?.userData?.id?? '');
    var bodyParam = {
      'id': globals.profileModel?.userData?.id,
    };
    NetworkService.postMethod('${Constants.apiUrl}homescreen', context,
            bodyParam: bodyParam, isShowLoader: false)
        .then((value) async => {
              _response = value,
              if (_response.statusCode == 200)
                {
                  setState(() {
                    _memberModel =
                        MemberModel.fromJson(jsonDecode(_response.body));
                  }),
                }
            });
  }
}
