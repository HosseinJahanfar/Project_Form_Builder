import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/svg.dart';
import '../../../const/shape/border_radius.dart';
import '../../../const/shape/media_query.dart';
import '../../../const/string/key_data_base.dart';
import '../../../const/theme/colors.dart';
import '../../../route/names.dart';
import '../../login_features/widget/text_field_widget.dart';
import '../../public_features/functions/secure_storage.dart';
import '../../public_features/widget/snack_bar.dart';
import '../logic/bloc/register_bloc.dart';
import '../services/register_repositroy.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool isObscureText = false;

  @override
  void dispose() {
    _fullNameController.dispose();
    _emailController.dispose();
    _passController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // RegisterApiServices().callRegisterApi('098765', '8888', 'AliHosseini');
    final Map<String, dynamic> arguments =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Container(
          width: getAllWidth(context),
          padding: EdgeInsets.symmetric(horizontal: getWidth(context, 0.05)),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                Expanded(
                    flex: 5,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SvgPicture.asset(
                          'assets/icons/register.svg',
                          width: getWidth(context, 0.8),
                        ),
                        SizedBox(
                          height: 12.5.sp,
                        ),
                        InputTextFormFieldWidget(
                          hintText: 'نام و نام خانوادگی خود را وارد کنید.',
                          textInputAction: TextInputAction.done,
                          floatingLabelBehavior: FloatingLabelBehavior.auto,
                          controller: _fullNameController,
                          maxLength: 12,
                          textInputType: TextInputType.name,
                          perfixIcon: const Icon(Icons.person),
                          lableText: 'نام و نام خانوداگی',
                          isObscureTetx: false,
                        ),
                        SizedBox(
                          height: 10.sp,
                        ),
                        InputTextFormFieldWidget(
                          hintText: 'ایمیل خود را وارد کنید.',
                          textInputAction: TextInputAction.done,
                          floatingLabelBehavior: FloatingLabelBehavior.auto,
                          controller: _emailController,
                          maxLength: 30,
                          textInputType: TextInputType.name,
                          perfixIcon: const Icon(Icons.person),
                          lableText: 'ایمیل',
                          isObscureTetx: false,
                        ),
                        SizedBox(
                          height: 10.sp,
                        ),
                        InputTextFormFieldWidget(
                          hintText: 'رمز عبور خود را وارد کنید.',
                          textInputAction: TextInputAction.done,
                          floatingLabelBehavior: FloatingLabelBehavior.auto,
                          controller: _passController,
                          maxLength: 12,
                          textInputType: TextInputType.name,
                          perfixIcon: IconButton(
                              onPressed: () {
                                setState(() {
                                  isObscureText = !isObscureText;
                                });
                              },
                              icon: isObscureText
                                  ? const Icon(Icons.visibility_off)
                                  : const Icon(Icons.visibility)),
                          lableText: 'رمز عبور',
                          isObscureTetx: isObscureText,
                        ),
                      ],
                    )),
                //!Submit Login
                Expanded(
                  flex: 1,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      BlocProvider(
                        create: (context) => RegisterBloc(RegisterRepository()),
                        child: BlocConsumer<RegisterBloc, RegisterState>(
                          listener: (context, state) {
                            if (state is RegisterErrorState) {
                              getSnackBarWidget(
                                  context, state.erorr.toString(), Colors.red);
                            }
                            if (state is RegisterCompletedState) {
                              SecureStorageClass().saveUserToken(
                                  KeyDataBase.token,
                                  state.registerModel.accessToken);
                              SecureStorageClass().saveUserToken(
                                  KeyDataBase.refreshToken,
                                  state.registerModel.refreshToken);
                              Navigator.pushNamedAndRemoveUntil(context,
                                  ScreenNames.formScreen, (route) => false);
                              getSnackBarWidget(
                                  context,
                                  'اطلاعات شما با موفقیت ثبت شد.',
                                  Colors.green);
                              _fullNameController.clear();
                              _emailController.clear();
                              _passController.clear();
                            }
                          },
                          builder: (context, state) {
                            if (state is RegisterLoadingState) {
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
                                  if (_formKey.currentState!.validate()) {
                                    BlocProvider.of<RegisterBloc>(context).add(
                                        CallRegisterEvent(
                                            phone: arguments['phone_id'],
                                            password:
                                                _passController.text.trim(),
                                            fullName:
                                                _fullNameController.text.trim(),
                                            email:
                                                _emailController.text.trim()));
                                  }
                                },
                                child: Text(
                                  'ثبت اطلاعات',
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
