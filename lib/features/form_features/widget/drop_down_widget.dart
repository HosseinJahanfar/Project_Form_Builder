import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../const/shape/media_query.dart';
import '../../../const/theme/colors.dart';

class DropDownWidget extends StatelessWidget {
  final List<Map<String, dynamic>> options;
  final String label;
  final Function(dynamic)? func;

  const DropDownWidget({
    super.key,
    required this.options,
    required this.label,
    required this.func,
  });

  @override
  Widget build(BuildContext context) {
    List<DropdownMenuItem<String>> dropDownItems = options
        .map((option) => DropdownMenuItem<String>(
      value: option['value'],
      child: Text(option['label']),
    ))
        .toList();

    String? initialValue;
    for (var option in options) {
      if (option['selected'] == true) {
        initialValue = option['value'];
        break;
      }
    }

    return Padding(
      padding: EdgeInsets.symmetric(vertical: getWidth(context, 0.01)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontFamily: 'bold',
              fontSize: 14.sp,
            ),
          ),
          SizedBox(
            height: 10.sp,
          ),
          FormBuilderDropdown(
            name: 'dropdown', // Ensure this name is unique within the form
            onChanged: func,
            isDense: true,
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.0),
                borderSide: const BorderSide(color: primary2Color),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.0),
                borderSide: const BorderSide(color: primaryColor),
              ),
            ),
            initialValue: initialValue,
            items: dropDownItems,
          ),
        ],
      ),
    );
  }
}
