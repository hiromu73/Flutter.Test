
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
  bool _validate = false;//入力チェック


//List<Task>を宣言することによってTaskオブジェクトのみを格納するリストを作成する
//注意: []というふうにデフォルトを空と宣言しておかないとエラーが起きる
  List<Task> tasks = [];

//Input fieldで使用するControllerの定義 //eCtrl コントローラー
  final TextEditingController eCtrl = TextEditingController();
//TextEditingController テキスト入力の制御するのに利用


  String createDateFormat(now) { //現在の時間をタイムスタンプのようにフォーマット
    var formatter = DateFormat('yyyy/MM/dd/HH:mm');
    String formatted = formatter.format(now);
    return formatted;
  }

  //こちらではインプットボックスの定義を行います。
  Padding buildInputContainer() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Expanded(//RowやColumnの子Widget間の隙間を目一杯埋めたいときに使う
            child: Container(
              padding: const EdgeInsets.all(8.0),
              height: MediaQuery.of(context).size.height * 0.1,//デバイスのサイズを得る
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius:
                  BorderRadius.horizontal(left: Radius.circular(8.0))),
              child: TextField(
//事前に宣言していたTextEditingController(eCtrl）をcontrollerに代入します。
                controller: eCtrl,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: "Enter your task",
                  errorText: _validate ? 'The input is empty.' : null,
                  contentPadding: EdgeInsets.all(8),
                ),
                onTap: () => setState(() => _validate = false),
//Keyboardの官僚が押された際にアイテムを追加します。
//必要なければ省略しても構いません。
                onSubmitted: (text) {//テキストの編集を完了したことを呼び出す
//controllerが空のときに、addListItemの処理を行わないように分岐を書きます
                  if (text.isEmpty) {//isEmpty 文字列が空の場合はTrueを返す
                    setState(() {
                      _validate = true;
                    });
                  } else {
                    addListItem(text);
                  }
                },
              ),
            ),
          ),
          Container(
            height: MediaQuery.of(context).size.height * 0.1,
            child: RaisedButton(
              color: Colors.blue,
              shape: RoundedRectangleBorder(
                borderRadius:
                BorderRadius.horizontal(right: Radius.circular(8.0)),
              ),
              child: Padding(
                padding: EdgeInsets.all(8.0),
                child: Icon(Icons.add, color: Colors.white),
              ),
              onPressed: () {
//controllerが空のときに、addListItemの処理を行わないように分岐を書きます
                if (eCtrl.text.isEmpty) {
                  setState(() => _validate = true);
                } else {
                  addListItem(eCtrl.text);
                }
              },
            ),
          ),
        ],
      ),
    );
  }

//　Validateの後に行われる処理
// Listに新しいTaskが追加される処理です。
  void addListItem(String text) { //Listに新しいタスクを追加します
    _validate = false;
    final Task newItem = Task(
        title: text,
        status: 'false',
        addedDate: createDateFormat(DateTime.now()),
        completedDate: '');
//tasksの0番目に新しいタスクを追加
    tasks.insert(0, newItem);
// Controllerの内容を消去する
    eCtrl.clear();
// SetStateを行うことによってWidgetの内容を更新
    setState(() {});
  }

//　Taskのアップデートを行う処理
  void updateItems(Task task, int i) {//List上で変更を促されたTaskの編集、更新を行う
    if (task.status == 'false') { //編集されていない場合 statusはステータス
      final updatedTask = Task(
          title: task.title,
          status: 'true',
          addedDate: task.addedDate,
          completedDate: createDateFormat(DateTime.now()));
      //tasksのi番目のタスクを新しいタスクと入れ替える。
      tasks[i] = updatedTask;
    } else if (task.status == 'true') {
      final updatedTask = Task(
          title: task.title,
          status: 'false',
          addedDate: task.addedDate,
          completedDate: '');
      tasks[i] = updatedTask;
    }
    setState(() {});
  }

//タスクの削除を行う処理
  void removeListItem(Task task) async {//List上で選択されたTaskの削除を行います。
    setState(() => tasks.remove(task));
  }
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
//Stackを使用することによってZ軸上にWidgetを重ねることができる
    body: Stack(children: <Widget>[
    AppBackgroundPage(),
    Column(),
    ],
    ),
    ),
    );
  }
}
