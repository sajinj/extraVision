import 'package:extra_vision/model/question_model.dart';
import 'package:extra_vision/util.dart';
import 'package:extra_vision/widgets/result_item.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';

import 'home_screen.dart';

class ResultScreen extends StatefulWidget {
  int nazade;
  int sahih;
  int ghalat;
  List<ResultModel> ghalatOrNazadeQuest;
  ResultScreen({this.ghalat, this.ghalatOrNazadeQuest});

  @override
  _ResultScreenState createState() => _ResultScreenState();
}

class _ResultScreenState extends State<ResultScreen> {
  @override
  void initState() {
    super.initState();
    calculate();
  }

  String getPercentage() {
    double percentage = ((widget.sahih * 3) - widget.ghalat) /
        ((Data.data.questionInLevel) * 3);
    percentage = percentage * 100;

    return (percentage).toStringAsFixed(2) + " %";
  }

  void calculate() {
    widget.nazade = widget.ghalatOrNazadeQuest.length - widget.ghalat;
    widget.sahih =
        Data.data.questionInLevel - widget.ghalatOrNazadeQuest.length;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Card(
              color: Colors.blue,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: Column(
                  children: <Widget>[
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 8.0),
                        child: Text(
                          "Percentage : " + getPercentage(),
                          style: TextStyle(fontSize: 28, color: Colors.white),
                        ),
                      ),
                    ),
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 8.0),
                        child: Text(
                          "Right : " + widget.sahih.toString(),
                          style: TextStyle(fontSize: 18, color: Colors.white),
                        ),
                      ),
                    ),
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 8.0),
                        child: Text(
                          "Wrong : " + widget.ghalat.toString(),
                          style: TextStyle(fontSize: 18, color: Colors.white),
                        ),
                      ),
                    ),
                    Center(
                      child: Text(
                        "Unattemped : " + widget.nazade.toString(),
                        style: TextStyle(fontSize: 18, color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: Container(
                child: ListView.builder(
                  itemCount: widget.ghalatOrNazadeQuest.length,
                  itemBuilder: (buildContext, indext) => ResultItem(
                    question: widget.ghalatOrNazadeQuest[indext].question,
                    trueAns: widget.ghalatOrNazadeQuest[indext].trueAnswer,
                    yourAns: widget.ghalatOrNazadeQuest[indext].yourAnswer,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.popUntil(context, ModalRoute.withName("/"));
        },
        child: Icon(Icons.home),
      ),
    );
  }
}
