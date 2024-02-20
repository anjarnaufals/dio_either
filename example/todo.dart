import 'dart:convert';

import 'package:collection/collection.dart';

class Todo {
  final int? userId;
  final int? id;
  final String? title;
  final String? body;

  const Todo({this.userId, this.id, this.title, this.body});

  @override
  String toString() {
    return 'JsonPlaceholder(userId: $userId, id: $id, title: $title, body: $body)';
  }

  factory Todo.fromMap(Map<String, dynamic> data) {
    return Todo(
      userId: data['userId'] as int?,
      id: data['id'] as int?,
      title: data['title'] as String?,
      body: data['body'] as String?,
    );
  }

  Map<String, dynamic> toMap() => {
        'userId': userId,
        'id': id,
        'title': title,
        'body': body,
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [Todo].
  factory Todo.fromJson(String data) {
    return Todo.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [Todo] to a JSON string.
  String toJson() => json.encode(toMap());

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    if (other is! Todo) return false;
    final mapEquals = const DeepCollectionEquality().equals;
    return mapEquals(other.toMap(), toMap());
  }

  @override
  int get hashCode =>
      userId.hashCode ^ id.hashCode ^ title.hashCode ^ body.hashCode;
}
