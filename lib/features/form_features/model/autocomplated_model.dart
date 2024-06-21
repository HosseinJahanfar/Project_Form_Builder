class AutocompletedModel {
  AutocompletedModel({
      this.type, 
      this.required, 
      this.label, 
      this.description, 
      this.placeholder, 
      this.className, 
      this.name, 
      this.requireValidOption, 
      this.values,});

  AutocompletedModel.fromJson(dynamic json) {
    type = json['type'];
    required = json['required'];
    label = json['label'];
    description = json['description'];
    placeholder = json['placeholder'];
    className = json['className'];
    name = json['name'];
    requireValidOption = json['requireValidOption'];
    if (json['values'] != null) {
      values = [];
      json['values'].forEach((v) {
        values?.add(Values.fromJson(v));
      });
    }
  }
  String? type;
  bool? required;
  String? label;
  String? description;
  String? placeholder;
  String? className;
  String? name;
  bool? requireValidOption;
  List<Values>? values;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['type'] = type;
    map['required'] = required;
    map['label'] = label;
    map['description'] = description;
    map['placeholder'] = placeholder;
    map['className'] = className;
    map['name'] = name;
    map['requireValidOption'] = requireValidOption;
    if (values != null) {
      map['values'] = values?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

class Values {
  Values({
      this.label, 
      this.value, 
      this.selected,});

  Values.fromJson(dynamic json) {
    label = json['label'];
    value = json['value'];
    selected = json['selected'];
  }
  String? label;
  String? value;
  bool? selected;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['label'] = label;
    map['value'] = value;
    map['selected'] = selected;
    return map;
  }

}