import 'package:hive_flutter/hive_flutter.dart';

class TodoDB {
  List toDoList = [];

  // reference box
  final _myBox = Hive.box('mybox');

  // First time open app
  void createInitialData() {
    toDoList = [];
  }

  // Load data from DB

  void loadData() {
    toDoList = _myBox.get("TODOLIST");
  }

  // Update data in DB

  void updateDataBase() {
    _myBox.put("TODOLIST", toDoList);
  }
}
