import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:project_form_builder/features/form_features/logic/form_builder_bloc.dart';
import 'package:project_form_builder/features/form_features/model/date_field_model.dart';
import 'package:project_form_builder/features/form_features/model/file_picker_model.dart';
import 'package:project_form_builder/features/form_features/widget/date_field_widget.dart';
import 'package:project_form_builder/features/form_features/widget/elevated_btn_upload_widget.dart';
import 'package:project_form_builder/features/form_features/widget/location_widget.dart';
import '../../../const/shape/media_query.dart';
import '../../../const/string/key_data_base.dart';
import '../../../const/theme/colors.dart';
import '../../../route/names.dart';
import '../../public_features/widget/snack_bar.dart';
import '../logic/send_data/send_data_bloc.dart';
import '../model/autocomplated_model.dart';
import '../model/button_model.dart';
import '../model/checkbox_model.dart';
import '../model/hidden_model.dart';
import '../model/number_model.dart';
import '../model/paragraph_model.dart';
import '../model/radio_model.dart';
import '../model/select_model.dart';
import '../model/text_area.dart';
import '../model/text_field_model.dart';
import '../model/title_model.dart';
import '../services/form_repository.dart';
import '../widget/auto_completed_widget.dart';
import '../widget/check_box_widget.dart';
import '../widget/color_widget.dart';
import '../widget/drop_down_widget.dart';
import '../widget/elevated_btn_widget.dart';
import '../widget/hidden_widget.dart';
import '../widget/number_picker.dart';
import '../widget/radio_wdiget.dart';
import '../widget/text_field_form_widget.dart';
import '../widget/text_field_mobile_widget.dart';
import '../widget/text_widget.dart';

class RenderUiWidget extends StatefulWidget {
  RenderUiWidget(
      {super.key, required this.state, required this.isEdit, this.dataId = ''});

  final bool isEdit;
  final dynamic state;
  String dataId;

  @override
  State<RenderUiWidget> createState() => _RenderUiWidgetState();
}

class _RenderUiWidgetState extends State<RenderUiWidget> {
  bool isObscureText = false;

  bool isChecked = true;

  final _formKey = GlobalKey<FormState>();

  List<Map<String, dynamic>> dataList = [];

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: ListView.builder(
          shrinkWrap: true,
          physics:  const NeverScrollableScrollPhysics(),
          padding: EdgeInsets.symmetric(
              horizontal: getWidth(
                context,
                0.05,
              ),

              vertical: getWidth(context, 0.05)),
          itemCount: widget.state.listData!.length,
          itemBuilder: (context, index) {
            var typeData = widget.state.typeData![index];

            if (typeData == "header") {
              TitleModel data = widget.state.listData![index];
              if (data.subtype == 'h1') {
                return TitleWidget(
                  title: data.label ?? '',
                  fontSize: 20,
                );
              } else if (data.subtype == 'h2') {
                return TitleWidget(
                  title: data.label ?? '',
                  fontSize: 18,
                );
              } else if (data.subtype == 'h3') {
                return TitleWidget(
                  title: data.label ?? '',
                  fontSize: 16,
                );
              } else if (data.subtype == 'h4') {
                return TitleWidget(
                  title: data.label ?? '',
                  fontSize: 14,
                );
              } else if (data.subtype == 'h5') {
                return TitleWidget(
                  title: data.label ?? '',
                  fontSize: 12,
                );
              } else if (data.subtype == 'h6') {
                return TitleWidget(
                  title: data.label ?? '',
                  fontSize: 10,
                );
              }
              return TitleWidget(
                title: data.label ??
                    '16.sp'
                        '',
                fontSize: 10,
              );
            } else if (typeData == "hidden") {
              HiddenModel data = widget.state.listData![index];
              return HiddenWidget(
                  name: data.name ?? '', value: data.value ?? '');
            } else if (typeData == "paragraph") {
              ParagraphModel data = widget.state.listData![index];
              return ParagraphWidget(title: data.label ?? '');
            } else if (typeData == "file") {
              FilePickerModel data = widget.state.listData![index];
              return ElevatedBtnUploadWidget(
                title: data.label ?? '',
                value: data.value ?? '',
                func: (value) {
                  data.value = value.toString();
                },
              );
            } else if (typeData == 'date') {
              DateFieldModel date = widget.state.listData![index];
              return CustomDateField(
                label: date.label ?? '',
                description: date.placeholder ?? '',
                placeholder: date.description ?? '',
                initialDate: date.value?.isEmpty ?? true ? null : date.value,
                func: (value) {
                  date.value = value.toString();
                },
              );
            } else if (typeData == "text") {
              TextFieldModel data = widget.state.listData![index];
              if (data.subtype == 'email') {
                return TextFormWidget(
                  name: data.name ?? '',
                  lableText: data.label ?? '',
                  required: data.required ?? false,
                  hintText: data.placeholder ?? '',
                  helper: data.description ?? '',
                  maxLength: data.maxlength ?? 20,
                  initialValue: data.value ?? '',
                  maxLines: 1,
                  textInputAction: TextInputAction.next,
                  floatingLabelBehavior: FloatingLabelBehavior.auto,
                  textInputType: TextInputType.emailAddress,
                  perfixIcon: const Icon(Icons.email_outlined),
                  func: (String? value) {
                    data.name = value;
                  },
                );
              } else if (data.subtype == 'color') {
                return ColorPickerButton(
                  bgColor: data.value != null && data.value!.isNotEmpty
                      ? Color(
                          int.parse('0xff${data.value!.replaceAll('#', '')}'))
                      : Colors.black,
                  lblBtn: data.label ?? '',
                  result: (res) {
                    data.value = res.toString();
                  },
                );
              } else if (data.subtype == 'password') {
                return TextFormWidget(
                  name: data.name ?? '',
                  lableText: data.label ?? '',
                  required: data.required ?? false,
                  hintText: data.placeholder ?? '',
                  helper: data.description ?? '',
                  maxLength: data.maxlength ?? 20,
                  initialValue: data.value ?? '',
                  maxLines: 1,
                  textInputAction: TextInputAction.next,
                  floatingLabelBehavior: FloatingLabelBehavior.auto,
                  textInputType: TextInputType.name,
                  perfixIcon: IconButton(
                      onPressed: () {
                        setState(() {
                          isObscureText = !isObscureText;
                        });
                      },
                      icon: isObscureText
                          ? const Icon(Icons.visibility_off)
                          : const Icon(Icons.visibility)),
                  func: (String? value) {
                    data.value = value;
                  },
                );
              } else if (data.subtype == 'tel') {
                return TextFormMobileWidget(
                  labelText: data.label ?? '',
                  name: data.name ?? '',
                  helper: data.description ?? '',
                  maxLength: data.maxlength ?? 20,
                  required: data.required ?? false,
                  hintText: data.placeholder ?? '',
                  initialValue: data.value ?? '',
                  textInputAction: TextInputAction.next,
                  floatingLabelBehavior: FloatingLabelBehavior.auto,
                  func: (String? value) {
                    data.value = value;
                  },
                );
              }
              return TextFormWidget(
                name: data.name ?? '',
                lableText: data.label ?? '',
                required: data.required ?? false,
                hintText: data.placeholder ?? '',
                helper: data.description ?? '',
                maxLines: 1,
                textInputAction: TextInputAction.newline,
                floatingLabelBehavior: FloatingLabelBehavior.auto,
                maxLength: data.maxlength ?? 20,
                initialValue: data.value ?? '',
                textInputType: TextInputType.name,
                func: (String? value) {
                  data.value = value;
                },
              );
            } else if (typeData == "textarea") {
              TextArea data = widget.state.listData![index];
              return TextFormWidget(
                name: data.name ?? '',
                lableText: data.label ?? '',
                required: data.required ?? false,
                hintText: data.placeholder ?? '',
                helper: data.description ?? '',
                maxLines: data.rows ?? 1,
                textInputAction: TextInputAction.next,
                floatingLabelBehavior: FloatingLabelBehavior.auto,
                maxLength: data.maxlength ?? 20,
                initialValue: data.value ?? '',
                textInputType: TextInputType.name,
                func: (String? value) {
                  data.value = value;
                },
              );
            } else if (typeData == "autocomplete") {
              AutocompletedModel data = widget.state.listData![index];
              return AutoCompletedWidget(
                dataList: data.values!,
                name: data.name ?? '',
                required: data.required ?? false,
                hintText: data.placeholder ?? '',
                helper: data.description ?? '',
                floatingLabelBehavior: FloatingLabelBehavior.auto,
                lableText: data.label ?? '',
                textInputAction: TextInputAction.next,
                textInputType: TextInputType.text,
                func: (value) {
                  for (var element in data.values!) {
                    element.selected = value!.contains(element.value);
                  }
                },
              );
            } else if (typeData == "number") {
              NumberModel data = widget.state.listData![index];
              return NumberInputWithIncrementDecrement(
                title: data.label ?? '',
                required: data.required ?? false,
                name: data.name ?? '',
                max: data.max ?? 40,
                min: data.min ?? 0,
                step: data.step ?? 1,
                initialValue: data.value ?? '0',
                func: (String? value) {
                  data.value = value;
                },
              );
            } else if (typeData == "select") {
              SelectModel data = widget.state.listData![index];
              return DropDownWidget(
                options: data.values!.map((value) => value.toJson()).toList(),
                label: data.label!,
                func: (value) {
                  for (var element in data.values!) {
                    element.selected = value!.contains(element.value);
                  }
                },
              );
            } else if (typeData == "checkbox-group") {
              CheckboxModel data = widget.state.listData![index];

              return CheckBoxGroupWidget(
                options: data.values!.map((value) => value.toJson()).toList(),
                lable: data.label ?? '',
                name: data.name ?? '',
                required: data.required ?? false,
                helper: data.description ?? '',
                func: (List<dynamic>? value) {
                  for (var element in data.values!) {
                    element.selected = value!.contains(element.label);
                  }
                },
                initialValue: List.generate(
                  data.values!.length,
                  (index) => "${data.values![index].value}",
                ),
                orientation: data.inline ?? false,
              );
            } else if (typeData == "radio-group") {
              RadioModel data = widget.state.listData![index];
              return RadioGroupWidget(
                options: data.values!.map((value) => value.toJson()).toList(),
                lable: data.label ?? '',
                name: data.name ?? '',
                orientation: data.inline ?? false,
                helper: data.description ?? '',
                isRequired: data.required ?? false,
                func: (p0) {
                  for (var element in data.values!) {
                    element.selected = p0!.contains(element.value);
                  }
                },
                initialValue: List.generate(
                  data.values!.length,
                  (index) => "${data.values![index].value}",
                ),
              );
            } else if (typeData == "button") {
              ButtonModel data = widget.state.listData![index];
              List<dynamic> listDataAll = widget.state.listData!;
              if (data.subtype == 'reset') {
                return ElevatedButtonWidget(
                  lable: data.label ?? '',
                  function: () {
                    //!btn reset
                    context.read<FormBuilderBloc>().add(CallFormBuilderEvent(
                        activeForm: KeyDataBase.activeForm));
                  },
                );
              } else if (data.subtype == 'location') {
                return LocationWidget(
                  title: data.label ?? '',
                  func: (p0) {
                    ///get location
                    data.value = p0;
                  },
                );
              }
              return BlocProvider(
                create: (context) => SendDataBloc(FormRepository()),
                child: BlocConsumer<SendDataBloc, SendDataState>(
                  listener: (context, state) {
                    if (state is FormBuilderSendDataErrorState) {
                      getSnackBarWidget(
                          context, state.errorMsg.toString(), Colors.red);
                    }
                    if (state is FormBuilderSendDataCompletedState) {
                      showSuccessDialog(context, state.sendMsg.toString());
                    }
                  },
                  builder: (context, state) {
                    if (state is FormBuilderSendDataLoadingState) {
                      return SpinKitWave(
                        color: primary2Color,
                        size: 45.0.sp,
                      );
                    }
                    return ElevatedButtonWidget(
                      lable: data.label! ?? '',
                      function: () {
                        //!Send Data
                        if (widget.isEdit) {
                          if (_formKey.currentState!.validate()) {
                            dataList.clear();
                            for (var element in listDataAll) {
                              dataList.add(element.toJson());
                            }
                            //debugPrint( jsonEncode(dataList));
                            BlocProvider.of<SendDataBloc>(context)
                                .add(CallSendDataFormBuilderEvent(
                              data: jsonEncode(dataList).toString(),
                              appId: KeyDataBase.activeForm,
                            ));
                          }
                        } else {
                          //!Edit form
                          if (_formKey.currentState!.validate()) {
                            dataList.clear();
                            for (var element in listDataAll) {
                              dataList.add(element.toJson());
                            }
                            BlocProvider.of<SendDataBloc>(context).add(
                                CallEditSendDataFormBuilderEvent(
                                    data: jsonEncode(dataList).toString(),
                                    dataId: widget.dataId));

                            Navigator.pushNamedAndRemoveUntil(
                                context,
                                ScreenNames.reportListFormScreen,
                                (route) => false);
                          }
                        }
                      },
                    );
                  },
                ),
              );
            } else {
              return const SizedBox.shrink();
            }
          },
        ),
      ),
    );
  }

//!Dialog Show Success Dialog
  void showSuccessDialog(BuildContext context, String content) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          title: const Text(
            'تبریک!',
            style: TextStyle(
              color: Colors.green,
              fontWeight: FontWeight.bold,
            ),
          ),
          content: Text(
            content,
            style: const TextStyle(
                fontWeight: FontWeight.bold, fontFamily: 'bold'),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text(
                'باشه',
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'bold'),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
