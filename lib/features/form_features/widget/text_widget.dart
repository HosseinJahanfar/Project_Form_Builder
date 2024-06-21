import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../const/shape/media_query.dart';

//!TitleWidgetForm
class TitleWidget extends StatelessWidget {
  const TitleWidget({super.key, required this.title, required this.fontSize});

  final String title;
  final double fontSize;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: getWidth(context, 0.01)),
      child: Text(
        title.isEmpty ? '' : title,
        style: TextStyle(
            color: Colors.black,
            fontSize: fontSize.sp,
            fontWeight: FontWeight.bold,
            fontFamily: 'bold'),
      ),
    );
  }
}

//!ParagraphWidget
class ParagraphWidget extends StatelessWidget {
  const ParagraphWidget({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: getWidth(context, 0.01)),
      child: Text(
        title,
        style: TextStyle(
            color: Colors.black,
            fontSize: 12.sp,
            fontWeight: FontWeight.normal,
            fontFamily: 'normal'),
      ),
    );
  }
}
