/*import 'package:flutter/material.dart';
//hämtad

class TaskCard {
  String title;
  bool done = false;
  TaskCard({required this.title, required this.done});
}

class MyState extends ChangeNotifier {
  List<TaskCard> _list = [];
  String _filterBy = "all";
  List<TaskCard> get list => _list;
  String get filterBy => _filterBy;
  bool get done => done;

  void addCard(TaskCard card) {
    _list.add(card);
    notifyListeners();
  }

  void removeCard(TaskCard card) {
    _list.remove(card);
    notifyListeners();
  }

  void checkboxChanged(bool? value, TaskCard card) {
    card.done = !card.done;
    notifyListeners();
  }

  void setFilterBy(String filterBy) {
    this._filterBy = filterBy;
    notifyListeners();
  }
}
*/