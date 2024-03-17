// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class TodoModel {
  String id;
  String title;
  String desctiption;
  DateTime createTime;
  bool isFinised;
  TodoModel({
    required this.id,
    required this.title,
    required this.desctiption,
    required this.createTime,
    required this.isFinised,
  });

  TodoModel copyWith({
    String? id,
    String? title,
    String? desctiption,
    DateTime? createTime,
    bool? isFinised,
  }) {
    return TodoModel(
      id: id ?? this.id,
      title: title ?? this.title,
      desctiption: desctiption ?? this.desctiption,
      createTime: createTime ?? this.createTime,
      isFinised: isFinised ?? this.isFinised,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'title': title,
      'desctiption': desctiption,
      'createTime': createTime.millisecondsSinceEpoch,
      'isFinised': isFinised,
    };
  }

  factory TodoModel.fromMap(Map<String, dynamic> map) {
    return TodoModel(
      id: map['id'] as String,
      title: map['title'] as String,
      desctiption: map['desctiption'] as String,
      createTime: DateTime.fromMillisecondsSinceEpoch(map['createTime'] as int),
      isFinised: map['isFinised'] as bool,
    );
  }

  String toJson() => json.encode(toMap());

  factory TodoModel.fromJson(String source) =>
      TodoModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'TodoModel(id: $id, title: $title, desctiption: $desctiption, createTime: $createTime, isFinised: $isFinised)';
  }

  @override
  bool operator ==(covariant TodoModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.title == title &&
        other.desctiption == desctiption &&
        other.createTime == createTime &&
        other.isFinised == isFinised;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        title.hashCode ^
        desctiption.hashCode ^
        createTime.hashCode ^
        isFinised.hashCode;
  }
}
