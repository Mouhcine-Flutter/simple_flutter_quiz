import 'package:flutter/material.dart';
import 'dart:async';
import 'package:quizz/widgets/text_utils.dart';
import 'package:quizz/models/question.dart';

class QuizzPage extends StatefulWidget {
  @override
  _QuizzPageState createState() => new _QuizzPageState();
}

class _QuizzPageState extends State<QuizzPage> {
  Question question;

  List<Question> listQuestions = [
    new Question('Paris est-elle la capitale de la France ?', true,
        'Exact! Paris est magique!', 'paris.jpg'),
    new Question(
        'Ténérife est une ville espagnole ?',
        true,
        'Exact! Ténérife est une ville des îles canaries espagnoles',
        'tenerife.jpg'),
    new Question('Firestore est une base de donnée SQL ?', false,
        "Faux, il s'agit d'une base donnée NoSQL!", 'firebase.png'),
    new Question(
        'One punch man est un héros de rang S ?',
        false,
        "Malgres sa puissance phénoménale, c'est un héros de rang C",
        'onepunch.jpg'),
    new Question('Twitter est le réseau social le plus utilisé ?', false,
        "Ce n'était pas lui!", 'twitter.jpg'),
    new Question(
        'Flutter est un langage de programmation ?',
        false,
        "Flutter est un Framework! Dart est le language utilisé",
        'flutter.jpg'),
    new Question('Minecraft est un jeu vidéo ?', true, 'Un jeu très cubique!',
        'minecraft.jpg'),
    new Question('Lucifer est une série original Netflix ?', true,
        'La série à été rachetée par Netflix!', 'lucifer.jpg'),
    new Question("Le Coca-Cola est bon pour la santé ?", false,
        "Il n'y a pas mieux que l'eau minérale!", 'coca.jpg'),
    new Question('Les prochains JO seront à Paris ?', true,
        'Oui, ce sera en 2024!', 'jo.jpg')
  ];

  int index = 0;
  int score = 0;

  @override
  void initState() {
    super.initState();
    question = listQuestions[index];
  }

  @override
  Widget build(BuildContext context) {
    double size = MediaQuery.of(context).size.width * 0.7;
    return new Scaffold(
      appBar: new AppBar(
        title: new TextUtils('Quizz | Partie'),
      ),
      body: new Center(
          child: new Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          new TextUtils('Question #${index + 1}', color: Colors.grey[900]),
          new TextUtils('Score : $score / ${index + 1}',
              color: Colors.grey[900]),
          new Card(
            elevation: 8.0,
            child: new Container(
              height: size,
              width: size,
              child: new Image.asset('assets/' + question.imagePath,
                  fit: BoxFit.cover),
            ),
          ),
          new TextUtils(question.question,
              color: Colors.grey[900], textScaleFactor: 1.3),
          new Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[boutonBool(true), boutonBool(false)],
          )
        ],
      )),
    );
  }

  RaisedButton boutonBool(bool b) {
    return new RaisedButton(
      elevation: 12.0,
      onPressed: (() => dialog(b)),
      color: Colors.red,
      child: TextUtils(b ? "Vrai" : "Faux", color: Colors.white),
    );
  }

  Future<Null> dialog(bool b) async {
    bool bonneResponse = (b == question.response);
    String vrai = "assets/true.png";
    String faux = "assets/false.png";
    if (bonneResponse) {
      score++;
    }
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return new SimpleDialog(
            title: new TextUtils(bonneResponse ? "Bravo !" : "Dommage !",
                textScaleFactor: 1.4,
                color: bonneResponse ? Colors.green : Colors.redAccent),
            contentPadding: EdgeInsets.all(18.0),
            children: <Widget>[
              new Image.asset(bonneResponse ? vrai : faux, fit: BoxFit.cover),
              new Container(height: 20.0),
              new TextUtils(question.explication,
                  textScaleFactor: 1.1, color: Colors.grey[900]),
              new Container(height: 20.0),
              new RaisedButton(
                onPressed: () {
                  Navigator.pop(context);
                  getNextQuestion();
                },
                color: Colors.grey,
                child: new TextUtils('Question Suivante',
                    color: Colors.white, textScaleFactor: 1.2),
              )
            ],
          );
        });
  }

  Future<Null> alerte() async {
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext buildContext) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0)),
            title: new TextUtils('Fin du Quizz!',
                color: Colors.deepPurpleAccent, textScaleFactor: 1.8),
            contentPadding: EdgeInsets.all(30.0),
            content: new TextUtils("Votre Score est de : $score/${index + 1}",
                color: Colors.grey[900]),
            actions: <Widget>[
              new FlatButton(
                  onPressed: (() {
                    Navigator.pop(buildContext);
                    Navigator.pop(context);
                  }),
                  child: new TextUtils("Terminer",
                      textScaleFactor: 1.4, color: Colors.deepPurpleAccent))
            ],
          );
        });
  }

  void getNextQuestion() {
    if (index < listQuestions.length - 1) {
      index++;
      setState(() {
        question = listQuestions[index];
      });
    } else {
      alerte();
    }
  }
}
