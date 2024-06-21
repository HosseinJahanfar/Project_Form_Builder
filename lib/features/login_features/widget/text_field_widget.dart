//!InputTextFieldPriceWidget
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../const/shape/border_radius.dart';
import '../../../const/theme/colors.dart';

class InputTextFormFieldWidget extends StatelessWidget {
  const InputTextFormFieldWidget({
    super.key,
    required this.hintText,
    required this.textInputAction,
    required this.floatingLabelBehavior,
    required this.controller,
    required this.maxLength,
    required this.textInputType,
    required this.perfixIcon,
    required this.lableText,
    this.isObscureTetx = false,
  });

  final String hintText;
  final TextInputAction textInputAction;
  final FloatingLabelBehavior floatingLabelBehavior;
  final TextEditingController controller;
  final int maxLength;
  final TextInputType textInputType;
  final Widget perfixIcon;
  final String lableText;
  final bool isObscureTetx;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: textInputType,
      textAlign: TextAlign.start,
      maxLength: maxLength,
      obscureText: isObscureTetx,
      validator: (String? value) {
        if (value!.trim().isEmpty) {
          return 'این فیلد نمی تواند خالی باشد';
        }
        return null;
      },
      textInputAction: textInputAction,
      decoration: InputDecoration(
        floatingLabelBehavior: floatingLabelBehavior,
        fillColor: Colors.transparent,
        filled: true,
        prefixIcon: perfixIcon,
        contentPadding:
            EdgeInsets.symmetric(vertical: 10.sp, horizontal: 15.sp),
        labelText: lableText,
        labelStyle: TextStyle(
            fontWeight: FontWeight.bold,
            fontFamily: 'bold',
            fontSize: 12.sp,
            color: primary2Color),
        hintText: hintText,
        counter: const SizedBox.shrink(),
        border: OutlineInputBorder(
          borderRadius: getBorderRadiusFunc(5.sp),
          borderSide: const BorderSide(width: 1, color: primaryColor),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: getBorderRadiusFunc(5.sp),
          borderSide: const BorderSide(width: 2, color: primaryColor),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: getBorderRadiusFunc(5.sp),
          borderSide: BorderSide(width: 1, color: Colors.grey.shade300),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: getBorderRadiusFunc(5.sp),
          borderSide: const BorderSide(width: 1, color: Colors.red),
        ),
      ),
    );
  }
}
