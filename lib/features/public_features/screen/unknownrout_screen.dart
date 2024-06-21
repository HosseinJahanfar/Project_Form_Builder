import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/svg.dart';
import '../../../const/responsive.dart';
import '../../../const/shape/media_query.dart';
import '../../../const/theme/colors.dart';

class UnKnowRoutScreen extends StatelessWidget {
  const UnKnowRoutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              'assets/icons/notconnect.svg',
              width: getWidth(context, 0.6),
              placeholderBuilder: (context) {
                return const SpinKitFadingCircle(
                  color: primaryColor,
                );
              },
            ),
            SizedBox(
              height: 10.sp,
            ),
            Text(
              'صفحه مورد نظر پیدا نشد!',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontFamily: 'bold',
                fontSize: Responsive.isDesktop(context) ? 10.sp : 16.sp,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
