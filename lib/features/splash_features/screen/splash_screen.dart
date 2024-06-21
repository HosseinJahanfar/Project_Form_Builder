import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../const/responsive.dart';
import '../../../const/shape/media_query.dart';
import '../../../const/string/key_data_base.dart';
import '../../../const/theme/colors.dart';
import '../../../route/names.dart';
import '../../public_features/widget/error_screen_widget.dart';
import '../logic/splash_bloc.dart';
import '../model/apps_model.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    context.read<SplashBloc>().add(CallSplashEvent());
  }

  @override
  Widget build(BuildContext context) {
    final isDesktop = Responsive.isDesktop(context);
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.white,
        body: BlocConsumer<SplashBloc, SplashState>(
          listener: (context, state) {
            if (state is SplashErrorState) {
              ErrorScreenWidget(
                  errorMsg: state.errorMsg.toString(),
                  function: () {
                    context.read<SplashBloc>().add(CallSplashEvent());
                  });
            }
            if (state is SplashCompletedState) {
              AppsModel appsModel = state.appsModel;
              KeyDataBase.activeForm=state.appsModel.configs!.activeform.toString();
              Future.delayed(
                const Duration(seconds: 2),
                () {
                  if (appsModel.configs!.authentication == true) {
                    Navigator.pushNamedAndRemoveUntil(
                        context, ScreenNames.authScreen, (route) => false);
                  } else {
                    Navigator.pushNamedAndRemoveUntil(
                        context, ScreenNames.formScreen, (route) => false);
                  }
                },
              );
            }
          },
          builder: (context, state) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircleAvatar(
                    backgroundColor: Colors.transparent,
                    radius: isDesktop
                        ? getWidth(context, 0.05)
                        : getWidth(context, 0.26),
                    child: SvgPicture.asset(
                      'assets/icons/form.svg',
                      width: isDesktop
                          ? getWidth(context, 0.05)
                          : getAllWidth(context),
                    ),
                  ),
                  SizedBox(
                    height: 30.sp,
                  ),
                  SpinKitFadingCube(
                    color: primary2Color,
                    size: 40.0.sp,
                  ),
                  SizedBox(
                    height: 30.sp,
                  ),
                  Text(
                    'Form Builder',
                    style: TextStyle(
                      color: primary2Color,
                      fontSize: isDesktop ? 14.sp : 18.sp,
                      fontFamily: 'bold',
                      fontWeight: FontWeight.bold,
                      letterSpacing: 5,
                    ),
                  ),
                  SizedBox(
                    height: 5.sp,
                  ),
                  Text(
                    'www.formbuilder.com',
                    style: TextStyle(
                      color: primary2Color,
                      fontSize: isDesktop ? 10.sp : 14.sp,
                      fontFamily: 'bold',
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
