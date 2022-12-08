import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:lux_global/model/task_model.dart';
import 'package:lux_global/utility/helper.dart';
import '../component/Icon_view.dart';
import '../component/label_text_field.dart';
import '../utility/app_color.dart';
import '../utility/constants.dart';
import '../utility/globals.dart' as globals;
import '../utility/network_service.dart';

class DailyTask extends StatefulWidget {
  const DailyTask({super.key});

  @override
  State<DailyTask> createState() => _DailyTaskState();
}

class _DailyTaskState extends State<DailyTask> {
  Response _response = Response('', 200);
  TaskModel _taskModel = TaskModel();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    Future.delayed(Duration.zero, () {
      callDailyTask();
    });
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: EdgeInsets.zero,
      itemCount: _taskModel.data?.length ?? 0,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        Data singleItem = _taskModel.data![index];
        return Stack(
          children: [
            SizedBox(
              height: 200,
              width: Helpers.screenSize(context).width,
              child: Card(
                  semanticContainer: true,
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  elevation: 3.0,
                  margin: const EdgeInsets.all(20),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0)),
                  shadowColor: AppColor.secondaryTextColor,
                  child: Stack(
                    children: [
                      SizedBox(
                        height: 200,
                        width: Helpers.screenSize(context).width,
                        child: Image.network(
                          singleItem.image ?? '',
                          fit: BoxFit.cover,
                        ),
                      ),
                      SizedBox(
                        height: 200,
                        width: Helpers.screenSize(context).width,
                        child: const IconView(
                          icon: 'blur.png',
                          boxFit: BoxFit.fitWidth,
                        ),
                      ),
                    ],
                  )),
            ),
            Positioned(

              bottom: 50,
              child: Padding(
                padding: EdgeInsets.only(left: Helpers.screenSize(context).width/6),
                child: Row(
                  children: [
                    const IconView(
                      icon: 'timer.png',
                      height: 20,
                      width: 20,
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    LabelTextField(
                      label:
                          '${Helpers.changeDateFormat(singleItem.startTime ?? '', 'HH:mm:ss', 'HH:mm:ss aa')} to '
                          '${Helpers.changeDateFormat(singleItem.endTime ?? '', 'HH:mm:ss', 'HH:mm:ss aa')}',
                      textSize: 20,
                      fontFamily: 'Bold',
                      textColor: AppColor.primaryTextColor,
                    ),
                  ],
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  void callDailyTask() {
    NetworkService.postMethod('${Constants.apiUrl}dailytask', context,
            isShowLoader: true)
        .then((value) async => {
              _response = value,
              if (_response.statusCode == 200)
                {
                  setState(() {
                    _taskModel = TaskModel.fromJson(jsonDecode(_response.body));
                  }),
                }
            });
  }
}
