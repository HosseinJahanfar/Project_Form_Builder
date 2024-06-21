import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:project_form_builder/features/form_features/screen/render_ui_screen.dart';
import '../../../const/string/key_data_base.dart';
import '../../../const/theme/colors.dart';
import '../../../route/names.dart';
import '../../public_features/widget/snack_bar.dart';
import '../logic/form_builder_bloc.dart';
import '../services/form_repository.dart';
import '../widget/not_found_form_widget.dart';

class FormScreen extends StatelessWidget {
  FormScreen({super.key, required this.isChecked});

  bool isChecked = true;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
            actions: [
              IconButton(
                  onPressed: () {
                    isChecked
                        ? Navigator.pushNamedAndRemoveUntil(
                            context, ScreenNames.mainScreen, (route) => false)
                        : Navigator.pushNamedAndRemoveUntil(
                            context,
                            ScreenNames.formRegistrationScreen,
                            (route) => false);
                  },
                  icon: const Icon(
                    Icons.close,
                    color: Colors.black,
                  ))
            ],
          ),
          resizeToAvoidBottomInset: true,
          body: BlocProvider(
            create: (context) => FormBuilderBloc(FormRepository())
              ..add(CallFormBuilderEvent(activeForm: KeyDataBase.activeForm)),
            child: BlocBuilder<FormBuilderBloc, FormBuilderState>(
              builder: (context, state) {
                if (state is FormBuilderLoadingState) {
                  return SpinKitFadingCircle(
                    color: primary2Color,
                    size: 45.0.sp,
                  );
                }
                if (state is FormBuilderCompletedState) {
                  if (state.formModel.status!) {
                    return RenderUiWidget(
                      state: state,
                      isEdit: true,
                    );
                  } else {
                    return const NotFoundFormWidget(
                      title: 'فرمی مورد نظر یافت نشد!',
                    );
                  }
                }
                if (state is FormBuilderErrorState) {
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
