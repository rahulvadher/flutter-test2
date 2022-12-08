import 'package:flutter/material.dart';

class IconView extends StatefulWidget {
  final String icon;
  final double height, width;
  final Color? color;
  final BoxFit boxFit;

  const IconView({
    super.key,
    required this.icon,
    this.height = 25.0,
    this.width = 25.0,
    this.color,
    this.boxFit=BoxFit.fill,
  });

  @override
  State<StatefulWidget> createState() => IconViewState();
}

class IconViewState extends State<IconView> {
  @override
  Widget build(BuildContext context) {
    return Image.asset(
      'assets/image/${widget.icon}',
      width: widget.width,
      height: widget.height,
      fit: widget.boxFit,
      color: widget.color,
    );

    /*Icon(
      widget.icon,
      size: widget.size,
      color: widget.color,
    );*/
  }
}
