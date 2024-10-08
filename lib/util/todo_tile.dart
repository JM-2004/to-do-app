import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class ToDoTile extends StatelessWidget {
  final String TaskName;
  final bool TaskCompleted;
  Function(bool?)? onChanged;
  Function(BuildContext)? deleteTask;

  ToDoTile({
    super.key,
    required this.TaskName,
    required this.TaskCompleted,
    required this.onChanged,
    required this.deleteTask,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 30, right: 30, top: 30),
      child: Slidable(
        endActionPane: ActionPane(
            motion: StretchMotion(),
            children: [SlidableAction(
              onPressed: deleteTask,
              icon: Icons.delete,
              backgroundColor: Colors.red,
              borderRadius: BorderRadius.circular(10),
            )]),
        child: Container(
          padding: EdgeInsets.all(25),
          decoration: BoxDecoration(
              color: Colors.yellow, borderRadius: BorderRadius.circular(10)),
          child: Row(
            children: [
              Checkbox(
                value: TaskCompleted,
                onChanged: onChanged,
                activeColor: Colors.orange,
              ),
              Text(
                TaskName,
                style: TextStyle(
                    decoration: TaskCompleted
                        ? TextDecoration.lineThrough
                        : TextDecoration.underline),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
