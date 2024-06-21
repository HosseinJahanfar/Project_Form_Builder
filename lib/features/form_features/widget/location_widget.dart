import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geolocator/geolocator.dart';

import '../../../const/shape/border_radius.dart';
import '../../../const/shape/media_query.dart';
import '../../../const/theme/colors.dart';

class LocationWidget extends StatefulWidget {
  const LocationWidget({super.key, required this.title, required this.func});

  final String title;
  final Function(String value) func;

  @override
  State<LocationWidget> createState() => _LocationWidgetState();
}

class _LocationWidgetState extends State<LocationWidget> {
  String _locationMessage = "برای دریافت موقعیت مکانی دکمه را فشار دهید";

  void _getCurrentLocation() async {
    LocationPermission permission;
    permission = await Geolocator.requestPermission();

    if (permission == LocationPermission.denied) {
      setState(() {
        _locationMessage = "دسترسی به موقعیت مکانی رد شد";
      });
    } else if (permission == LocationPermission.deniedForever) {
      setState(() {
        _locationMessage = "دسترسی به موقعیت مکانی برای همیشه رد شد";
      });
    } else {
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
      setState(() {
        _locationMessage =
            "عرض جغرافیایی: ${position.latitude}، طول جغرافیایی: ${position.longitude}";
        widget.func('${position.latitude},${position.longitude}');
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
          _locationMessage,
          style: TextStyle(fontFamily: 'medium', fontSize: 12.sp),
        ),
        SizedBox(height: 5.sp),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            fixedSize: Size(getAllWidth(context), getWidth(context, 0.05)),
            shape:
                RoundedRectangleBorder(borderRadius: getBorderRadiusFunc(5.sp)),
            backgroundColor: primaryColor,
          ),
          onPressed: _getCurrentLocation,
          child: Text(
            widget.title,
            style: TextStyle(
              fontSize: 12.sp,
              color: Colors.white,
            ),
          ),
        ),
      ],
    );
  }
}
