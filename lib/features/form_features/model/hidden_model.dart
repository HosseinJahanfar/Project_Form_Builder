class HiddenModel {
  HiddenModel({
      this.type, 
      this.name, 
      this.value,});

  HiddenModel.fromJson(dynamic json) {
    type = json['type'];
    name = json['name'];
    value = json['value'];
  }
  String? type;
  String? name;
  String? value;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['type'] = type;
    map['name'] = name;
    map['value'] = value;
    return map;
  }

}