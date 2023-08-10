import 'package:app/data/database.dart';
import 'package:flutter/material.dart';
import 'package:app/util/todo_tile.dart';
import 'package:app/util/todo_input.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:app/util/todo_none.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // reference the hive box
  final _myBox = Hive.box('mybox');
  TodoDB db = TodoDB();

  @override
  void initState() {
    // Check if the box is empty
    if (_myBox.get("TODOLIST") == null) {
      // Create initial data
      db.createInitialData();
    } else {
      // Load data from DB
      db.loadData();
    }

    super.initState();
  }

  // Text controller for the input field
  final _controller = TextEditingController();

  void checkboxChanged(bool? value, int index) {
    setState(() {
      db.toDoList[index][1] = !db.toDoList[index][1];
    });
    db.updateDataBase();
  }

  // Method for adding a new task
  void addNewTask() {
    final newTaskName =
        _controller.text.trim(); // Remove leading/trailing whitespace

    if (newTaskName.isNotEmpty) {
      setState(() {
        db.toDoList.add([newTaskName, false]);
        _controller.clear();
      });
      db.updateDataBase();
    } else {
      // Show an alert dialog if the user tries to add an empty task
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title:
                const Text('Empty Task', style: TextStyle(fontFamily: 'Inter')),
            content: const Text('Please enter a task.',
                style: TextStyle(fontFamily: 'Inter')),
            actions: <Widget>[
              TextButton(
                child: const Text('OK'),
                onPressed: () {
                  Navigator.of(context).pop(); // Close the dialog
                },
              ),
            ],
          );
        },
      );
    }
  }

  // Method for deleting a task
  void deleteTask(int index) {
    setState(() {
      db.toDoList.removeAt(index);
    });
    db.updateDataBase();
  }

  // Method for updating a task
  void updateTask(int index, String newTask, String currentTask) {
    String newTaskName = newTask;

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Edit Task', style: TextStyle(fontFamily: 'Inter')),
          content: TextField(
            onChanged: (value) {
              newTaskName = value;
            },
            controller: TextEditingController(text: currentTask),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Save'),
              onPressed: () {
                setState(() {
                  db.toDoList[index][0] = newTaskName;
                });
                db.updateDataBase();
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        title: Image.asset('assets/src/logo.png', height: 50),
        backgroundColor: Colors.white,
        elevation: 0,
        toolbarHeight: 100,
      ),
      body: Column(
        children: [
          // Display the input field
          TodoInput(
            controller: _controller,
            addTask: addNewTask,
          ),
          Expanded(
            child: db.toDoList.isEmpty
                ? TodoNone() // Display TodoNone if the list is empty
                : ListView.builder(
                    itemCount: db.toDoList.length,
                    itemBuilder: (context, index) {
                      return TodoTile(
                        taskName: db.toDoList[index][0],
                        isCompleted: db.toDoList[index][1],
                        onChanged: (value) => checkboxChanged(value, index),
                        deleteTask: (context) => deleteTask(index),
                        updateTask: (context) => updateTask(
                            index, _controller.text, db.toDoList[index][0]),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
