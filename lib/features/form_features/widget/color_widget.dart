import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

import '../../../const/shape/media_query.dart';
import 'elevated_btn_widget.dart';

class ColorPickerButton extends StatefulWidget {
   ColorPickerButton(
      {super.key, required this.lblBtn, required this.bgColor, required this.result});

  final String lblBtn;
  late Color bgColor;
  final Function(String res) result;
  @override
  State<ColorPickerButton> createState() => _ColorPickerButtonState();
}

class _ColorPickerButtonState extends State<ColorPickerButton> {
  Color tempColor = Colors.red;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          width: getWidth(context, 0.2),
          height: getWidth(context, 0.2),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: widget.bgColor,
          ),
        ),
        ElevatedButtonWidget(
          lable: widget.lblBtn,
          function: () {
            pickerColor(context);
          },
        )
      ],
    );
  }

  void pickerColor(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Pick your Color'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              buildColorPicker(),
              TextButton(
                onPressed: () {
                  setState(() {
                    widget.bgColor = tempColor;
                    printColorHex(tempColor);
                  });
                  Navigator.of(context).pop();
                },
                child: const Text(
                  'انتخاب رنگ',
                  style: TextStyle(
                      fontWeight: FontWeight.bold, fontFamily: 'bold'),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget buildColorPicker() => ColorPicker(
        pickerColor: tempColor,
        enableAlpha: false,
        onColorChanged: (value) {
          setState(() {
            tempColor = value;
          });
        },
      );

  void printColorHex(Color color) {
    String hexColor =
        '#${color.value.toRadixString(16).substring(2).toUpperCase()}';
    widget.result(hexColor);
  }
}
