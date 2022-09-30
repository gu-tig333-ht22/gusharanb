import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

//Design:
// duger, fokusera på funktionalitet

// funktionalitet:
// verkar uppfylla kraven, fokusera på nätverk.

// Nätverk http:
// kan nu lägga till tasks med http POST där jag gjorde: boolean.toString()
// kan inte hämta specifika värden från listan, mycket märkligt: fixa nästa vecka(40)
// kan inte ändra boolean PUT: fixa detta nästa vecka(40)
// kan inte DELETE en task ännu från listan: fixa detta nästa vecka(40)
// kan inte initiera listan vid appstart: fixa detta nästa vecka(40)

void main() {
  var state = MyState();
  runApp(
    ChangeNotifierProvider(
      create: (context) => state,
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Todo",
      theme: ThemeData(
        primarySwatch: Colors.yellow,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: CardsListView(),
    );
  }
}

//model.dart

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

//task_card_widget.dart

class TaskCardWidget extends StatelessWidget {
  final TaskCard card;
  TaskCardWidget(this.card);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      width: 300,
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Text("Here you can add a task you wish to complete"),
      ),
    );
  }
}

// create_task.dart

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

//CardsListView.dart

class CardsListView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("My tasks"),
        actions: [
          ElevatedButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: ((context) => ApiTest())));
              },
              child: Text("API TEST")),
          SizedBox(width: 40),
          PopupMenuButton(
              onSelected: (value) {
                Provider.of<MyState>(context, listen: false).setFilterBy(value);
              },
              itemBuilder: (context) => [
                    PopupMenuItem(
                      child: Text("all"),
                      value: "all",
                    ),
                    PopupMenuItem(
                      child: Text("done"),
                      value: "done",
                    ),
                    PopupMenuItem(
                      child: Text("undone"),
                      value: "undone",
                    ),
                  ])
        ],
      ),
      body: Consumer<MyState>(
        builder: (context, state, child) =>
            CardsList(_filterList(state.list, state.filterBy)),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () async {
          var newTask = await Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => CreateTask(TaskCard(
                        title: "",
                        done: false,
                      ))));
          Provider.of<MyState>(context, listen: false).addCard(newTask);
        },
      ),
    );
  }

  List<TaskCard> _filterList(list, filterBy) {
    if (filterBy == "all") return list;
    if (filterBy == "done")
      return list.where((item) => item.done == true).toList();
    if (filterBy == "undone")
      return list.where((item) => item.done == false).toList();
    return list;
  }
}

//CardsList.dart
class CardsList extends StatelessWidget {
  final List<TaskCard> list;

  CardsList(this.list);

  @override
  Widget build(BuildContext context) {
    return ListView(
        children: list.map((card) => _cardItem(context, card)).toList());
  }

  Widget _cardItem(context, card) {
    return Padding(
        padding: const EdgeInsets.all(2.0),
        child: Card(
            child: ListTile(
          title: Text(
            card.title,
            style: TextStyle(
                decoration: card.done
                    ? TextDecoration.lineThrough
                    : TextDecoration.none),
            textAlign: TextAlign.start,
          ),
          leading: IconButton(
              alignment: Alignment.centerLeft,
              onPressed: () {
                var state = Provider.of<MyState>(context, listen: false);
                state.checkboxChanged(card.done, card);
              },
              icon: card.done
                  ? Icon(Icons.check_box_outlined)
                  : Icon(Icons.check_box_outline_blank)),
          trailing: IconButton(
              onPressed: () {
                var state = Provider.of<MyState>(context, listen: false);
                state.removeCard(card);
              },
              icon: Icon(Icons.delete_forever)),
        )));
  }
}

//internetFetcher.dart

class InternetFetcher {
  static Future<String> fetchTitle() async {
    http.Response response = await http.get(Uri.parse(
        "https://todoapp-api.apps.k8s.gu.se/todos?key=d56fadd2-8d98-4980-befa-7361dabffaff"));
    return response.body;
  }
}

//api_test.dart

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
          Center(child: _displayGetList()),
        ],
      ),
    );
  }

  Widget _displayGetList() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(title),
        ElevatedButton(
            onPressed: () {
              _doStuff();
            },
            child: Text("Test GET list")),
      ],
    );
  }

  void _doStuff() async {
    var result = await InternetFetcher.fetchTitle();
    setState(() {
      title = result;
    });
  }
}

//API KEY: 9c0f39c6-e60b-44fd-bdb6-8c23aacba29f