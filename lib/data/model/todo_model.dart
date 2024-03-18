class TodoModel {
  String? id;
  String? title;
  String? desc;
  DateTime? createdAt;

  TodoModel({this.id, this.title, this.desc, this.createdAt});

  TodoModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    desc = json['desc'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['desc'] = desc;
    data['created_at'] = createdAt;
    return data;
  }
}
