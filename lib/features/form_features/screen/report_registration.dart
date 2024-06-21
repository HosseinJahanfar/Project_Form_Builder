import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/svg.dart';
import 'package:project_form_builder/features/form_features/model/form_list_model.dart';
import 'package:project_form_builder/features/form_features/widget/not_found_form_widget.dart';
import '../../../const/shape/media_query.dart';
import '../../../const/string/key_data_base.dart';
import '../../../const/theme/colors.dart';
import '../../../route/names.dart';
import '../../public_features/widget/snack_bar.dart';
import '../logic/report_list_form/report_form_bloc.dart';
import '../services/form_repository.dart';

class ReportRegistration extends StatelessWidget {
  const ReportRegistration({super.key});

  @override
  Widget build(BuildContext context) {

    return SafeArea(
        child: Scaffold(
            appBar: AppBar(
              elevation: 0,
              title: const Text(
                'گزارش فرم ها',
                style:
                    TextStyle(fontWeight: FontWeight.bold, fontFamily: 'bold'),
              ),
              centerTitle: true,
              actions: [
                IconButton(
                    onPressed: () {
                      Navigator.pushNamedAndRemoveUntil(
                          context, ScreenNames.mainScreen, (route) => false);
                    },
                    icon: const Icon(Icons.close))
              ],
            ),
            body: BlocProvider(
              create: (context) => ReportListFormBloc(FormRepository())
                ..add(CallReportFormEvent()),
              child: BlocBuilder<ReportListFormBloc, ReportListFormState>(
                builder: (context, state) {
                  if (state is ReportFormLoadingState) {
                    return const SpinKitFadingCircle(
                      color: primaryColor,
                    );
                  }
                  if (state is ReportFormCompletedState) {
                    return state.formListModel.isEmpty
                        ? const NotFoundFormWidget(
                            title: 'لیست گزارش فرم خالی می باشد!')
                        : CustomScrollView(
                            scrollDirection: Axis.vertical,
                            slivers: [
                              SliverList(
                                  delegate: SliverChildBuilderDelegate(
                                      childCount: state.formListModel.length,
                                      (context, index) {
                                return InkWell(
                                  onTap: () {
                                    KeyDataBase.activeForm =
                                        state.formListModel[index].id.toString();
                                    Navigator.pushNamedAndRemoveUntil(
                                        context,
                                        ScreenNames.reportScreen,
                                        (route) => false,
                                        arguments: {
                                          'form_id': state
                                              .formListModel[index].id
                                              .toString()
                                        });
                                  },
                                  child: Container(
                                    width: 50,
                                    height: 50,
                                    margin:
                                        EdgeInsets.symmetric(vertical: 2.5.sp),
                                    alignment: Alignment.center,
                                    child: Text(
                                      state.formListModel[index].title,
                                      style: TextStyle(
                                          fontSize: 16.sp,
                                          fontWeight: FontWeight.bold,
                                          fontFamily: 'bold'),
                                    ),
                                  ),
                                );
                              })),
                            ],
                          );
                  }
                  if (state is ReportFormErrorState) {
                    return getSnackBarWidget(
                        context, state.errorMsg.toString(), Colors.red);
                  }

                  return const SizedBox.shrink();
                },
              ),
            )));
  }
}
