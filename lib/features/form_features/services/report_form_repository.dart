import 'package:dio/dio.dart';
import '../model/autocomplated_model.dart';
import '../model/button_model.dart';
import '../model/checkbox_model.dart';
import '../model/date_field_model.dart';
import '../model/file_picker_model.dart';
import '../model/hidden_model.dart';
import '../model/number_model.dart';
import '../model/paragraph_model.dart';
import '../model/radio_model.dart';
import '../model/select_model.dart';
import '../model/text_area.dart';
import '../model/text_field_model.dart';
import '../model/title_model.dart';
import 'form_api_services.dart';

class ReportFormRepository {
  final FormApiServices _apiFormServices = FormApiServices();
  List<dynamic> listData = [];
  List<dynamic> typeData = [];

  Future<List<dynamic>> callReportFormRepository(String activeForm) async {
    Response response = await _apiFormServices.callReportForm(activeForm);
   // print(response.data.toString());
    response.data['inputs'].forEach((value) {
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
      }
      else if (value['type'] == 'date') {
        listData.add(DateFieldModel.fromJson(value));
      } else if (value['type'] == 'file') {
        listData.add(FilePickerModel.fromJson(value));
      }
    });
    return listData;
  }
}
