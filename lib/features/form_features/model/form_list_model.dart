class FormListModel {
  FormListModel({
    required this.id,
    required this.title,
  });

  int id;
  String title;

  factory FormListModel.fromJson(Map<String, dynamic> json) {
    return FormListModel(
      id: json['id']??0,
      title: json['title'],
    );
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['title'] = title;
    return map;
  }
}
List<FormListModel> parseFormListModelList(List<dynamic> jsonList) {
  return jsonList.map((json) => FormListModel.fromJson(json)).toList();
}