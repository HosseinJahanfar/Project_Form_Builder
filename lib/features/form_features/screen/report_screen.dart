import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:project_form_builder/features/form_features/screen/render_ui_screen.dart';
import '../../../const/theme/colors.dart';
import '../../../route/names.dart';
import '../../public_features/widget/snack_bar.dart';
import '../logic/report_form/report_form_bloc.dart';
import '../services/report_form_repository.dart';

class ReportScreen extends StatelessWidget {
  const ReportScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic> arguments =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
            actions: [
              IconButton(
                  onPressed: () {
                    Navigator.pushNamedAndRemoveUntil(context,
                        ScreenNames.reportListFormScreen, (route) => false);
                  },
                  icon: const Icon(
                    Icons.close,
                    color: Colors.black,
                  ))
            ],
          ),
          resizeToAvoidBottomInset: true,
          body: BlocProvider(
            create: (context) => ReportFormBloc(ReportFormRepository())
              ..add(CallReportFormEvent(activeForm: arguments['form_id'])),
            child: BlocBuilder<ReportFormBloc, ReportFormState>(
              builder: (context, state) {
                if (state is ReportFormLoadingState) {
                  return SpinKitFadingCircle(
                    color: primary2Color,
                    size: 45.0.sp,
                  );
                }
                if (state is ReportFormCompletedState) {
                  return RenderUiWidget(
                    state: state,
                    isEdit: false,
                    dataId: arguments['form_id'].toString(),
                  );
                }
                if (state is ReportFormErrorState) {
                  return getSnackBarWidget(
                      context, state.errorMsg.toString(), Colors.red);
                }
                return const SizedBox.shrink();
              },
            ),
          )),
    );
  }
}
