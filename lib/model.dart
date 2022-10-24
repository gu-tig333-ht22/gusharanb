import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'internetFetcher.dart';

class TaskCard {
  String title;
  bool done = false;
  var id;
  TaskCard({required this.title, required this.done, required this.id});

  static Map<String, dynamic> toJson(TaskCard card) {
    return {
      'title': card.title,
      'done': card.done,
    };
  }

  static TaskCard fromJson(Map<String, dynamic> obj) {
    return TaskCard(
      title: obj['title'],
      id: obj['id'],
      done: obj['done'],
    );
  }
}

class MyState extends ChangeNotifier {
  List<TaskCard> _list = [];
  List<TaskCard> get list => _list;

  String _filterBy = "all";
  String get filterBy => _filterBy;
  bool get done => done;

  void addCard(TaskCard card) async {
    _list = await InternetFetcher.addingCard(card);
    _list = list;
    notifyListeners();
  }

  Future getCard() async {
    _list = await InternetFetcher.fetchingCard();
    _list = list;
    notifyListeners();
  }

  void removeCard(TaskCard card) async {
    _list = await InternetFetcher.deletingCard(card.id);
    notifyListeners();
  }

  void checkboxChanged(bool? value, TaskCard card) async {
    card.done = !card.done;
    _list = await InternetFetcher.updatingCard(card.id, card);
    notifyListeners();
  }

  void setFilterBy(String filterBy) {
    this._filterBy = filterBy;
    notifyListeners();
  }
}
