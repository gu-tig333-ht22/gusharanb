import 'package:flutter/material.dart';
import 'CardsList.dart';
import 'create_task.dart';
import 'main.dart';
import 'model.dart';
import 'package:provider/provider.dart';

class CardsListView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text("My tasks"),
        actions: [
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
                        id: "",
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
