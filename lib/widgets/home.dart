import 'package:flutter/material.dart';
import 'package:quizz/widgets/text_utils.dart';
import 'package:quizz/widgets/quizz_page.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        actions: <Widget>[
          IconButton(
              icon: const Icon(Icons.exit_to_app),
              tooltip: 'Quitter',
              onPressed: () {
                Navigator.of(context).pop(true);
              }),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            new Container(
              child:
                  new Image.asset('assets/quizz_cover.png', fit: BoxFit.cover),
              margin: const EdgeInsets.only(bottom: 50.0),
            ),
            new RaisedButton(
                onPressed: () {
                  Navigator.push(context,
                      new MaterialPageRoute(builder: (BuildContext context) {
                    return new QuizzPage();
                  }));
                },
                color: Colors.redAccent,
                child: new TextUtils('Commencer', color: Colors.white))
          ],
        ),
      ),
    );
  }
}
