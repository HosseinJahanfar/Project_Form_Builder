import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import '../../../const/responsive.dart';
import '../../../const/shape/media_query.dart';

class ErrorScreenWidget extends StatelessWidget {
  const ErrorScreenWidget(
      {super.key, required this.errorMsg, required this.function});

  final String errorMsg;
  final Function function;

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SvgPicture.asset(
          'assets/icons/login.svg',
          width: getWidth(context, 0.6),
        ),
        SizedBox(height: 20.sp),
        Text(
          errorMsg,
          style: TextStyle(
            fontFamily: 'medium',
            fontSize: 16.sp,
          ),
          textAlign: TextAlign.center,
        ),
        SizedBox(height: 15.sp),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            fixedSize: Size(
              getWidth(context, 0.5),
              Responsive.isTablet(context) ? 60 : 45,
            ),
          ),
          onPressed: () => function(),
          child: Text(
            'تلاش مجدد',
            style: TextStyle(
              fontFamily: 'bold',
              fontSize: 14.sp,
            ),
          ),
        )
      ],
    ));
  }
}
