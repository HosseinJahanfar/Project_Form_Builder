import 'package:flutter/material.dart';
import '../features/auth_features/screen/auth_screen.dart';
import '../features/form_features/screen/form_registration.dart';
import '../features/form_features/screen/form_screen.dart';
import '../features/form_features/screen/report_registration.dart';
import '../features/form_features/screen/report_screen.dart';
import '../features/form_features/widget/elevated_btn_upload_widget.dart';
import '../features/login_features/screen/login_screen.dart';
import '../features/login_features/screen/otp_screen.dart';
import '../features/main_features/screen/main_screen.dart';
import '../features/register_features/screen/register_screen.dart';
import '../features/splash_features/screen/splash_screen.dart';
import 'names.dart';

Map<String, Widget Function(BuildContext)> routes = {
  ScreenNames.splashScreen: (context) => const SplashScreen(),
  ScreenNames.loginScreen: (context) => const LoginScreen(),
  ScreenNames.registerScreen: (context) => const RegisterScreen(),
  ScreenNames.formScreen: (context) => FormScreen(
        isChecked: true,
      ),
  ScreenNames.authScreen: (context) => const AuthScreen(),
  ScreenNames.otpScreen: (context) => OtpScreen(),
  ScreenNames.mainScreen: (context) => const MainScreen(),
  ScreenNames.formRegistrationScreen: (context) => const FormRegistration(),
  ScreenNames.showFormRegistrationScreen: (context) =>
      FormScreen(isChecked: false),
  ScreenNames.reportListFormScreen: (context) => const ReportRegistration(),
  ScreenNames.reportScreen: (context) => const ReportScreen(),

};
