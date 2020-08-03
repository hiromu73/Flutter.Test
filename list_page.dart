
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';
import 'package:todo_list_app/db/task.dart';
import 'package:todo_list_app/pages/app_background.dart';
import 'package:todo_list_app/pages/completed_task_page.dart';

var listPageKey = GlobalKey<_ListPageState>();

class ListPage extends StatefulWidget {
  const ListPage({Key key}) : super(key: key);

  @override
  _ListPageState createState() => _ListPageState();
}

class _ListPageState extends State<ListPage> {
  bool _validate = false;

//List<Task>を宣言することによってTaskオブジェクトのみを格納するリストを作成します
//注意: []というふうにデフォルトを空と宣言しておかないとエラーが起きます。
  List<Task> tasks = [];

//Input fieldで使用するControllerの定義
  final TextEditingController eCtrl = TextEditingController();

//
//後にwidgetを作成したCRUD処理を行うときの関数はここのスペースに追加する。
//

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
        title: Text('Tasks'),
    centerTitle: true,
    actions: <Widget>[
    // ③次項で作成する内容です。
//            Padding(
//              padding: EdgeInsets.all(8.0),
//              child: IconButton(
//                icon: Icon(Icons.check_box),
//                onPressed: () {
//                  Navigator.push(
//                    context,
//                    MaterialPageRoute(
//                      builder: (context) => CompletedTasks(
//                        tasks: tasks,
//                      ),
//                    ),
//                  );
//                },
//              ),
//            ),
    ],
    ),
//Stackを使用することによってZ軸上にWidgetを重ねることができます。
    body: Stack();
  }
}
