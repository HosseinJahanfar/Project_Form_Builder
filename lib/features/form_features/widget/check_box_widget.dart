import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../const/shape/media_query.dart';
import '../../../const/theme/colors.dart';

class CheckBoxGroupWidget extends StatelessWidget {
  final List<Map<String, dynamic>> options;
  final String lable;
  final Function(List<dynamic>? value) func;
  final String name;
  final bool required;
  final String helper;
  final List<dynamic> initialValue;
  final bool orientation;

  CheckBoxGroupWidget(
      {super.key,
      required this.options,
      required this.lable,
      required this.func,
      required this.name,
      required this.required,
      required this.helper,
      required this.initialValue,
      required this.orientation});

  final List<String> isChecked = [];

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

    return Padding(
      padding: EdgeInsets.symmetric(vertical: getWidth(context, 0.03)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            lable,
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontFamily: 'bold',
                fontSize: 14.sp),
          ),
          FormBuilderCheckboxGroup(
            validator: required
                ? (value) {
                    if (value == null || value.isEmpty) {
                      return 'حداقل یک گزینه را انتخاب کنید';
                    }
                    return null;
                  }
                : null,
            name: name,
            onChanged: func,
            activeColor: primaryColor,
            decoration: InputDecoration(
                border: InputBorder.none,
                helperText: helper == '' ? null : helper,
                helperStyle: TextStyle(
                  fontFamily: 'bold',
                  fontWeight: FontWeight.bold,
                  fontSize: 12.sp,
                ),
                helperMaxLines: 1),
            //  initialValue: initialValue,
            initialValue: isChecked,
            options: fieldOptions,
            orientation: orientation
                ? OptionsOrientation.vertical
                : OptionsOrientation.horizontal,
          ),
        ],
      ),
    );
  }
}
