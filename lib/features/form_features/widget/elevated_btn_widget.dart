import 'package:flutter/material.dart';

import '../../../const/shape/border_radius.dart';
import '../../../const/shape/media_query.dart';
import '../../../const/theme/colors.dart';

class ElevatedButtonWidget extends StatelessWidget {
  const ElevatedButtonWidget(
      {super.key, required this.lable, required this.function});

  final String lable;
  final Function() function;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: getWidth(context, 0.02)),
      child: ElevatedButton(
          style: ElevatedButton.styleFrom(
              elevation: 0,
              fixedSize: Size(getWidth(context, 0.5), getWidth(context, 0.05)),
              shape:
                  RoundedRectangleBorder(borderRadius: getBorderRadiusFunc(5)),
              backgroundColor: primaryColor),
          onPressed: function,
          child: Text(
            lable,
            style: const TextStyle(
                fontFamily: 'bold',
                color: Colors.white,
                fontWeight: FontWeight.bold),
          )),
    );
  }
}
