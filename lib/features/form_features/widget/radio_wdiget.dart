import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../const/theme/colors.dart';

//!RadioGroupWidget
class RadioGroupWidget extends StatelessWidget {
  RadioGroupWidget(
      {super.key,
      required this.options,
      required this.lable,
      this.func,
      required this.initialValue,
      required this.name,
      required this.orientation,
      required this.helper,
      required this.isRequired});

  final List<Map<String, dynamic>> options;
  final String lable;
  final String name;
  final Function(dynamic)? func;
  final List<dynamic> initialValue;
  final List<String> isChecked = [];
  final bool orientation;
  final String helper;
  final bool isRequired;

  @override
  Widget build(BuildContext context) {
    List<FormBuilderFieldOption<dynamic>> fieldOptions = options
        .map(
          (option) => FormBuilderFieldOption(
            value: option['value'],
            child: Text(option['label']),
          ),
        )
        .toList();

    for (var element in options) {
      if (element.values.contains(true)) {
        isChecked.add(element.values.toList()[1]);
      }
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          lable,
          style: TextStyle(
              fontFamily: 'bold', fontWeight: FontWeight.bold, fontSize: 14.sp),
        ),
        FormBuilderRadioGroup<dynamic>(
          name: name,
          onChanged: func,
          initialValue: isChecked.isNotEmpty ? isChecked.first : null,
          options: fieldOptions,
          activeColor: primaryColor,
          decoration: InputDecoration(
            border: InputBorder.none,
            helperText: helper == '' ? null : helper,
            helperMaxLines: 1,
            helperStyle: TextStyle(
              fontFamily: 'bold',
              fontWeight: FontWeight.bold,
              fontSize: 12.sp,
            ),
          ),
          orientation: orientation
              ? OptionsOrientation.horizontal
              : OptionsOrientation.vertical,
          validator: isRequired
              ? (value) {
                  if (value == null || value.isEmpty) {
                    return 'حداقل یک گزینه را انتخاب کنید';
                  }
                  return null;
                }
              : null,
        ),
      ],
    );
  }
}
