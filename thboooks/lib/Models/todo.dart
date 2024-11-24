import 'package:thboooks/Models/todo_entry.dart';

Map<dynamic, dynamic> convertTodoListToMap(List<Todo> todos) {
  Map<dynamic, dynamic> map = {};
  for (var i = 0; i < todos.length; i++) {
    map.addAll({'$i': todos[i].toJson()});
  }
  return map;
}

List<Todo> convertMapToTodoList(Map<dynamic, dynamic> map) {
  List<Todo> todos = [];
  for (var i = 0; i < map.length; i++) {
    todos.add(Todo.fromJson(map['$i']));
  }
  return todos;
}

class Todo {
  final String title;
  bool done;
  final DateTime created;

  Todo({
    required this.title,
    this.done = false,
    required this.created,
  });

  Map<String, Object?> toJson() => {
        'title': title,
        'done': done ? 1 : 0,
        'created': created.millisecondsSinceEpoch,
      };

  static Todo fromJson(Map<dynamic, dynamic>? json) => Todo(
        title: json!['title'] as String,
        done: json['done'] == 1 ? true : false,
        created: DateTime.fromMillisecondsSinceEpoch(
            (json['created'] as double).toInt()),
      );

  @override
  bool operator ==(covariant Todo todo) {
    return (title.toUpperCase().compareTo(todo.title.toUpperCase()) == 0);
  }

  @override
  int get hashCode {
    return title.hashCode;
  }
}

Map<dynamic, dynamic> convertUserinfoToMap(List<Userinfo> userinfo) {
  Map<dynamic, dynamic> map = {};
  for (var i = 0; i < userinfo.length; i++) {
    map.addAll({'$i': userinfo[i].toJson()});
  }
  return map;
}

List<Todo> convertMapToUserinfo(Map<dynamic, dynamic> map) {
  List<Todo> userinfo = [];
  for (var i = 0; i < map.length; i++) {
    userinfo.add(Todo.fromJson(map['$i']));
  }
  return userinfo;
}
