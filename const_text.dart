//グローバルな変数/定数を扱うフォルダ

class Todo {
  String id;
  String title;
  DateTime dueDate;
  String note;

  Todo(this.title, this. dueDate, this.note);

  // クラス名.関数名  で異なるコンストラクタを定義できる
  Todo.newTodo() {
    title = "";
    dueDate = DateTime.now();
    note = "";
  }
}
