import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

// Class for the todo tile
class TodoTile extends StatelessWidget {
  final String taskName;
  final bool isCompleted;
  final Function(bool?)? onChanged;
  final Function(BuildContext)? deleteTask;
  final Function(BuildContext)? updateTask;

  const TodoTile(
      {Key? key,
      required this.taskName,
      required this.isCompleted,
      required this.onChanged,
      required this.deleteTask,
      required this.updateTask})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(15, 0, 15, 10),
      child: Slidable(
        endActionPane: ActionPane(
          motion: StretchMotion(),
          children: [
            // EDIT AND DELETE BUTTONS
            SlidableAction(
              onPressed: updateTask,
              icon: Icons.edit,
              foregroundColor: Colors.white,
              backgroundColor: Color.fromARGB(255, 187, 181, 255),
            ),
            SlidableAction(
              onPressed: deleteTask,
              icon: Icons.delete,
              backgroundColor: Colors.red.shade300,
            ),
          ],
        ),
        child: Container(
          padding: EdgeInsets.all(25),
          child: Row(
            children: [
              // CHECKBOX
              Transform.scale(
                scale: 1.2,
                child: Checkbox(
                    value: isCompleted,
                    onChanged: onChanged,
                    shape: CircleBorder(),
                    activeColor: Color.fromARGB(255, 170, 163, 255)),
              ),

              // TASK NAME
              Text(taskName,
                  style: TextStyle(
                      fontFamily: 'Inter',
                      decoration:
                          isCompleted ? TextDecoration.lineThrough : null)),
              Spacer(),
              Icon(Icons.keyboard_double_arrow_left,
                  color: Color.fromARGB(255, 206, 206, 206)),
            ],
          ),
          decoration: BoxDecoration(
            color: Color.fromARGB(243, 243, 243, 243),
            borderRadius: BorderRadius.circular(11),
          ),
          height: 70,
        ),
      ),
    );
  }
}
