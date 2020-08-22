import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:to_do_app/screen/add_task_screen/add_task_screen.dart';
import 'package:to_do_app/screen/task_screen/task_screen.dart';
import 'package:to_do_app/view_model/task_view_model.dart';


void main() {
  print(' Test Todo App !!!');
  runApp(
    ChangeNotifierProvider(
      create: (context) => TaskViewModel(),
      child: MyApp(),
    ),
  );
}


class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Todo App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: TaskScreen.id,
      routes: {
        TaskScreen.id: (context) => TaskScreen(),
        AddTaskScreen.id: (context) => AddTaskScreen(),
      },
    );
  }
}
