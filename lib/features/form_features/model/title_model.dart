class TitleModel {
  TitleModel({
      this.type, 
      this.subtype, 
      this.label, 
      this.className,});

  TitleModel.fromJson(dynamic json) {
    type = json['type'];
    subtype = json['subtype'];
    label = json['label'];
    className = json['className'];
  }
  String? type;
  String? subtype;
  String? label;
  String? className;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['type'] = type;
    map['subtype'] = subtype;
    map['label'] = label;
    map['className'] = className;
    return map;
  }

}