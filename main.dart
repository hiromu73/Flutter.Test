
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:to_do_app/screen/add_task_screen/add_task_screen.dart';
import 'package:to_do_app/screen/task_screen/task_screen.dart';
import 'package:to_do_app/view_model/task_view_model.dart';


void main() {
  runApp(
    ChangeNotifierProvider(//状態管理
      create: (context) => TaskViewModel(),//createに状態を維持する関数を渡す
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
