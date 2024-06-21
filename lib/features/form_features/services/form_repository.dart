import 'package:dio/dio.dart';
import 'package:project_form_builder/features/form_features/model/date_field_model.dart';
import 'package:project_form_builder/features/form_features/model/file_picker_model.dart';
import '../model/autocomplated_model.dart';
import '../model/button_model.dart';
import '../model/checkbox_model.dart';
import '../model/form_list_model.dart';
import '../model/form_model.dart';
import '../model/hidden_model.dart';
import '../model/number_model.dart';
import '../model/paragraph_model.dart';
import '../model/radio_model.dart';
import '../model/select_model.dart';
import '../model/text_area.dart';
import '../model/text_field_model.dart';
import '../model/title_model.dart';
import 'form_api_services.dart';

class FormRepository {
  // ignore: unused_field
  final FormApiServices _apiFormServices = FormApiServices();
  List<dynamic> listData = [];
  List<dynamic> typeData = [];
  bool status = true;
  FormModel? formModel;

  Future<List<dynamic>> callFormRepository(String activeForm) async {
    Response response = await _apiFormServices.callDataForm(activeForm);
    formModel = FormModel.fromJson(response.data);
    formModel!.status!
        ? response.data['JsonSchema'].forEach((value) {
            typeData.add(value['type']);
            if (value['type'] == 'header') {
              listData.add(TitleModel.fromJson(value));
            } else if (value['type'] == 'hidden') {
              listData.add(HiddenModel.fromJson(value));
            } else if (value['type'] == 'autocomplete') {
              listData.add(AutocompletedModel.fromJson(value));
            } else if (value['type'] == 'paragraph') {
              listData.add(ParagraphModel.fromJson(value));
            } else if (value['type'] == 'text') {
              listData.add(TextFieldModel.fromJson(value));
            } else if (value['type'] == 'textarea') {
              listData.add(TextArea.fromJson(value));
            } else if (value['type'] == 'number') {
              listData.add(NumberModel.fromJson(value));
            } else if (value['type'] == 'select') {
              listData.add(SelectModel.fromJson(value));
            } else if (value['type'] == 'checkbox-group') {
              listData.add(CheckboxModel.fromJson(value));
            } else if (value['type'] == 'radio-group') {
              listData.add(RadioModel.fromJson(value));
            } else if (value['type'] == 'button') {
              listData.add(ButtonModel.fromJson(value));
            } else if (value['type'] == 'date') {
              listData.add(DateFieldModel.fromJson(value));
            } else if (value['type'] == 'file') {
              listData.add(FilePickerModel.fromJson(value));
            }
          })
        : listData.add(null);
    return listData;
  }

//!callSendModelRepository
  Future<void> callSendModelRepository(String inputs, String form) async {
    await _apiFormServices.callSendDataForm(inputs, form);
  }

//!callEditSendModelRepository
  Future<void> callEditSendModelRepository(
       String inputs, String dataId) async {
    await _apiFormServices.callEditSendDataForm(inputs, dataId);
  }

//!callListFormModelRepository
  Future<List<FormListModel>> callFormListRepository() async {
    Response response = await _apiFormServices.callFormRegistrationList();
    if (response.data is List) {
      List<dynamic> jsonData = response.data;
      List<FormListModel> formList = parseFormListModelList(jsonData);
      return formList;
    } else {
      throw Exception('Unexpected response format');
    }
  }

  //!callReportFormModelRepository
  Future<List<FormListModel>> callReportFormRepository() async {
    Response response = await _apiFormServices.callFormReportList();
    if (response.data is List) {
      List<dynamic> jsonData = response.data;
      List<FormListModel> formList = parseFormListModelList(jsonData);
      return formList;
    } else {
      throw Exception('Unexpected response format');
    }
  }
}
