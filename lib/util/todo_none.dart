import 'package:flutter/material.dart';

class TodoNone extends StatelessWidget {
  const TodoNone({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.fromLTRB(15, 40, 15, 10),
      child: Padding(
        padding: EdgeInsets.all(8.0),
        child: Text("You don't have any tasks yet! 😎",
            style: TextStyle(
                fontFamily: 'Inter',
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: Color.fromARGB(255, 170, 163, 255))),
      ),
    );
  }
}
