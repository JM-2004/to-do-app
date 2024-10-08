
import 'package:hive_flutter/hive_flutter.dart';

class ToDoDataBase {
  final _myBox = Hive.box('myBox');
  List todoList = [];

  void createInitialData() {
    todoList = [["Demo Task", false]];
  }

  void loadData() {
    todoList = _myBox.get("TODOLIST");
  }


  void updateDataBase() {
    _myBox.put("TODOLIST", todoList);
  }
}

