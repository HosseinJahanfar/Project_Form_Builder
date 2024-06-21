class FilePickerModel {
  FilePickerModel({
    this.type,
    this.required,
    this.label,
    this.description,
    this.placeholder,
    this.className,
    this.name,
    this.value,
    this.multiple,
  });

  String? type;
  bool? required;
  String? label;
  String? description;
  String? placeholder;
  String? className;
  String? name;
  String? value;
  bool? multiple;

  FilePickerModel.fromJson(dynamic json) {
    type = json['type'];
    required = json['required'];
    label = json['label'];
    description = json['description'];
    placeholder = json['placeholder'];
    className = json['className'];
    name = json['name'];
    value = json['value'];
    multiple = json['multiple'];
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['type'] = type;
    map['required'] = required;
    map['label'] = label;
    map['description'] = description;
    map['placeholder'] = placeholder;
    map['className'] = className;
    map['name'] = name;
    map['value'] = value;
    map['multiple'] = multiple;
    return map;
  }
}
