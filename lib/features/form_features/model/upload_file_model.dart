class UploadFileModel {
  UploadFileModel({
      this.id, 
      this.file,});

  UploadFileModel.fromJson(dynamic json) {
    id = json['id'];
    file = json['file'];
  }
  int? id;
  String? file;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['file'] = file;
    return map;
  }

}