import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'model.dart';
import 'create_task.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class CardsList extends StatelessWidget {
  final List<TaskCard> list;
  late String title;
  late bool done;
  late var id;
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
