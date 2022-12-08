import 'package:flutter/material.dart';
import 'package:lux_global/ui/navigation.dart';
import 'package:lux_global/utility/helper.dart';

import '../component/back_navigation.dart';
import '../component/button.dart';
import '../component/label_text_field.dart';
import '../utility/app_color.dart';

class Verify extends StatefulWidget {
  const Verify({super.key});

  @override
  State<Verify> createState() => _VerifyState();
}

class _VerifyState extends State<Verify> {
  final FocusNode _focusDigit1 = FocusNode();
  final FocusNode _focusDigit2 = FocusNode();
  final FocusNode _focusDigit3 = FocusNode();
  final FocusNode _focusDigit4 = FocusNode();

  final TextEditingController _digit1Controller = TextEditingController();
  final TextEditingController _digit2Controller = TextEditingController();
  final TextEditingController _digit3Controller = TextEditingController();
  final TextEditingController _digit4Controller = TextEditingController();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _focusDigit1.dispose();
    _focusDigit2.dispose();
    _focusDigit3.dispose();
    _focusDigit4.dispose();
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

          children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const BackNavigation(),
                  Padding(
                    padding: EdgeInsets.only(
                        left: Helpers.screenSize(context).width / 3.5,top: 60),
                    child: LabelTextField(
                      alignment: Alignment.topCenter,
                      label: 'Verify',
                      textSize: 32.0,
                      textColor: AppColor.primaryTextColor,
                    ),
                  ),
                ],
              ),
               Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 60.0, vertical: 100),
                  child: Card(
                    elevation: 5.0,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5.0)),
                    shadowColor: AppColor.secondaryTextColor,
                    color: AppColor.primaryGrayColor,
                    child: Column(

                      children: [
                        const Padding(padding: EdgeInsets.only(top: 40.0)),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CodeInput(
                              focusNode0: _focusDigit1,
                              focusNode1: _focusDigit1,
                              focusNode2: _focusDigit2,
                              controller: _digit1Controller,
                            ),
                            SizedBox(
                              width: Helpers.screenSize(context).width * 0.03,
                            ),
                            CodeInput(
                              focusNode0: _focusDigit1,
                              focusNode1: _focusDigit2,
                              focusNode2: _focusDigit3,
                              controller: _digit2Controller,
                            ),
                            SizedBox(
                              width: Helpers.screenSize(context).width * 0.03,
                            ),
                            CodeInput(
                              focusNode0: _focusDigit2,
                              focusNode1: _focusDigit3,
                              focusNode2: _focusDigit4,
                              controller: _digit3Controller,
                            ),
                            SizedBox(
                              width: Helpers.screenSize(context).width * 0.03,
                            ),
                            CodeInput(
                              focusNode0: _focusDigit3,
                              focusNode1: _focusDigit4,
                              focusNode2: _focusDigit4,
                              controller: _digit4Controller,
                            ),

                          ],
                        ),

                        Padding(
                          padding: const EdgeInsets.only(
                              left: 70.0, right: 70.0, top: 50.0,bottom: 30),
                          child: Button(
                            onPressed: () {
                              Navigator.pushAndRemoveUntil<dynamic>(
                                context,
                                MaterialPageRoute<dynamic>(
                                  builder: (BuildContext context) => const Navigation(),
                                ),
                                    (route) => false,//if you want to disable back feature set to false
                              );


                            },
                            label: 'Verify',
                            fontFamily: 'Regular',
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

          ],
        ),
            )),
      ),
    );
  }
}

class CodeInput extends StatelessWidget {
  final FocusNode focusNode0;
  final FocusNode focusNode1;
  final FocusNode focusNode2;
  final TextEditingController controller;

  const CodeInput({
    Key? key,
    required this.focusNode0,
    required this.focusNode1,
    required this.focusNode2,
    required this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          width: Helpers.screenSize(context).width * 0.063,
          child: TextField(
            focusNode: focusNode1,
            keyboardType: TextInputType.number,
            textAlign: TextAlign.center,
            controller: controller,
            maxLength: 1,
            style: const TextStyle(
                color: AppColor.primaryColor, fontFamily: 'SemiBold'),
            onChanged: (str) {
              if (str.length == 1) {
                FocusScope.of(context).requestFocus(focusNode2);
              } else if (str.isEmpty) {
                FocusScope.of(context).requestFocus(focusNode0);
              }
            },
            decoration: const InputDecoration(
              hintText: "",
              hintStyle: TextStyle(color: AppColor.primaryColor),
              counterText: "",
            ),
          ),
        ),
      ],
    );
  }
}
