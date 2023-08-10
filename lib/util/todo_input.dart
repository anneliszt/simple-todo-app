import 'package:flutter/material.dart';

// Class for the input field
class TodoInput extends StatelessWidget {
  final controller;
  final VoidCallback addTask;

  const TodoInput({Key? key, required this.controller, required this.addTask})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
      child: Row(
        children: [
          Expanded(
            child: Container(
              padding: EdgeInsets.only(right: 8),
              child: TextField(
                controller: controller,
                decoration: InputDecoration(
                  labelText: 'Add a new task',
                  labelStyle: TextStyle(
                    fontFamily: 'Inter',
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                    color: Color.fromARGB(194, 168, 168, 168),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(11),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(11),
                    borderSide: BorderSide(
                      color: Color.fromARGB(255, 170, 163, 255),
                    ),
                  ),
                ),
              ),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                begin: Alignment(0.80, -0.60),
                end: Alignment(-0.8, 0.6),
                colors: [Color(0xFF6558FF), Color(0xFFFCAE9F)],
              ),
              borderRadius: BorderRadius.circular(11),
            ),
            child: FloatingActionButton(
              onPressed: addTask,
              child: Icon(Icons.add),
              backgroundColor: Colors.transparent,
              focusColor: Colors.transparent,
              elevation: 0,
            ),
            height: 53,
            width: 53,
          ),
        ],
      ),
    );
  }
}
