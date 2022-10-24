import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'model.dart';
import 'CardsList.dart';

String apiKey = "7f1cb36d-0e28-4d4b-8ade-c5275cf291b0";

class InternetFetcher {
  static Future<List<TaskCard>> fetchingCard() async {
    http.Response response = await http
        .get(Uri.parse("https://todoapp-api.apps.k8s.gu.se/todos?key=$apiKey"));
    var jsonData = response.body;
    var obj = jsonDecode(jsonData);
    return obj.map<TaskCard>((data) {
      return TaskCard.fromJson(data);
    }).toList();
  }

  static Future<List<TaskCard>> addingCard(TaskCard card) async {
    Map<String, dynamic> obj = TaskCard.toJson(card);
    var jsonString = jsonEncode(obj);
    var response = await http.post(
      Uri.parse('https://todoapp-api.apps.k8s.gu.se/todos?key=$apiKey'),
      body: jsonString,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8'
      },
    );
    jsonString = response.body;
    var list = jsonDecode(jsonString);
    return list.map<TaskCard>((data) {
      return TaskCard.fromJson(data);
    }).toList();
  }

  static Future deletingCard(String cardId) async {
    var response = await http.delete(Uri.parse(
        "https://todoapp-api.apps.k8s.gu.se/todos/$cardId?key=$apiKey"));
    var jsonString = response.body;
    var list = jsonDecode(jsonString);
    return list.map<TaskCard>((data) {
      return TaskCard.fromJson(data);
    }).toList();
  }

  static Future updatingCard(String cardId, TaskCard card) async {
    Map<String, dynamic> obj = TaskCard.toJson(card);
    var jsonString = jsonEncode(obj);
    var response = await http.put(
      Uri.parse("https://todoapp-api.apps.k8s.gu.se/todos/$cardId?key=$apiKey"),
      body: jsonString,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8'
      },
    );
    jsonString = response.body;
    var list = jsonDecode(jsonString);
    return list.map<TaskCard>((data) {
      return TaskCard.fromJson(data);
    }).toList();
  }
}
