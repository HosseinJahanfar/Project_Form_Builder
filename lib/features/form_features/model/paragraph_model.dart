class ParagraphModel {
  String? type;
  String? subtype;
  String? label;
  String? className;

  ParagraphModel({
    this.type,
    this.subtype,
    this.label,
    this.className,
  });

  ParagraphModel.fromJson(dynamic json) {
    type = json['type'];
    subtype = json['subtype'];
    label = json['label'];
    className = json['className'];
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['type'] = type;
    map['subtype'] = subtype;
    map['label'] = label;
    map['className'] = className;
    return map;
  }
}
