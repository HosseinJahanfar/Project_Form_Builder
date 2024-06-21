import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../const/shape/border_radius.dart';
import '../../../const/theme/colors.dart';

class TextFormMobileWidget extends StatelessWidget {
  final String labelText;
  final String name;
  final bool required;
  final String helper;
  final int maxLength;
  final String hintText;
  final String initialValue;
  final TextInputAction textInputAction;
  final FloatingLabelBehavior floatingLabelBehavior;
  final Function(String? value) func;

  const TextFormMobileWidget({
    super.key,
    required this.labelText,
    required this.name,
    required this.required,
    required this.helper,
    required this.textInputAction,
    required this.floatingLabelBehavior,
    required this.func,
    required this.maxLength,
    required this.hintText,
    required this.initialValue,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return FormBuilderTextField(
      name: name,
      textAlign: TextAlign.start,
      cursorColor: primary2Color,
      style: theme.textTheme.bodyMedium,
      inputFormatters: [
        FilteringTextInputFormatter.digitsOnly,
      ],
      maxLength: maxLength,
      initialValue: initialValue,
      textInputAction: textInputAction,
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.transparent,
        counter: const SizedBox.shrink(),
        contentPadding:
            EdgeInsets.symmetric(vertical: 10.sp, horizontal: 15.sp),
        floatingLabelBehavior: floatingLabelBehavior,
        labelText: labelText,
        labelStyle: TextStyle(
            fontWeight: FontWeight.bold,
            fontFamily: 'bold',
            fontSize: 12.sp,
            color: primary2Color),
        helperText: helper == '' ? null : helper,
        helperStyle: TextStyle(
          fontFamily: 'bold',
          fontWeight: FontWeight.bold,
          fontSize: 12.sp,
        ),
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
      validator: required
          ? (String? value) {
              if (value!.trim().isEmpty) {
                return 'این فیلد نمی تواند خالی باشد';
              }
              if (value.trim().length != 11) {
                return 'شماره همراه نادرست می باشد';
              }
              if (!value.startsWith('09')) {
                return 'شماره همراه نادرست می باشد';
              }
              if (value.isNotEmpty) {
                if (value[value.length - 1] != ' ') {
                  value = value;
                }
              }
              return null;
            }
          : null,
      onChanged: func,
    );
  }
}
