import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:todoapp/data/database.dart';
import 'package:todoapp/util/dialog_box.dart';
import 'package:todoapp/util/todo_tile.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _mybox = Hive.box('mybox');
  ToDoDataBase db = ToDoDataBase();
  /*
  final _mybox = Hive.box('mybox');
  ToDoDataBase db = ToDoDataBase();
*/
  @override
  void initState() {
    if (_mybox.get("TODOLIST") == null) {
      db.createInitialData();
    } else {
      db.loadData();
    }
    super.initState();
  }
  

  final _controller = TextEditingController();

  void checkboxTap(bool? value, int index) {
    setState(() {
      /*
      db.todoList[index][1] = !db.todoList[index][1];
      db.updateDataBase();
      */
      if (db.todoList[index][1] is String) {
      db.todoList[index][1] = db.todoList[index][1].toLowerCase() == 'true';
      }
      db.todoList[index][1] = !db.todoList[index][1];  // Toggle the boolean value
      db.updateDataBase();
    });
  }

  void saveNewTask() {
    setState(() {
      db.todoList.add([_controller.text, false]);
      Navigator.of(context).pop();
      _controller.clear();
      db.updateDataBase();
    });
  }

  void createNewTask() {
    showDialog(
        context: context,
        builder: (context) {
          return DialogueBox(
              controller: _controller,
              onSave: saveNewTask,
              onCancel: Navigator.of(context).pop);
        });
  }

  void deleteTask(int index) {
    setState(() {
      db.todoList.removeAt(index);
      db.updateDataBase();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.yellow[200],
        appBar: AppBar(
          backgroundColor: Colors.yellow[500],
          title: const Center(
              child: Text(
            "To Do",
            style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
          )),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: createNewTask,
          child: const Icon(Icons.add),
        ),
        
        body: ListView.builder(
          itemCount: db.todoList.length,
          itemBuilder: (context, index) {
            return ToDoTile(
              TaskName: db.todoList[index][0],
              TaskCompleted: db.todoList[index][1],
              onChanged: (value) => checkboxTap(value, index),
              deleteTask: (context) => deleteTask(index),
            );
          },
        )
       );
  }
}
