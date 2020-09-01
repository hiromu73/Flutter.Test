


import 'dart:async';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';


//データベースへの接続を開く
final Future<Database> database = openDatabase(//データベースを開く
  join( await getDatabasePath(), 'task_database.db'),//使用するデータベースファイルを作成しそこへのパスを定義する
  onCreate: (db, version) {//データベースでCREATE TABLEステートメントを実行します。
    return db.execute(
    "CREATE TABLE task(name TEXT,  memo TEXT)",//taskと言う、データを保存できるテーブルを定義する
    );
},
  version: 1,//バージョンを設定。これにより、onCreate関数が実行され、データベースのアップグレードとダウングレードを実行するためのパスが提供されます。
);




//データモデルを定義
//Taskクラスを更新して、 `toMap`メソッドを含めます。
class Task {
  String name;
  String memo;
  bool isDone;
  final DateTime createdAt;
  DateTime updatedAt;

  Task({this.name,
    this.memo,
    this.isDone = false,
    this.createdAt,
    this.updatedAt});

  //Taskをマップ型に変換します。キーは、データベース内の列の名前に対応している必要があります。
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'memo': memo,
      };
    }
  }



  //Taskをデータベースに挿入する関数を定義する
Future<void> insertTask(Task task) async {
  //データベースへの参照を取得します。
  final Database db = await database;
  //Taskを正しいテーブルに挿入します。同じTaskが2回挿入された場合に使用する `conflictAlgorithm`を指定することもできます。

  //今回は以前のデータを置き換えます。
  await db.insert(
    'tasks',
    task.toMap(),
    conflictAlgorithm: ConflictAlgorithm.replace,
  );
}


//Taskを作成し、tasksテーブルに追加します。
final Todo = Task(
  name: 'あああ',
  memo: 'あああ',
);


await insertTask(Todo);


//tasksテーブルからすべてのTaskを取得するメソッド。
Future<List<Dog>> dogs() async {
  //データベースへの参照を取得します。
  final Database db =await database;

  //すべてのThe Dogsのテーブルをクエリします。
  final List<Map<String, dynamic>> maps = await db.query('tasks');

  //List<Map<String, dynamic>をList<Task>に変換する
  return List.generate(maps.length,(i) {
    return Task(
      name: maps[i]['name'],
      memo: maps[i]['memo'],
    );
  });
}


//上記のメソッドを使用してすべてのTaskを取得します。
print(await tasks());


Future<void> deleteTask(int name) async {
  //データベースへの参照を取得します。
  final db = await database;
  //データベースからTaskを削除する
  await db.delete(
    'tasks',
    //特定のものを削除するには、 `where`句を使用します。
    where: "name = ?",
    //TaskのnameをwhereArgとして渡して、SQLインジェクションを防ぎます。
    whereArgs: [name],
  );
}


  @override
  String toString() {
    return 'Task{name: $name, memo: $memo}';
  }
}
