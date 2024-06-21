class NumberModel {
  NumberModel({
      this.type, 
      this.subtype, 
      this.required, 
      this.label, 
      this.description, 
      this.placeholder, 
      this.className, 
      this.name, 
      this.value, 
      this.min, 
      this.max, 
      this.step,});

  NumberModel.fromJson(dynamic json) {
    type = json['type'];
    subtype = json['subtype'];
    required = json['required'];
    label = json['label'];
    description = json['description'];
    placeholder = json['placeholder'];
    className = json['className'];
    name = json['name'];
    value = json['value'];
    min = json['min'];
    max = json['max'];
    step = json['step'];
  }
  String? type;
  String? subtype;
  bool? required;
  String? label;
  String? description;
  String? placeholder;
  String? className;
  String? name;
  String? value;
  int? min;
  int? max;
  int? step;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['type'] = type;
    map['subtype'] = subtype;
    map['required'] = required;
    map['label'] = label;
    map['description'] = description;
    map['placeholder'] = placeholder;
    map['className'] = className;
    map['name'] = name;
    map['value'] = value;
    map['min'] = min;
    map['max'] = max;
    map['step'] = step;
    return map;
  }

}