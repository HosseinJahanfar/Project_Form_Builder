class FormModel {
  FormModel({
      this.id, 
      this.title, 
      this.jsonSchema, 
      this.config, 
      this.status,});

  FormModel.fromJson(dynamic json) {
    id = json['id'];
    title = json['title'];
    if (json['JsonSchema'] != null) {
      jsonSchema = [];
      json['JsonSchema'].forEach((v) {
        jsonSchema?.add(JsonSchema.fromJson(v));
      });
    }
    config = json['config'];
    status = json['status'];
  }
  int? id;
  String? title;
  List<JsonSchema>? jsonSchema;
  dynamic config;
  bool? status;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['title'] = title;
    if (jsonSchema != null) {
      map['JsonSchema'] = jsonSchema?.map((v) => v.toJson()).toList();
    }
    map['config'] = config;
    map['status'] = status;
    return map;
  }

}

class JsonSchema {
  JsonSchema({
      this.name, 
      this.type, 
      this.label, 
      this.subtype, 
      this.required, 
      this.className,});

  JsonSchema.fromJson(dynamic json) {
    name = json['name'];
    type = json['type'];
    label = json['label'];
    subtype = json['subtype'];
    required = json['required'];
    className = json['className'];
  }
  String? name;
  String? type;
  String? label;
  String? subtype;
  bool? required;
  String? className;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['name'] = name;
    map['type'] = type;
    map['label'] = label;
    map['subtype'] = subtype;
    map['required'] = required;
    map['className'] = className;
    return map;
  }

}