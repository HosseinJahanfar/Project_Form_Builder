import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../const/theme/colors.dart';
import '../../../route/names.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: primaryColor,
                      fixedSize: const Size(200, 50)),
                  onPressed: () {
                    Navigator.pushNamedAndRemoveUntil(context,
                        ScreenNames.formRegistrationScreen, (route) => false);
                  },
                  child: Text(
                    'ثبت فرم',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 16.sp,
                        fontWeight: FontWeight.bold),
                  )),
              SizedBox(
                height: 15.sp,
              ),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: primaryColor,
                      fixedSize: const Size(200, 50)),
                  onPressed: () {
                    Navigator.pushNamedAndRemoveUntil(context,
                        ScreenNames.reportListFormScreen, (route) => false);
                  },
                  child: Text(
                    'گزارش فرم',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 16.sp,
                        fontWeight: FontWeight.bold),
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
