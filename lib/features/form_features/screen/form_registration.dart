import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:project_form_builder/features/form_features/services/form_api_services.dart';
import '../../../const/string/key_data_base.dart';
import '../../../const/theme/colors.dart';
import '../../../route/names.dart';
import '../../public_features/widget/snack_bar.dart';
import '../logic/list_form/list_form_bloc.dart';
import '../services/form_repository.dart';
import '../widget/not_found_form_widget.dart';

class FormRegistration extends StatelessWidget {
  const FormRegistration({super.key});

  @override
  Widget build(BuildContext context) {
    // FormApiServices().callEditSendDataForm(
    //     '1',
    //     '[{"type": "text", "subtype": "text", "required": false, "label": "نام", "description": null, "placeholder": null, "className": "form-control", "name": "text-1716214457439-0", "value": null, "maxlength": null}, {"type": "text", "subtype": "text", "required": true, "label": "نام خانوادگی", "description": null, "placeholder": null, "className": "form-control", "name": "text-1716214459201-0", "value": "a", "maxlength": null}, {"type": "text", "subtype": "text", "required": false, "label": "Text Field", "description": "توضیحات", "placeholder": null, "className": "form-control", "name": "text-1716214492662", "value": null, "maxlength": null}, {"type": "select", "required": false, "label": "Select", "description": null, "placeholder": null, "className": "form-control", "name": "select-1716214466980-0", "multiple": false, "values": [{"label": "Option 1", "value": "option-1", "selected": true}, {"label": "Option 2", "value": "option-2", "selected": false}, {"label": "Option 3", "value": "option-3", "selected": false}]}, {"type": "text", "subtype": "color", "required": false, "label": "Text Field", "description": null, "placeholder": null, "className": "form-control", "name": "text-1716215179830-0", "value": null, "maxlength": null}, {"type": "number", "subtype": "number", "required": true, "label": "سن", "description": null, "placeholder": null, "className": "form-control", "name": "number-1716214468688-0", "value": null, "min": 0, "max": 10, "step": 2}, {"type": "button", "label": "Button", "subtype": "button", "className": "btn-default btn", "name": "button-1716214463253-0", "value": null, "style": "default"}]',
    //     '77');
    return SafeArea(
        child: Scaffold(
            appBar: AppBar(
              elevation: 0,
              title: const Text(
                'لیست فرم ها',
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
              create: (context) =>
                  ListFormBloc(FormRepository())..add(CallListFormEvent()),
              child: BlocBuilder<ListFormBloc, ListFormState>(
                builder: (context, state) {
                  if (state is ListFormLoadingState) {
                    return const SpinKitFadingCircle(
                      color: primaryColor,
                    );
                  }
                  if (state is ListFormCompletedState) {
                    return state.formListModel.isEmpty
                        ? const NotFoundFormWidget(
                            title: 'لیست ثبت فرم خالی می باشد!')
                        : CustomScrollView(
                            scrollDirection: Axis.vertical,
                            slivers: [
                              SliverList(
                                  delegate: SliverChildBuilderDelegate(
                                      childCount: state.formListModel.length,
                                      (context, index) {
                                return InkWell(
                                  onTap: () {
                                    KeyDataBase.activeForm = state
                                        .formListModel[index].id
                                        .toString();
                                    Navigator.pushNamedAndRemoveUntil(
                                        context,
                                        ScreenNames.showFormRegistrationScreen,
                                        (route) => false);
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
                  if (state is ListFormErrorState) {
                    return getSnackBarWidget(
                        context, state.errorMsg.toString(), Colors.red);
                  }

                  return const SizedBox.shrink();
                },
              ),
            )));
  }
}
