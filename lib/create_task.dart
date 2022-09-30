/*import 'package:flutter/material.dart';
import 'model.dart';
import 'task_card_widget.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

// ignore: use_key_in_widget_constructors
class CreateTask extends StatefulWidget {
  final TaskCard card;
  CreateTask(this.card);

  @override
  State<StatefulWidget> createState() {
    return CreateTaskState(card);
  }
}

@override
class CreateTaskState extends State<CreateTask> {
  late String title;
  late bool done;

  late TextEditingController textEditingController;
  postData() async {
    var response = await http.post(
        Uri.parse(
            "https://todoapp-api.apps.k8s.gu.se/todos?key=d56fadd2-8d98-4980-befa-7361dabffaff"),
        headers: {
          "accept": "application/json",
          "content-type": "application/json"
        },
        body: json.encode({"title": title, "done": done.toString()}));
    return response.body;
  }

  CreateTaskState(TaskCard card) {
    this.title = card.title;
    this.done = card.done;
    this.textEditingController = TextEditingController(text: card.title);
    textEditingController.addListener(() {
      setState(() {
        title = textEditingController.text;
      });
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Create Task"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            TaskCardWidget(TaskCard(title: this.title, done: this.done)),
            TextField(
              controller: textEditingController,
              decoration: InputDecoration(
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                hintText: "Enter a task",
              ),
            ),
            SizedBox(height: 12),
            TextButton(
              onPressed: () {
                Navigator.pop(context, TaskCard(title: title, done: done));
                postData();
              },
              style: TextButton.styleFrom(
                foregroundColor: Colors.purple,
                backgroundColor: Colors.amber,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: Text("Save"),
            ),
          ],
        ),
      ),
    );
  }
}
*/