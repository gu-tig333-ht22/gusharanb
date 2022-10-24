import 'package:flutter/material.dart';
import 'CardsListView.dart';
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
  late var id;

  late TextEditingController textEditingController;

  CreateTaskState(TaskCard card) {
    this.title = card.title;
    this.done = card.done;
    this.id = card.id;

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
        automaticallyImplyLeading: false,
        centerTitle: true,
        leading: GestureDetector(
          child: Text(
            "Back",
            style: TextStyle(fontSize: 20),
          ),
          onTap: () {
            Navigator.push(context,
                MaterialPageRoute(builder: ((context) => CardsListView())));
          },
        ),
        title: Text("Create Task"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            TaskCardWidget(
                TaskCard(title: this.title, done: this.done, id: this.id)),
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
                Navigator.pop(
                    context, TaskCard(title: title, done: done, id: id));
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
