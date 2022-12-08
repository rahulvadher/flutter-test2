import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../utility/app_color.dart';

class Loader extends StatelessWidget {
  const Loader({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child:  SpinKitFadingCircle(
        color: AppColor.primaryColor,
      ),
    );
  }
}
