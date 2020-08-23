

import 'package:flutter/material.dart';
import 'package:to_do_app/screen/add_task_screen/add_task_screen.dart';
import 'package:to_do_app/screen/task_screen/task_list_view.dart';


class TaskScreen extends StatelessWidget {
  static String id = 'task_screen';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Todo List'),
        actions: [//アクションボタン作成
          GestureDetector(//タッチ/ボタン入力検出用途で利用
            onTap: () {//シングルタップ時に呼ばれる
              Navigator.pushNamed(context, AddTaskScreen.id);//ページを遷移させる
            },
            child: Padding(//タッチ検出対象
              padding: const EdgeInsets.all(8.0),
              child: Icon(Icons.add),
            ),
          ),
        ],
      ),
      body: Container(
        child: TaskListView(),
      ),
    );
  }
}
