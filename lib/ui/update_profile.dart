import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:image_picker/image_picker.dart';
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

class UpdateProfile extends StatefulWidget {
  const UpdateProfile({super.key});

  @override
  State<UpdateProfile> createState() => _UpdateProfileState();
}

class _UpdateProfileState extends State<UpdateProfile> {
  final TextEditingController _fnController = TextEditingController();
  final TextEditingController _lnController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _bdController = TextEditingController();
  late File _fileProfile;
  Response _response = Response('', 200);
  CommonModel _commonModel = CommonModel();
  LoginModel _loginModel = LoginModel();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(Duration.zero, () {
      _fnController.text = globals.profileModel?.userData?.firstName ?? '';
      _lnController.text = globals.profileModel?.userData?.lastName ?? '';
      _emailController.text = globals.profileModel?.userData?.email ?? '';
      _bdController.text = Helpers.changeDateFormat(
          globals.profileModel?.userData?.dob ?? '',
          'yyyy-MM-dd HH:mm:ss',
          'MM-dd-yyyy');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 30),
      margin: const EdgeInsets.only(top: 40),
      child: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage("assets/image/frame.png"), fit: BoxFit.fill),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 50),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
               GestureDetector(
                 onTap: (){
                   pickImage();
                 },
                 child: Wrap(
                   children: [
                     _fileProfile == null
                         ? const IconView(
                       icon: 'pic.png',
                       height: 50,
                       width: 50,
                     )
                         : SizedBox(
                       height: 80,
                       width: 80,
                       child: Image.file(
                         _fileProfile,
                         fit: BoxFit.fill,
                       ),
                     ),
                   ],
                 ),
               ),
                  const SizedBox(
                    width: 30,
                  ),
                  LabelTextField(
                    textSize: 16,
                    alignment: Alignment.topCenter,
                    label: 'Upload Profile Pic',
                  ),
                ],
              ),
              const SizedBox(
                height: 50,
              ),
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
              const Padding(padding: EdgeInsets.symmetric(vertical: 15.0)),
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
              const Padding(padding: EdgeInsets.symmetric(vertical: 15.0)),
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
              const Padding(padding: EdgeInsets.symmetric(vertical: 15.0)),
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
              Padding(
                padding:
                    const EdgeInsets.only(left: 0.0, right: 0.0, top: 30.0),
                child: Button(
                  onPressed: () {
                    if (_fnController.text.isEmpty) {
                      Helpers.showAlertDialog(
                          'Please enter first name', context);
                    } else if (_lnController.text.isEmpty) {
                      Helpers.showAlertDialog(
                          'Please enter last name', context);
                    } else if (_emailController.text.isEmpty) {
                      Helpers.showAlertDialog('Please enter email', context);
                    } else if (_bdController.text.isEmpty) {
                      Helpers.showAlertDialog('Please select DOB', context);
                    } else {
                      callUpdateProfile(_fileProfile);
                    }
                  },
                  label: 'Update Account',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }Future pickImage() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (image == null) return;
      final imageTemp = File(image.path);

          setState(() => _fileProfile = imageTemp);


    }  catch (e) {
      print('Failed to pick image: $e');
    }
  }

  Future<void> callUpdateProfile(File file) async {
    Helpers.shodLoader(context);
    var request = http.MultipartRequest(
        'POST', Uri.parse('https://swiftoro.in/luxglobalmarket/api/profileedit'));

    request.fields['id'] = '${globals.profileModel?.userData?.id.toString()}';
    request.fields['first_name'] = _fnController.text;
    request.fields['last_name'] = _lnController.text;
    request.fields['email'] = _emailController.text;
    request.fields['phone'] = '${globals.profileModel?.userData?.phone}';
    request.fields['username'] = '${globals.profileModel?.userData?.username}';
    request.fields['dob'] = Helpers.changeDateFormat(_bdController.text, 'dd-MM-yyyy', 'yyyy-MM-dd');

    request.files.add(await http.MultipartFile.fromPath('image', file.path));
    var response = await request.send();
    print('test ${response}');
    print('test ${response.statusCode}');
    final res = await http.Response.fromStream(response);
    print('test ${res.body}');
    _response = res;
    Navigator.pop(context);
    if (_response.statusCode == 200) {
      _commonModel = CommonModel.fromJson(jsonDecode(_response.body));
      Helpers.showAlertDialog(_commonModel.data?.message ?? '', context);
    }

  }
  /*

  void callUpdateProfile() {
    var bodyParam = {
      'id': globals.profileModel?.userData?.id,
      'first_name': _fnController.text,
      'last_name': _lnController.text,
      'email': _emailController.text,
      'phone': globals.profileModel?.userData?.phone,
      'username': globals.profileModel?.userData?.username,
      'image': globals.profileModel?.userData?.phone,
      'dob': Helpers.changeDateFormat(_bdController.text, 'dd-MM-yyyy', 'yyyy-MM-dd'),
    };
    NetworkService.postMethod('${Constants.apiUrl}profileedit', context,
            bodyParam: bodyParam, isShowLoader: true)
        .then((value) async => {
              _response = value,
              if (_response.statusCode == 200)
                {
                  _commonModel =
                      CommonModel.fromJson(jsonDecode(_response.body)),
                  if (_commonModel.data?.status == 1)
                    {}
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

  */
}
