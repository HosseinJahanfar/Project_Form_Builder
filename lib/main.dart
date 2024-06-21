import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:project_form_builder/route/names.dart';
import 'package:project_form_builder/route/routes.dart';
import 'features/login_features/logic/bloc/login_bloc.dart';
import 'features/login_features/services/login_repository.dart';
import 'features/public_features/functions/preload_svg.dart';
import 'features/public_features/screen/unknownrout_screen.dart';
import 'features/splash_features/logic/splash_bloc.dart';
import 'features/splash_features/services/splash_repository.dart';

void main() async {
  //SSL
  HttpOverrides.global = MyHttpOverrides();

  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.white,
      statusBarIconBrightness: Brightness.dark,
      systemNavigationBarColor: Colors.white,
      systemNavigationBarIconBrightness: Brightness.dark));
  WidgetsFlutterBinding.ensureInitialized();
  await preloadSVGs(
    [
      'assets/icons/login.svg',
      'assets/icons/form.svg',
      'assets/icons/notconnect.svg',
      'assets/icons/register.svg',
      'assets/icons/auth.svg'
    ],
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => LoginBloc(LoginRepository()),
          ),
          BlocProvider(
            create: (context) => SplashBloc(SplashRepository()),
          ),
        ],
        child: MaterialApp(
          localizationsDelegates: const [
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: const [Locale('fa')],
          title: 'Form Builder',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
            useMaterial3: true,
          ),
          onUnknownRoute: (settings) => MaterialPageRoute(
            builder: (context) => const UnKnowRoutScreen(),
          ),
          initialRoute: ScreenNames.splashScreen,
          routes: routes,
        ),
      ),
    );
  }
}

//!SSL
class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}
