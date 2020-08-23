



import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:to_do_app/model/task.dart';

class TaskViewModel extends ChangeNotifier { //ChangeNotifierで継承。状態管理
  String get editingName => nameController.text;
  String get editingMemo => memoController.text;
  TextEditingController nameController = TextEditingController();//テキストフィールドを変更すると、値を更新する。初期値を入れる場合などに
  TextEditingController memoController = TextEditingController();
  String _strValidateName = '';
  String get strValidateName => _strValidateName;
  bool _validateName = false;
  bool get validateName => _validateName;

  List<Task> _tasks = [];
  UnmodifiableListView<Task> get tasks {
    return UnmodifiableListView(_tasks);
  }

  bool validateTaskName() {
    if (editingName.isEmpty) {
      _strValidateName = 'Please input something.';
      notifyListeners();
      return false;
    } else {
      _strValidateName = '';
      _validateName = false;
      return true;
    }
  }

  void setValidateName(bool value) {
    _validateName = value;
  }

  void updateValidateName() {//更新タスク
    if (validateName) {
      validateTaskName();
      notifyListeners();//状態変更をUIに反映させる
    }
  }

  void addTask() {//追加タスク
    final newTask = Task(
      name: nameController.text,
      memo: memoController.text,
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    );
    _tasks.add(newTask);
    clear();
  }

  void updateTask(Task updateTask) {//更新タスク
    var updateIndex = _tasks.indexWhere((task) {
      return task.createdAt == updateTask.createdAt;
    });
    updateTask.name = nameController.text;
    updateTask.memo = memoController.text;
    updateTask.updatedAt = DateTime.now();
    _tasks[updateIndex] = updateTask;
    clear();
  }

  void deleteTask(int index) {//削除タスク
    _tasks.removeAt(index);
    notifyListeners();//状態変更をUIに反映させる
  }

  void toggleDone(int index, bool isDone) {
    var task = _tasks[index];
    task.isDone = isDone;
    _tasks[index] = task;
    notifyListeners();//状態変更をUIに反映させる
  }

  void clear() {
    nameController.clear();
    memoController.clear();
    _validateName = false;
    notifyListeners();//状態変更をUIに反映させる
  }
}
