//!InputTextFieldPriceWidget
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../const/shape/border_radius.dart';
import '../../../const/shape/media_query.dart';
import '../../../const/theme/colors.dart';

class TextFormWidget extends StatelessWidget {
  const TextFormWidget({
    super.key,
    required this.name,
    required this.required,
    required this.hintText,
    required this.helper,
    required this.textInputAction,
    required this.floatingLabelBehavior,
    required this.maxLength,
    required this.textInputType,
    this.perfixIcon,
    required this.lableText,
    this.isObscureTetx = false,
    required this.func,
    required this.initialValue,
    required this.maxLines,
  });

  final String name;
  final String hintText;
  final bool required;
  final String helper;
  final TextInputAction textInputAction;
  final FloatingLabelBehavior floatingLabelBehavior;
  final int maxLength;
  final int maxLines;
  final String initialValue;
  final TextInputType textInputType;
  final Widget? perfixIcon;
  final String lableText;
  final bool isObscureTetx;
  final Function(String? value) func;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: getWidth(context, 0.02)),
      child: FormBuilderTextField(
        name: name,
        onChanged: func,
        keyboardType: textInputType,
        textAlign: TextAlign.start,
        maxLength: maxLength,
        obscureText: isObscureTetx,
        initialValue: initialValue,
        maxLines: maxLines,
        onEditingComplete: () {
          print('----------------------------');
          print("object");
        },
        validator: required
            ? (String? value) {
                if (value == null || value.trim().isEmpty) {
                  return 'این فیلد نمی تواند خالی باشد';
                }
                return null;
              }
            : null,
        textInputAction: textInputAction,
        decoration: InputDecoration(
          floatingLabelBehavior: floatingLabelBehavior,
          fillColor: Colors.transparent,
          filled: true,
          prefixIcon: perfixIcon,
          helperText: helper == '' ? null : helper,
          helperStyle: TextStyle(
            fontFamily: 'bold',
            fontWeight: FontWeight.bold,
            fontSize: 12.sp,
          ),
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
      ),
    );
  }
}
