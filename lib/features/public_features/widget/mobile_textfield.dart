import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../const/shape/border_radius.dart';
import '../../../const/theme/colors.dart';

class TextFormFieldMobileWidget extends StatelessWidget {
  final String labelText;
  final TextInputAction textInputAction;
  final FloatingLabelBehavior floatingLabelBehavior;
  final TextEditingController controller;
  final Widget? icon;

  const TextFormFieldMobileWidget({
    super.key,
    required this.labelText,
    required this.icon,
    required this.textInputAction,
    required this.floatingLabelBehavior,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return TextFormField(
      textAlign: TextAlign.start,
      cursorColor: primary2Color,
      style: theme.textTheme.bodyMedium,
      inputFormatters: [
        FilteringTextInputFormatter.digitsOnly,
      ],
      maxLength: 11,
      textInputAction: textInputAction,
      keyboardType: TextInputType.number,
      minLines: 1,
      controller: controller,
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.transparent,
        counter: const SizedBox.shrink(),
        prefixIcon: icon,
        contentPadding:
            EdgeInsets.symmetric(vertical: 10.sp, horizontal: 15.sp),
        floatingLabelBehavior: floatingLabelBehavior,
        labelText: labelText,
        labelStyle:TextStyle(
            fontWeight: FontWeight.bold,
            fontFamily: 'bold',
            fontSize: 12.sp,
            color: primary2Color),
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
      
      validator: (String? value) {
        if (value!.trim().isEmpty) {
          return 'این فیلد نمی تواند خالی باشد';
        }
        if (value.trim().length != 11) {
          return 'شماره همراه نادرست می باشد';
        }
        if (!value.startsWith('09')) {
          return 'شماره همراه نادرست می باشد';
        }
        return null;
      },
      onTap: () {
        if (controller.text.isNotEmpty) {
          if (controller.text[controller.text.length - 1] != ' ') {
            controller.text = (controller.text);
          }
          if (controller.selection ==
              TextSelection.fromPosition(
                  TextPosition(offset: controller.text.length - 1))) {}
        }
      },
    );
  }
}
