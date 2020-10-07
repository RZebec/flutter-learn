import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:todo_app/model/todo.dart';
import 'package:todo_app/util/dbhelper.dart';

const mnuSave = 'Save Todo & Back';
const mnuDelete = 'Delete Todo';
const mnuBack = 'Back to List';

final List<String> choices = const <String>[
  mnuSave,
  mnuDelete,
  mnuBack,
];

DbHelper helper = DbHelper();

class TodoDetail extends StatefulWidget {
  final Todo todo;

  TodoDetail(this.todo);

  @override
  _TodoDetailState createState() => _TodoDetailState(this.todo);
}

class _TodoDetailState extends State<TodoDetail> {
  Todo todo;

  final _priorities = ['High', 'Medium', 'Low'];

  String _priority = 'Low';

  TextEditingController titleController = TextEditingController();

  TextEditingController descriptionController = TextEditingController();

  _TodoDetailState(this.todo);

  @override
  Widget build(BuildContext context) {
    titleController.text = todo.title;
    descriptionController.text = todo.description;
    TextStyle textStyle = Theme.of(context).textTheme.headline6;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(todo.title),
        actions: <Widget>[
          PopupMenuButton<String>(
            onSelected: select,
            itemBuilder: (BuildContext context) {
              return choices.map(
                (String choice) {
                  return PopupMenuItem<String>(
                    value: choice,
                    child: Text(choice),
                  );
                },
              ).toList();
            },
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.only(
          top: 35.0,
          left: 10.0,
          right: 10.0,
        ),
        child: ListView(
          children: <Widget>[
            Column(
              children: <Widget>[
                TextField(
                  controller: titleController,
                  style: textStyle,
                  onChanged: (value) => this.updateTitle(),
                  decoration: InputDecoration(
                    labelText: 'Title',
                    labelStyle: textStyle,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                    top: 15.0,
                    bottom: 15.0,
                  ),
                  child: TextField(
                    controller: descriptionController,
                    style: textStyle,
                    onChanged: (value) => this.updateDescription(),
                    decoration: InputDecoration(
                      labelText: 'Subtitle',
                      labelStyle: textStyle,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                    ),
                  ),
                ),
                ListTile(
                  title: DropdownButton<String>(
                    items: _priorities.map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    style: textStyle,
                    value: retirevePriority(todo.priority),
                    onChanged: (value) => updatePriority(value),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void select(String value) async {
    int result;

    switch (value) {
      case mnuSave:
        save();
        break;
      case mnuDelete:
        if (todo.id == null) {
          return;
        }
        Navigator.pop(context, true);
        result = await helper.deleteTodo(todo.id);
        if (result != 0) {
          AlertDialog alertDialog = AlertDialog(
            title: Text('Delete Todo'),
            content: Text('The Todo has been deleted!'),
          );
          showDialog(
            context: context,
            builder: (_) => alertDialog,
          );
        }
        break;
      case mnuBack:
        Navigator.pop(context, true);
        break;
    }
  }

  void save() {
    todo.date = new DateFormat.yMd().format(DateTime.now());
    if (todo.id != null) {
      helper.updateTodo(todo);
    } else {
      helper.insertTodo(todo);
    }
    Navigator.pop(context, true);
  }

  void updatePriority(String value) {
    switch (value) {
      case 'High':
        todo.priority = 1;
        break;
      case 'Medium':
        todo.priority = 2;
        break;
      case 'Low':
        todo.priority = 3;
        break;
    }
    setState(() {
      _priority = value;
    });
  }

  String retirevePriority(int value) {
    return _priorities[value - 1];
  }

  void updateTitle() {
    todo.title = titleController.text;
  }

  void updateDescription() {
    todo.description = descriptionController.text;
  }
}
