import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

class CustomDateField extends StatefulWidget {
  final String? initialDate;
  final String label;
  final String description;
  final String placeholder;
  final Function(String value) func;

  const CustomDateField(
      {super.key,
        this.initialDate,
        required this.label,
        required this.description,
        required this.placeholder,
        required this.func});

  @override
  _CustomDateFieldState createState() => _CustomDateFieldState();
}

class _CustomDateFieldState extends State<CustomDateField> {
  DateTime? _selectedDate;

  @override
  void initState() {
    super.initState();
    if (widget.initialDate != null) {
      _selectedDate = DateTime.parse(widget.initialDate!);
    }
  }

  final _formKey = GlobalKey<FormState>();

  void _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? DateTime.now(),
      firstDate: DateTime(2020, 1),
      lastDate: DateTime(2030, 12),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
        widget.func(DateFormat('yyyy-MM-dd').format(_selectedDate!));
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            widget.label,
            style: TextStyle(fontSize: 14.sp, fontFamily: 'medium'),
          ),
          SizedBox(height: 5.sp),
          Text(
            widget.description,
            style: TextStyle(fontSize: 12.sp, fontFamily: 'medium'),
          ),
          SizedBox(height: 10.sp),
          GestureDetector(
            onTap: () => _selectDate(context),
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 15.w),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5.sp),
                border: Border.all(color: Colors.grey),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    _selectedDate == null
                        ? widget.placeholder
                        : DateFormat('yyyy-MM-dd').format(_selectedDate!),
                    style: TextStyle(fontSize: 14.sp),
                  ),
                  Icon(Icons.calendar_today, size: 20.sp),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
