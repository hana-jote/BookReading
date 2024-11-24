import 'package:backendless_sdk/backendless_sdk.dart';
import 'package:thboooks/Models/todo.dart';
import 'package:flutter/material.dart';
import 'package:thboooks/Models/todo_entry.dart';

class TodoService with ChangeNotifier {
  TodoEntry? _todoEntry;

  List<Todo> _readers = [];
  List<Todo> get readers => _readers;

  void emptyreaders() {
    _readers = [];
    notifyListeners();
  }

  bool _busyretrieving = false;
  final bool _busysaving = false;

  bool get busyretrieving => _busyretrieving;
  bool get busysaving => _busysaving;
  Future<String> getTodos(String username) async {
    String result = 'OK';

    DataQueryBuilder queryBuilder = DataQueryBuilder()
      ..whereClause = "username='$username'";
    _busyretrieving = true;
    notifyListeners();

    List<Map<dynamic, dynamic>?>? map = await Backendless.data
        .of('TodoEntry')
        .find(queryBuilder)
        .onError((error, StackTrace) {
      result = error.toString();
      return null;
    });
    if (result != 'OK') {
      _busyretrieving = false;
      notifyListeners();
      return result;
    }
    if (map != null) {
      if (map.isNotEmpty) {
        _todoEntry = TodoEntry.fromJson(map.first);
        _readers = convertMapToTodoList(_todoEntry!.readers);
        notifyListeners();
      } else {
        _readers = [];
        notifyListeners();
      }
    } else {
      result = 'Not OK';
    }
    _busyretrieving = false;
    notifyListeners();
    return result;
  }

  Future<String> saveTodoEntry(String username, bool inUI) async {
    String result = 'OK';
    return result;
  }

  void toggleTodoDone(int index) {
    _readers[index].done = !_readers[index].done;
    notifyListeners();
  }

  void deleteTodo(Todo todo) {
    _readers.remove(todo);
    notifyListeners();
  }

  void createTodo(Todo todo) {
    _readers.insert(0, todo);
    notifyListeners();
  }
}
