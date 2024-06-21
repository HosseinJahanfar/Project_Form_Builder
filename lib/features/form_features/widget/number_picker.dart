import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../const/shape/media_query.dart';
import '../../../const/theme/colors.dart';

class NumberInputWithIncrementDecrement extends StatefulWidget {
  const NumberInputWithIncrementDecrement({
    super.key,
    required this.title,
    required this.required,
    required this.name,
    required this.min,
    required this.max,
    required this.step,
    required this.initialValue, required this.func,
  });

  final String name;
  final String title;
  final bool required;
  final int min;
  final int max;
  final int step;
  final String initialValue;
  final Function(String? value) func;

  @override
  State<NumberInputWithIncrementDecrement> createState() =>
      _NumberInputWithIncrementDecrementState();
}

class _NumberInputWithIncrementDecrementState
    extends State<NumberInputWithIncrementDecrement> {
  final TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    _controller.text = widget.initialValue;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: getWidth(context, 0.01)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.title,
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 14.sp,
                fontFamily: 'bold'),
          ),
          SizedBox(
            height: 10.sp,
          ),
          SizedBox(
            width: getAllWidth(context),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: getWidth(context, 0.4),
                  foregroundDecoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5.0),
                    border: Border.all(
                      color: primary2Color,
                    ),
                  ),
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        flex: 6,
                        child: FormBuilderTextField(
                          name: widget.name,
                          onChanged:widget.func,
                          validator: widget.required
                              ? (value) {
                                  if (value!.isEmpty) {
                                    return 'لطفاً مقداری وارد کنید';
                                  }
                                  final intValue = int.tryParse(value);
                                  if (intValue == null ||
                                      intValue < widget.min ||
                                      intValue > widget.max) {
                                    return 'مقدار باید بین ${widget.min} و ${widget.max} باشد';
                                  }
                                  return null; // اگر هیچ مشکلی نداشته باشد، مقدار `null` برگردانید.
                                }
                              : null,
                          style: TextStyle(
                              color: primary2Color,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'bold',
                              fontSize: 14.sp),
                          enabled: true,
                          textDirection: TextDirection.ltr,
                          cursorColor: primaryColor,
                          textAlign: TextAlign.center,
                          decoration: InputDecoration(
                            labelStyle: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontFamily: 'bold',
                                fontSize: 12.sp,
                                color: primary2Color),
                            focusedBorder: const OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: primaryColor, width: 2)),
                            contentPadding: const EdgeInsets.all(8.0),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5.0),
                            ),
                          ),
                          controller: _controller,
                          keyboardType: const TextInputType.numberWithOptions(
                            decimal: false,
                            signed: true,
                          ),
                          inputFormatters: <TextInputFormatter>[
                            FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                          ],
                        ),
                      ),
                      Expanded(
                        flex: 0,
                        child: SizedBox(
                          height: 38.0,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Container(
                                decoration: const BoxDecoration(
                                  border: Border(
                                    bottom: BorderSide(
                                      width: 0.5,
                                    ),
                                  ),
                                ),
                                child: InkWell(
                                  child: const Icon(
                                    Icons.arrow_drop_up,
                                    size: 18.0,
                                  ),
                                  onTap: () {
                                    int currentValue =
                                        int.parse(_controller.text);
                                    setState(() {
                                      currentValue += widget.step;
                                      if (currentValue > widget.max) {
                                        currentValue = widget.max;
                                      }
                                      _controller.text = currentValue
                                          .toString(); // incrementing value
                                    });
                                  },
                                ),
                              ),
                              InkWell(
                                child: const Icon(
                                  Icons.arrow_drop_down,
                                  size: 18.0,
                                ),
                                onTap: () {
                                  int currentValue =
                                      int.parse(_controller.text);
                                  setState(() {
                                    currentValue -= widget.step;
                                    if (currentValue < widget.min) {
                                      currentValue = widget.min;
                                    }
                                    _controller.text = currentValue
                                        .toString(); // decrementing value
                                  });
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
