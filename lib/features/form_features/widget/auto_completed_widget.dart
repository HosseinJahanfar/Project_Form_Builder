import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../const/shape/border_radius.dart';
import '../../../const/theme/colors.dart';
import '../model/autocomplated_model.dart';

class AutoCompletedWidget extends StatelessWidget {
  const AutoCompletedWidget(
      {super.key,
        required this.dataList,
        required this.name,
        required this.hintText,
        required this.required,
        required this.helper,
        required this.textInputAction,
        required this.floatingLabelBehavior,
        required this.textInputType,
        required this.lableText,
        required this.func});

  final List<Values> dataList;
  final String name;
  final String hintText;
  final bool required;
  final String helper;
  final TextInputAction textInputAction;
  final FloatingLabelBehavior floatingLabelBehavior;
  final TextInputType textInputType;
  final String lableText;
  final Function(dynamic)? func;

  @override
  Widget build(BuildContext context) {
    // پیدا کردن مقدار انتخاب شده
    final selectedValue = dataList.firstWhere(
          (element) => element.selected ?? false,
      orElse: () => Values(value: ''),
    ).value ?? '';

    return Column(
      children: [
        Autocomplete<Values>(
          initialValue: TextEditingValue(text: selectedValue),
          optionsBuilder: (textEditingValue) {
            if (textEditingValue.text.isEmpty) {
              return List.empty();
            } else {
              return dataList.where((element) => element.value!
                  .toLowerCase()
                  .contains(textEditingValue.text.toLowerCase()));
            }
          },
          displayStringForOption: (Values option) => option.value!,
          onSelected: (Values selection) {
            debugPrint(selection.value);
            func!(selection.value);
          },
          fieldViewBuilder:
              (context, textEditingController, focusNode, onFieldSubmitted) {
            return FormBuilderTextField(
              name: name,
              controller: textEditingController,
              focusNode: focusNode,
              onEditingComplete: onFieldSubmitted,
              validator: required
                  ? (String? value) {
                if (value == null || value.trim().isEmpty) {
                  return 'این فیلد نمی تواند خالی باشد';
                }
                return null;
              }
                  : null,
              decoration: InputDecoration(
                floatingLabelBehavior: floatingLabelBehavior,
                fillColor: Colors.transparent,
                filled: true,
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
            );
          },
          optionsViewBuilder: (context, onSelected, options) {
            return Material(
              child: ListView.separated(
                  padding: EdgeInsets.symmetric(
                      vertical: 20.0.sp, horizontal: 20.sp),
                  itemBuilder: (context, index) {
                    final val = options.elementAt(index);
                    return ListTile(
                      title: Text(val.value!),
                      onTap: () => onSelected(val),
                    );
                  },
                  separatorBuilder: (context, index) => const Divider(),
                  itemCount: options.length),
            );
          },
        ),
      ],
    );
  }
}
