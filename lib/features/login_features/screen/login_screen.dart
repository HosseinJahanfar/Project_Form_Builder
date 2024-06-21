import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../const/shape/media_query.dart';
import '../../../const/string/key_data_base.dart';
import '../../../const/theme/colors.dart';
import '../../../route/names.dart';
import '../../public_features/functions/secure_storage.dart';
import '../../public_features/widget/snack_bar.dart';
import '../logic/bloc/login_bloc.dart';
import '../widget/custom_elevated_button_widget.dart';
import '../widget/text_field_widget.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController passController = TextEditingController();
  final _globalKey = GlobalKey<FormState>();
  bool isObscureTetx = false;

  @override
  void dispose() {
    passController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic> arguments =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    // print('************************************************');
    // print(arguments['phone_id']);
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
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
                          'assets/icons/login.svg',
                          width: getWidth(context, 0.8),
                        ),
                        SizedBox(
                          height: 10.sp,
                        ),
                        InputTextFormFieldWidget(
                          hintText: 'رمز عبور خود را وارد کنید.',
                          textInputAction: TextInputAction.done,
                          floatingLabelBehavior: FloatingLabelBehavior.auto,
                          controller: passController,
                          maxLength: 12,
                          textInputType: TextInputType.name,
                          perfixIcon: IconButton(
                              onPressed: () {
                                setState(() {
                                  isObscureTetx = !isObscureTetx;
                                });
                              },
                              icon: isObscureTetx
                                  ? const Icon(Icons.visibility_off)
                                  : const Icon(Icons.visibility)),
                          lableText: 'رمز عبور',
                          isObscureTetx: isObscureTetx,
                        ),
                        SizedBox(
                          height: 5.sp,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            onButtonInkWell('ورود با رمز یکبار مصرف', () {
                              //TODO Forget Password
                              BlocProvider.of<LoginBloc>(context).add(
                                  CallOtpLoginEvent(
                                      phone: arguments['phone_id']));
                              Navigator.pushNamedAndRemoveUntil(context,
                                  ScreenNames.otpScreen, (route) => false,
                                  arguments: {
                                    'phone_id': arguments['phone_id']
                                  });
                            }, primaryColor),
                          ],
                        )
                      ],
                    )),
                //!Submit Login
                Expanded(
                  flex: 1,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      BlocConsumer<LoginBloc, LoginState>(
                        listener: (context, state) async {
                          if (state is LoginErrorState) {
                            getSnackBarWidget(
                                context,
                                'رمز عبور خود را درست وارد نمایید.',
                                Colors.red);
                          }
                          if (state is LoginCompletedState) {
                            SecureStorageClass().saveUserToken(
                                KeyDataBase.token, state.loginModel.access);
                            SecureStorageClass().saveUserToken(
                                KeyDataBase.refreshToken,
                                state.loginModel.refresh);
                            getSnackBarWidget(context,
                                'شما با موفقیت احراز هویت شدید.', Colors.green);
                            Navigator.pushNamedAndRemoveUntil(context,
                                ScreenNames.formScreen, (route) => false);
                            passController.clear();
                          }
                        },
                        builder: (context, state) {
                          if (state is LoginLoadingState) {
                            return SpinKitWave(
                              color: primary2Color,
                              size: 30.0.sp,
                            );
                          }
                          return CustomElevatedButtonWidget(
                            func: () {
                              if (_globalKey.currentState!.validate()) {
                                BlocProvider.of<LoginBloc>(context).add(
                                    CallLoginEvent(
                                        phone: arguments['phone_id'],
                                        pass: passController.text.trim()));
                              }
                            },
                          );
                        },
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

//!onButtonInkWell
  InkWell onButtonInkWell(String lable, Function() func, Color bgcolor) {
    return InkWell(
      onTap: func,
      child: Text(
        lable,
        style: TextStyle(
            fontWeight: FontWeight.bold,
            color: bgcolor,
            fontFamily: 'bold',
            fontSize: 12.sp),
      ),
    );
  }
}
