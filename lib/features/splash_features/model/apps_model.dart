class AppsModel {
  AppsModel({
      this.id, 
      this.configs,});

  AppsModel.fromJson(dynamic json) {
    id = json['id'];
    configs = json['configs'] != null ? Configs.fromJson(json['configs']) : null;
  }
  int? id;
  Configs? configs;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    if (configs != null) {
      map['configs'] = configs?.toJson();
    }
    return map;
  }

}

class Configs {
  Configs({
      this.authentication, 
      this.activeform,});

  Configs.fromJson(dynamic json) {
    authentication = json['authentication'];
    activeform = json['active-form'];
  }
  bool? authentication;
  int? activeform;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['authentication'] = authentication;
    map['active-form'] = activeform;
    return map;
  }

}