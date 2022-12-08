import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:http/http.dart';
import 'package:lux_global/ui/navigation.dart';
import 'package:lux_global/utility/helper.dart';

import '../component/back_navigation.dart';
import '../component/button.dart';
import '../component/label_text_field.dart';
import '../model/common_model.dart';
import '../utility/app_color.dart';
import '../utility/constants.dart';
import '../utility/network_service.dart';
import '../utility/globals.dart' as globals;

class Web extends StatefulWidget {
  String endPoint;

  Web({super.key, required this.endPoint});

  @override
  State<Web> createState() => _WebState();
}

class _WebState extends State<Web> {
  Response _response = Response('', 200);
  CommonModel _commonModel = CommonModel();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(Duration.zero, () {
      callWeb();
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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const BackNavigation(),
              Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Html(
                    data: _commonModel.data?.content ?? '',
                  )),
            ],
          ),
        )),
      ),
    );
  }

  void callWeb() {
    var bodyParam = {'id': globals.profileModel?.userData?.id};
    NetworkService.postMethod('${Constants.apiUrl}${widget.endPoint}', context,
            bodyParam: bodyParam, isShowLoader: true)
        .then((value) async => {
              _response = value,
              if (_response.statusCode == 200)
                {
                  _commonModel =
                      CommonModel.fromJson(jsonDecode(_response.body)),
                  if (_commonModel.data?.status == 1)
                    {setState(() {})}
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
