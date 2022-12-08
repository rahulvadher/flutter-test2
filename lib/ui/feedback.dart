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

class FeedbackForm extends StatefulWidget {
  const FeedbackForm({super.key});

  @override
  State<FeedbackForm> createState() => _FeedbackState();
}

class _FeedbackState extends State<FeedbackForm> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _messageController = TextEditingController();
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
                      label: 'Feedback',
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
                        _titleController.selection = TextSelection.fromPosition(
                          TextPosition(offset: _titleController.text.length),
                        );
                      },
                      labelText: 'Title',
                      textFieldController: _titleController,
                      icon1: const IconView(
                        icon: 'info.png',
                        color: AppColor.primaryColor,
                      ),
                    ),
                    const Padding(
                        padding: EdgeInsets.symmetric(vertical: 15.0)),
                    TextInput(
                      onChanged: (text) {
                        _nameController.selection = TextSelection.fromPosition(
                          TextPosition(offset: _nameController.text.length),
                        );
                      },
                      labelText: 'Name',
                      textFieldController: _nameController,
                      icon1: const IconView(
                        icon: 'user.png',
                        color: AppColor.primaryColor,
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
                        color: AppColor.primaryColor,
                      ),
                    ),
                    const Padding(
                        padding: EdgeInsets.symmetric(vertical: 15.0)),
                    TextInput(
                      onChanged: (text) {
                        _phoneController.selection = TextSelection.fromPosition(
                          TextPosition(offset: _phoneController.text.length),
                        );
                      },
                      labelText: 'Mobile No',
                      textFieldController: _phoneController,
                      textInputType: TextInputType.number,
                      icon1: const IconView(
                        icon: 'call.png',
                        color: AppColor.primaryColor,
                      ),
                    ),
                    const Padding(
                        padding: EdgeInsets.symmetric(vertical: 15.0)),
                    TextInput(

                        maxLine: 6,
                        minLine: 6,
                        textInputLength: 1000,
                        onChanged: (text) {
                          _messageController.selection = TextSelection.fromPosition(
                            TextPosition(offset: _messageController.text.length),
                          );
                        },
                        labelText: 'Message',

                        textFieldController: _messageController,
                        action: TextInputAction.done,


                    ),

                    Padding(
                      padding: const EdgeInsets.only(
                          left: 0.0, right: 0.0, top: 20.0),
                      child: Button(
                        onPressed: () {
                          if (_titleController.text.isEmpty) {
                            Helpers.showAlertDialog(
                                'Please enter title', context);
                          } else if (_nameController.text.isEmpty) {
                            Helpers.showAlertDialog(
                                'Please enter name', context);
                          } else if (_emailController.text.isEmpty) {
                            Helpers.showAlertDialog(
                                'Please enter email', context);
                          }
                          else if (_phoneController.text.isEmpty) {
                            Helpers.showAlertDialog(
                                'Please enter mobile number', context);
                          }




                          else if (_messageController.text.isEmpty) {
                            Helpers.showAlertDialog(
                                'Please enter message', context);
                          }
                          else {
                            callFeedback();
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

  void callFeedback() {
    var bodyParam = {
      'id': globals.profileModel?.userData?.id,
      'name': _nameController.text,
      'title': _titleController.text,
      'description': _messageController.text,
      'email': _emailController.text,
      'phone': _phoneController.text,
    };
    NetworkService.postMethod(
            '${Constants.apiUrl}feedback',
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
