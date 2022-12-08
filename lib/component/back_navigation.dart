import 'package:flutter/material.dart';

import 'Icon_view.dart';

class BackNavigation extends StatefulWidget {
  const BackNavigation({super.key});

  @override
  State<StatefulWidget> createState() => BackNavigationState();
}

class BackNavigationState extends State<BackNavigation> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pop(context);
      },
      child: const Padding(
        padding: EdgeInsets.only(top: 0.0,left: 15.0),
        child: IconView(
          icon: 'back.png',
        ),
      ),
    );
  }
}
