
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TodoApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Todo App',
      theme: ThemeData(
        primarySwatch: Colors.blue,//テーマ
        accentColor: Colors.amberAccent,//アクションの色
        buttonTheme: ButtonThemeData(//ボタンの角丸
          textTheme: ButtonTextTheme.primary,
          shape: RoundedRectangleBorder(
            borderRadius: const BorderRadius.all(Radius.circular(25)),
          )
        )
      ),
      darkTheme: ThemeData(//ダークモード
        brightness: Brightness.dark
      ),
      home: ,
    )
  }
}
