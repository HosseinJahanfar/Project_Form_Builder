class CheckboxModel {
  CheckboxModel({
      this.type, 
      this.required, 
      this.label, 
      this.description, 
      this.toggle, 
      this.inline, 
      this.className, 
      this.name, 
      this.other, 
      this.values,});

  CheckboxModel.fromJson(dynamic json) {
    type = json['type'];
    required = json['required'];
    label = json['label'];
    description = json['description'];
    toggle = json['toggle'];
    inline = json['inline'];
    className = json['className'];
    name = json['name'];
    other = json['other'];
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
  bool? toggle;
  bool? inline;
  String? className;
  String? name;
  bool? other;
  List<Values>? values;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['type'] = type;
    map['required'] = required;
    map['label'] = label;
    map['description'] = description;
    map['toggle'] = toggle;
    map['inline'] = inline;
    map['className'] = className;
    map['name'] = name;
    map['other'] = other;
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