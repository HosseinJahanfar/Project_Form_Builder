import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/svg.dart';
import '../../../const/shape/media_query.dart';
import '../../../const/theme/colors.dart';

class NotFoundFormWidget extends StatelessWidget {
  const NotFoundFormWidget({
    super.key, required this.title,
  });
  final String title;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: getAllWidth(context),
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
           title,
            style: TextStyle(
                fontSize: 18.sp,
                fontFamily: 'bold',
                ),
          )
        ],
      ),
    );
  }
}