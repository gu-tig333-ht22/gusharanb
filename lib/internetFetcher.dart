/*import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'model.dart';

class InternetFetcher {
  static Future<String> fetchTitle() async {
    http.Response response = await http.get(Uri.parse(
        "https://todoapp-api.apps.k8s.gu.se/todos?key=d56fadd2-8d98-4980-befa-7361dabffaff"));
    return response.body;
  }

  static Future<String> fetchIp() async {
    http.Response response = await http.get(Uri.parse(
        "https://todoapp-api.apps.k8s.gu.se/todos?key=050e414-4053-9900-e5981c1a0a3a"));
    var JsonData = response.body;
    var obj = jsonDecode(JsonData);
    return obj["done"];
  }
}*/
