

import 'dart:async';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';


final Future<Database> database = openDatabase(//データベースに接続する
  join(await getDatabasesPath(),'task_database.db'),//データベースファイルを保存するパスを取得する
  onCreate: (db,version) {//SQLiteのテーブルを作成する.初回起動時に必ず実行
    return db.execute(
    "CREATE TABLE task(name TEXT , memo TEXT)",//Taskテーブルを作成
    );
  },
  version: 1,
  onUpgrade: (Database db, int oldVersion, int newVersion) async {
    await db.execute("ALTER TABLE task ADD COLUMN create_at TIMESTAMP DEFAULT (datetime(CURRENT_TIMESTAMP,'localtime'))");
  },
  );



//データモデルを定義
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

  Map<String,dynamic> onPressed() {
    return {
      'name':name,
      'memo':memo,
      'isDone':isDone,
    };
  }
}

Future<void>insertTask(Task task) async {
  final Database db = await database;
  await db.insert(
    'memo',
    task.onPressed(),
    conflictAlgorithm: ConflictAlgorithm.replace,
  );
}

final todo = Task(
  name: 'テスト',
  memo: 'テスト',
);

await insertTask(todo);

final List<Map<String,dynamic>>maps = await db.query('memo');

