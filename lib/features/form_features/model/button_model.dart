class ButtonModel {
  ButtonModel({
      this.type, 
      this.label, 
      this.subtype, 
      this.className, 
      this.name, 
      this.value, 
      this.style,});

  ButtonModel.fromJson(dynamic json) {
    type = json['type'];
    label = json['label'];
    subtype = json['subtype'];
    className = json['className'];
    name = json['name'];
    value = json['value'];
    style = json['style'];
  }
  String? type;
  String? label;
  String? subtype;
  String? className;
  String? name;
  String? value;
  String? style;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['type'] = type;
    map['label'] = label;
    map['subtype'] = subtype;
    map['className'] = className;
    map['name'] = name;
    map['value'] = value;
    map['style'] = style;
    return map;
  }

}