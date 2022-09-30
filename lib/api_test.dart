/*import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'internetFetcher.dart';

class ApiTest extends StatefulWidget {
  @override
  State<ApiTest> createState() => _ApiTestState();
}

class _ApiTestState extends State<ApiTest> {
  String title = "title";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("API TEST"),
      ),
      body: Column(
        children: [
          Center(child: _displayList()),
        ],
      ),
    );
  }

  Widget _displayList() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(title),
        ElevatedButton(
            onPressed: () {
              _doStuff();
            },
            child: Text("api get list")),
      ],
    );
  }

  void _doStuff() async {
    var result = await InternetFetcher.fetchTitle();
    setState(() {
      title = result;
    });
  }

  void _getIp() async {
    var result = await InternetFetcher.fetchIp();
    setState(() {
      title = result;
    });
  }
}

//API KEY: 9c0f39c6-e60b-44fd-bdb6-8c23aacba29f */