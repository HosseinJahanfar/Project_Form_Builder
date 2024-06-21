import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:project_form_builder/const/shape/border_radius.dart';
import 'package:project_form_builder/const/shape/media_query.dart';
import 'package:project_form_builder/const/theme/colors.dart';
import '../logic/cubit_filepicker/file_picker_cubit.dart';

class ElevatedBtnUploadWidget extends StatelessWidget {
  const ElevatedBtnUploadWidget(
      {super.key,
      required this.title,
      required this.func,
      required this.value});

  final String title;
  final String value;
  final Function(String value) func;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => FilePickerCubit(),
      child: BlocBuilder<FilePickerCubit, FilePickerStateCubit>(
        builder: (context, state) {
          if (state is FilePickerInitialCubit) {
            return Column(
              children: [
                Text(
                  value,
                  style: const TextStyle(fontFamily: 'medium'),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    fixedSize:
                        Size(getAllWidth(context), getWidth(context, 0.05)),
                    shape: RoundedRectangleBorder(
                      borderRadius: getBorderRadiusFunc(5.sp),
                    ),
                    backgroundColor: primaryColor,
                  ),
                  onPressed: () {
                    context.read<FilePickerCubit>().pickFile();
                  },
                  child: Text(
                    title,
                    style: TextStyle(
                      fontFamily: 'bold',
                      fontSize: 12.sp,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            );
          } else if (state is FilePickerLoadingStateCubit) {
            return SpinKitFadingCircle(
              color: primary2Color,
              size: 35.0.sp,
            );
          } else if (state is FilePickerCompletedStateCubit) {
            func(state.responseUploadFile.file.toString());
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(state.responseUploadFile.file.toString()),
                SizedBox(
                  height: 5.sp,
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    fixedSize:
                        Size(getAllWidth(context), getWidth(context, 0.05)),
                    shape: RoundedRectangleBorder(
                      borderRadius: getBorderRadiusFunc(5.sp),
                    ),
                    backgroundColor: primaryColor,
                  ),
                  onPressed: () {
                    context.read<FilePickerCubit>().reset();
                  },
                  child: Text(
                    'انتخاب فایل دیگر',
                    style: TextStyle(
                      fontFamily: 'bold',
                      fontSize: 12.sp,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            );
          } else if (state is FilePickerErrorStateCubit) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  state.errorMessage.toString(),
                  style: const TextStyle(fontFamily: 'medium'),
                ),
                SizedBox(
                  height: 5.sp,
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    fixedSize:
                        Size(getAllWidth(context), getWidth(context, 0.05)),
                    shape: RoundedRectangleBorder(
                      borderRadius: getBorderRadiusFunc(5.sp),
                    ),
                    backgroundColor: primaryColor,
                  ),
                  onPressed: () {
                    context.read<FilePickerCubit>().reset();
                  },
                  child: Text(
                    'دوباره تلاش کنید',
                    style: TextStyle(
                      fontFamily: 'bold',
                      fontSize: 12.sp,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            );
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
}
