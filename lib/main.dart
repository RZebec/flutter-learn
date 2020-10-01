import 'package:first_app/answer.dart';
import 'package:first_app/question.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MyAppState();
  }
}

class _MyAppState extends State<MyApp> {
  var _questionIndex = 0;

  var questions = [
    {
      'questionText': 'What\'s your favorite colour?',
      'answers': [
        'Black',
        'Red',
        'Green',
        'White',
      ],
    },
    {
      'questionText': 'What\'s your favorite animal?',
      'answers': [
        'Rabbit',
        'Snake',
        'Elephant',
        'Lion',
      ],
    },
    {
      'questionText': 'Who\'s your favorite instructor?',
      'answers': [
        'Max',
        'Max',
        'Max',
        'Max',
      ],
    },
  ];

  _answerQuestion() {
    setState(() {
      _questionIndex =
          questions.length - 1 != _questionIndex ? _questionIndex + 1 : 0;
    });

    print('Answer chosen!');
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.deepOrange,
          title: Text('My First App'),
        ),
        body: Column(children: <Widget>[
          Question(questions[_questionIndex]['questionText']),
          ...(questions[_questionIndex]['answers'] as List<String>)
              .map((answer) {
            return Answer(_answerQuestion, answer);
          }).toList(),
        ]),
      ),
    );
  }
}
