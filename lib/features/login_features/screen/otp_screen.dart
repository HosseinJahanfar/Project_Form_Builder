import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import '../../../const/shape/border_radius.dart';
import '../../../const/shape/media_query.dart';
import '../../../const/string/key_data_base.dart';
import '../../../const/theme/colors.dart';
import '../../../route/names.dart';
import '../../public_features/functions/secure_storage.dart';
import '../../public_features/widget/error_screen_widget.dart';
import '../../public_features/widget/snack_bar.dart';
import '../logic/bloc/login_bloc.dart';
import '../widget/custom_elevated_button_widget.dart';

class OtpScreen extends StatelessWidget {
  OtpScreen({super.key});

  final TextEditingController authController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic> arguments =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;

    return Scaffold(
      body: Directionality(
        textDirection: TextDirection.ltr,
        child: BlocConsumer<LoginBloc, LoginState>(
          listener: (context, state) {
            if (state is LoginErrorState) {
              ErrorScreenWidget(
                  errorMsg: state.error.toString(),
                  function: () {
                    BlocProvider.of<LoginBloc>(context)
                        .add(CallOtpLoginEvent(phone: arguments['phone_id']));
                  });
            }
            if (state is LoginSendOtpCompletedState) {
              getSnackBarWidget(
                  context, state.successMsg.toString(), Colors.green);
            }
          },
          builder: (context, state) {
            return Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 24.sp),
                    child: PinCodeTextField(
                      appContext: context,
                      controller: authController,
                      length: 6,
                      cursorHeight: 20,
                      enableActiveFill: true,
                      keyboardType: TextInputType.number,
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'لطفا کد را وارد کنید';
                        }
                        if (value.length != 6) {
                          return 'کد باید شامل ۶ رقم باشد';
                        }

                        return null;
                      },
                      textStyle: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontFamily: 'bold',
                          fontSize: 16.sp),
                      pinTheme: PinTheme(
                        shape: PinCodeFieldShape.box,
                        fieldWidth: 50,
                        inactiveColor: Colors.grey,
                        selectedColor: Colors.blue,
                        activeFillColor: Colors.blue.shade100,
                        selectedFillColor: Colors.blue.shade100,
                        inactiveFillColor: Colors.grey.shade200,
                        borderWidth: 1,
                        borderRadius: BorderRadius.circular(12.sp),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10.sp,
                  ),
                  OutlinedButton(
                      style: OutlinedButton.styleFrom(
                          backgroundColor: primaryColor,
                          side: BorderSide.none,
                          shape: RoundedRectangleBorder(
                            borderRadius: getBorderRadiusFunc(5.sp),
                          )),
                      onPressed: () {
                        BlocProvider.of<LoginBloc>(context)
                            .add(CallOtpLoginEvent(phone: arguments['phone_id']));
                      },
                      child: Text(
                        'دریافت مجدد کد',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontFamily: 'bold',
                            fontSize: 12.sp,
                            color: Colors.white),
                      )),
                  SizedBox(
                    height: 10.sp,
                  ),
                  Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: getWidth(context, 0.05)),
                      child: BlocConsumer<LoginBloc, LoginState>(
                        listener: (context, state) {
                          if (state is LoginErrorState) {
                            getSnackBarWidget(context,
                                'کد دریافتی صحیح نمی باشد.', Colors.red);
                          }
                          if (state is LoginVerifyCompletedState) {
                            SecureStorageClass().saveUserToken(
                                KeyDataBase.token, state.otpModel.accessToken);
                            SecureStorageClass().saveUserToken(
                                KeyDataBase.refreshToken,
                                state.otpModel.refreshToken);
                            getSnackBarWidget(context,
                                'شما با موفقیت احراز هویت شدید.', Colors.green);
                            Navigator.pushNamedAndRemoveUntil(context,
                                ScreenNames.formScreen, (route) => false);
                          }
                        },
                        builder: (context, state) {
                          if (state is LoginLoadingState) {
                            return SpinKitWave(
                              color: primary2Color,
                              size: 45.0.sp,
                            );
                          }
                          return CustomElevatedButtonWidget(func: () {
                            if (_formKey.currentState!.validate()) {
                              BlocProvider.of<LoginBloc>(context).add(
                                  CallVerifyOtpLoginEvent(
                                      phone: arguments['phone_id'],
                                      code: authController.text.trim()));
                            }
                          });
                        },
                      ))
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
