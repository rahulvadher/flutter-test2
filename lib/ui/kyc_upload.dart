import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lux_global/model/common_model.dart';
import 'package:lux_global/model/task_model.dart';
import 'package:lux_global/utility/helper.dart';
import 'package:path_provider/path_provider.dart';
import '../component/Icon_view.dart';
import '../component/button.dart';
import '../component/label_text_field.dart';
import '../model/profile_model.dart';
import '../utility/app_color.dart';
import '../utility/constants.dart';
import '../utility/globals.dart' as globals;
import '../utility/network_service.dart';
import 'package:pdf/pdf.dart';
import 'package:http/http.dart' as http;
import 'package:pdf/widgets.dart' as pw;

class KycUpload extends StatefulWidget {
  const KycUpload({super.key});

  @override
  State<KycUpload> createState() => _KycUploadState();
}

class _KycUploadState extends State<KycUpload> {
  bool _adharVisible = false, _panVisible = false;
  File? _filePAN, _fileAdhar_1, _fileAdhar_2;
  Response _response = Response('', 200);
  CommonModel _commonModel = CommonModel();
  final pdf = pw.Document();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15),
      child: Wrap(
        children: [
          LabelTextField(
            alignment: Alignment.center,
            label: 'Proof of identity',
            textSize: 24,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 20),
            child: LabelTextField(
              alignment: Alignment.center,
              textAlign: TextAlign.center,
              label:
                  'In order to completed your registration Please upload a copy of your identity',
              textColor: AppColor.secondaryTextColor,
            ),
          ),
          LabelTextField(
            alignment: Alignment.center,
            label: 'Choose Your Identity Type',
            textSize: 16,
            textColor: AppColor.secondaryColor,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 30),
            child: GestureDetector(
              onTap: () {
                setState(() {
                  _adharVisible = true;
                  _panVisible = false;
                });
              },
              child: IconView(
                icon: 'upload_1.png',
                height: 100,
                width: Helpers.screenSize(context).width,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 0),
            child: GestureDetector(
              onTap: () {
                setState(() {
                  _adharVisible = false;
                  _panVisible = true;
                });

              },
              child: IconView(
                icon: 'upload_2.png',
                height: 100,
                width: Helpers.screenSize(context).width,
              ),
            ),
          ),
          const SizedBox(
            height: 130,
          ),
          if (_adharVisible)
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Stack(
                  children: [
                    GestureDetector(
                      onTap: () {
                        pickImage(1);
                      },
                      child: Card(
                        semanticContainer: true,
                        clipBehavior: Clip.antiAliasWithSaveLayer,
                        elevation: 5.0,
                        shape: RoundedRectangleBorder(
                            side: const BorderSide(
                                color: AppColor.primaryColor, width: 1),
                            borderRadius: BorderRadius.circular(10.0)),
                        shadowColor: AppColor.primaryColor,
                        child: Padding(
                          padding: const EdgeInsets.only(
                              top: 30, bottom: 10, left: 5, right: 5),
                          child: _fileAdhar_1 == null
                              ? const IconView(
                                  icon: 'aadhar.jpg',
                                  height: 150,
                                  width: 150,
                                )
                              : SizedBox(
                                  height: 150,
                                  width: 150,
                                  child: Image.file(
                                    _fileAdhar_1!,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                        ),
                      ),
                    ),
                    Positioned(
                      top: 10,
                      right: 10,
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            _fileAdhar_1 = null;
                            if (_fileAdhar_1 == null && _fileAdhar_2 == null) {
                              _adharVisible = false;
                            }
                          });
                        },
                        child: const IconView(
                          icon: 'close.png',
                          height: 20,
                          width: 20,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  width: 30,
                ),
                Stack(
                  children: [
                    GestureDetector(
                      onTap: () {
                        pickImage(2);
                      },
                      child: Card(
                        semanticContainer: true,
                        clipBehavior: Clip.antiAliasWithSaveLayer,
                        elevation: 5.0,
                        shape: RoundedRectangleBorder(
                            side: const BorderSide(
                                color: AppColor.primaryColor, width: 1),
                            borderRadius: BorderRadius.circular(10.0)),
                        shadowColor: AppColor.primaryColor,
                        child: Padding(
                          padding: const EdgeInsets.only(
                              top: 30, bottom: 10, left: 5, right: 5),
                          child: _fileAdhar_2 == null
                              ? const IconView(
                                  icon: 'aadhar.jpg',
                                  height: 150,
                                  width: 150,
                                )
                              : SizedBox(
                                  height: 150,
                                  width: 150,
                                  child: Image.file(
                                    _fileAdhar_2!,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                        ),
                      ),
                    ),
                    Positioned(
                      top: 10,
                      right: 10,
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            _fileAdhar_2 = null;
                            if (_fileAdhar_1 == null && _fileAdhar_2 == null) {
                              _adharVisible = false;
                            }
                          });
                        },
                        child: const IconView(
                          icon: 'close.png',
                          height: 20,
                          width: 20,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          if (_panVisible)
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Stack(
                  children: [
                    GestureDetector(
                      onTap: () {
                        pickImage(3);
                      },
                      child: Card(
                        semanticContainer: true,
                        clipBehavior: Clip.antiAliasWithSaveLayer,
                        elevation: 5.0,
                        shape: RoundedRectangleBorder(
                            side: const BorderSide(
                                color: AppColor.primaryColor, width: 1),
                            borderRadius: BorderRadius.circular(10.0)),
                        shadowColor: AppColor.primaryColor,
                        child: Padding(
                          padding: const EdgeInsets.only(
                              top: 30, bottom: 10, left: 5, right: 5),
                          child: _filePAN == null
                              ? const IconView(
                                  icon: 'pan.png',
                                  height: 150,
                                  width: 150,
                                )
                              : SizedBox(
                                  height: 150,
                                  width: 150,
                                  child: Image.file(
                                    _filePAN!,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                        ),
                      ),
                    ),
                    Positioned(
                      top: 10,
                      right: 10,
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            _filePAN = null;
                            _panVisible = false;
                          });
                        },
                        child: const IconView(
                          icon: 'close.png',
                          height: 20,
                          width: 20,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          Padding(
            padding: const EdgeInsets.only(left: 5.0, right: 5.0, top: 30.0),
            child: Button(
              onPressed: () {
                if (!_panVisible && !_adharVisible) {
                  Helpers.showAlertDialog(
                      'Please choose identity type', context);
                  return;
                } else if (_adharVisible &&
                    _fileAdhar_1 == null &&
                    _fileAdhar_2 == null) {
                  Helpers.showAlertDialog(
                      'Please upload both side of Adhar identity', context);
                  return;
                } else if (_panVisible && _filePAN == null) {
                  Helpers.showAlertDialog(
                      'Please upload PAN identity', context);
                  return;
                } else {
                  try {
                    if (_panVisible && _filePAN != null) {
                      createPDF(_filePAN!);
                    } else if (_adharVisible &&
                        _fileAdhar_1 != null &&
                        _fileAdhar_2 != null) {
                      createPDF(_fileAdhar_1!);
                      createPDF(_fileAdhar_2!);
                    }

                    savePDF();
                  } catch (e) {
                    print('catch ${e.toString()}');
                  }
                }
              },
              label: 'Upload Documents',
            ),
          ),
        ],
      ),
    );
  }

  createPDF(File file) async {
    final image = pw.MemoryImage(file.readAsBytesSync());
    pdf.addPage(pw.Page(
        pageFormat: PdfPageFormat.a4,
        build: (pw.Context contex) {
          return pw.Center(child: pw.Image(image));
        }));
  }

  savePDF() async {
    try {
      final dir = await getExternalStorageDirectory();
      final file =
          File('${dir?.path}/${globals.profileModel?.userData?.username}.pdf');
      await file.writeAsBytes(await pdf.save());
      callKyc(file);
    } catch (e) {
      print('catch ${e.toString()}');
    }
  }

  Future<void> callKyc(File file) async {
    Helpers.shodLoader(context);
    var request = http.MultipartRequest(
        'POST', Uri.parse('https://swiftoro.in/luxglobalmarket/api/kyc'));

    request.fields['id'] = '${globals.profileModel?.userData?.id.toString()}';
    request.files.add(await http.MultipartFile.fromPath('file', file.path));
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

  Future pickImage(int index) async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (image == null) return;
      final imageTemp = File(image.path);
      switch (index) {
        case 1:
          setState(() => _fileAdhar_1 = imageTemp);
          break;
        case 2:
          setState(() => _fileAdhar_2 = imageTemp);
          break;
        case 3:
          setState(() => _filePAN = imageTemp);
          break;
      }
    } on PlatformException catch (e) {
      print('Failed to pick image: $e');
    }
  }
}

