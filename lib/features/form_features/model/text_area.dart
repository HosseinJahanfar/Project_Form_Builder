class TextArea {
  TextArea({
      this.type, 
      this.required, 
      this.label, 
      this.description, 
      this.placeholder, 
      this.className, 
      this.name, 
      this.value, 
      this.subtype, 
      this.maxlength, 
      this.rows,});

  TextArea.fromJson(dynamic json) {
    type = json['type'];
    required = json['required'];
    label = json['label'];
    description = json['description'];
    placeholder = json['placeholder'];
    className = json['className'];
    name = json['name'];
    value = json['value'];
    subtype = json['subtype'];
    maxlength = json['maxlength'];
    rows = json['rows'];
  }
  String? type;
  bool? required;
  String? label;
  String? description;
  String? placeholder;
  String? className;
  String? name;
  String? value;
  String? subtype;
  int? maxlength;
  int? rows;

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
    map['subtype'] = subtype;
    map['maxlength'] = maxlength;
    map['rows'] = rows;
    return map;
  }

}