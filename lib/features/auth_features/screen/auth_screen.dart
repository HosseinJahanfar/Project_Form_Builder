import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/svg.dart';
import '../../../const/shape/border_radius.dart';
import '../../../const/shape/media_query.dart';
import '../../../const/theme/colors.dart';
import '../../../route/names.dart';
import '../../public_features/widget/mobile_textfield.dart';
import '../../public_features/widget/snack_bar.dart';
import '../logic/auth_bloc.dart';
import '../services/auth_repository.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<AuthScreen> {
  final TextEditingController phoneController = TextEditingController();
  final _globalKey = GlobalKey<FormState>();

  @override
  void dispose() {
    phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        body: Container(
          width: getAllWidth(context),
          padding: EdgeInsets.symmetric(horizontal: getWidth(context, 0.05)),
          child: Form(
            key: _globalKey,
            child: Column(
              children: [
                Expanded(
                    flex: 5,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SvgPicture.asset(
                          'assets/icons/auth.svg',
                          width: getAllWidth(context),
                        ),
                        SizedBox(
                          height: 10.sp,
                        ),
                        Text(
                          'ورود به فرم بیلدر',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontFamily: 'bold',
                              fontSize: 18.sp),
                        ),
                        SizedBox(
                          height: 10.sp,
                        ),
                        Text(
                          'به فرم بیلدر خوش آمدید! امیدوارم تجربه‌ی شما در این اپلیکیشن لذت بخش و مفید باشه.',
                          style:
                              TextStyle(fontFamily: 'medium', fontSize: 12.sp),
                          textAlign: TextAlign.justify,
                        ),
                        SizedBox(
                          height: 15.sp,
                        ),
                        TextFormFieldMobileWidget(
                            labelText: 'شماره موبایل',
                            icon: const Icon(Icons.phone_android_outlined),
                            textInputAction: TextInputAction.next,
                            floatingLabelBehavior: FloatingLabelBehavior.auto,
                            controller: phoneController),
                      ],
                    )),
                //!Submit Login
                Expanded(
                  flex: 1,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      BlocProvider(
                        create: (context) => AuthBloc(AuthRepository()),
                        child: BlocConsumer<AuthBloc, AuthState>(
                          listener: (context, state) {
                            if (state is AuthErrorState) {
                              getSnackBarWidget(context,
                                  state.errorMessage.toString(), Colors.red);
                            }
                            if (state is AuthCompletedState) {
                              if (state.userStatus) {
                                Navigator.pushNamedAndRemoveUntil(context,
                                    ScreenNames.loginScreen, (route) => false,
                                    arguments: {
                                      'phone_id': phoneController.text.trim()
                                    });
                              } else {
                                Navigator.pushNamedAndRemoveUntil(
                                    context,
                                    ScreenNames.registerScreen,
                                    (route) => false,
                                    arguments: {
                                      'phone_id': phoneController.text.trim()
                                    });
                              }
                            }
                          },
                          builder: (context, state) {
                            if (state is AuthLoadingState) {
                              return SpinKitWave(
                                color: primary2Color,
                                size: 30.0.sp,
                              );
                            }
                            return ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    backgroundColor: primaryColor,
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            getBorderRadiusFunc(5.sp)),
                                    fixedSize: Size(getAllWidth(context),
                                        getWidth(context, 0.10))),
                                onPressed: () async {
                                  if (_globalKey.currentState!.validate()) {
                                    BlocProvider.of<AuthBloc>(context).add(
                                        CallAuthEvent(
                                            phoneNumber:
                                                phoneController.text.trim()));
                                  }
                                },
                                child: Text(
                                  'ورود',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: 'bold',
                                      fontSize: 14.sp),
                                ));
                          },
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
