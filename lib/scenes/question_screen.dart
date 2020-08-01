import 'dart:async';

import 'package:extra_vision/model/question_model.dart';
import 'package:extra_vision/scenes/result_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';

import '../util.dart';

class QuestionScreen extends StatefulWidget {
  
  @override
  _QuestionScreenState createState() => _QuestionScreenState();
}

class _QuestionScreenState extends State<QuestionScreen>
    with SingleTickerProviderStateMixin {
  Future<Database> datab;

  Question question;

  bool isDisable;
  int questCounter;
  int questTedad;

  int falseChoice;

  AnimationController controller;
  Animation<double> animation;

  Timer _timer;
  int _start = 20;

  List<ResultModel> resultModes = [];
// 0->white, 1->sahih, -1->ghalat
  List<int> disable;

  var btnColors = [Colors.green, Colors.red];

  void startTimer() {
    const oneSec = const Duration(seconds: 1);
    _timer = new Timer.periodic(
      oneSec,
      (Timer timer) => setState(
        () {
          if (_start < 2) {
            nazade();
            nextQuest();
          } else {
            _start = _start - 1;
          }
        },
      ),
    );
  }

  void isTrue(Question question, String s, int i) {
    if (s == question.javab) {
      disable[i] = 1;
    } else {
      falseChoice = falseChoice + 1;
      disable[i] = -1;

      ResultModel resultMode = new ResultModel(
          question: question.question,
          trueAnswer: question.javab,
          yourAnswer: s);

      resultModes.add(resultMode);

      // javabha.add();
    }
  }

  void nextQuest() {
    disable[0] = 0;
    disable[1] = 0;
    disable[2] = 0;
    disable[3] = 0;

    _timer.cancel();

    isDisable = false;

    if (questCounter < questTedad) {
      questCounter = questCounter + 1;
      _start = 20;
      startTimer();
      controller.reset();
      controller.forward();
    } else {
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (indext) => ResultScreen(
                    ghalat: falseChoice,
                    ghalatOrNazadeQuest: resultModes,
                  )));
    }
  }

  TextStyle _textStyle = TextStyle(
    color: Colors.black,
    fontSize: 16,
  );

  @override
  void initState() {
    super.initState();
    startTimer();
    isDisable = false;
    questCounter = 1;
    questTedad = Data.data.questionInLevel;
    disable = [0, 0, 0, 0];
    falseChoice = 0;

    controller = AnimationController(
      duration: Duration(seconds: _start),
      vsync: this,
    );

    animation = Tween(begin: 1.0, end: 0.0).animate(controller)
      ..addListener(() {
        setState(() {});
      });

    controller.forward();
  }

  @override
  void dispose() {
    _timer.cancel();
    controller.stop();
    super.dispose();
  }

  @override
  Widget build(BuildContext buildContext) {
    double elev = 5;

    return Scaffold(
      body: FutureBuilder(
        future: DatabaseProvider.dbProvider.getQuestions(Data.data.getPath()),
        builder:
            (BuildContext context, AsyncSnapshot<List<Question>> snapshot) {
          if (snapshot.hasData) {
            question =
                snapshot.data[(questCounter - 1) + Data.data.level * questTedad];
            return SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(top: 16.0),
                      child: Row(
                        children: <Widget>[
                          Expanded(
                            child: Align(
                                alignment: Alignment.centerLeft,
                                child: Text("Time Left : " +
                                    _start.toString() +
                                    "sec", style: TextStyle(fontSize: 16),)),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 8.0),
                            child: Text(
                              questCounter.toString() +
                                  "/" +
                                  questTedad.toString(),
                              style: TextStyle(color: Colors.blue[800],
                              fontSize: 16
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 16.0, bottom: 16),
                      child: SizedBox(
                        height: 10,
                        child: LinearProgressIndicator(
                          value: animation.value,
                        ),
                      ),
                    ),
                    Card(
                        elevation: elev,
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Center(
                            child: Text("$questCounter. " + question.question,
                                style: _textStyle),
                          ),
                        )),
                    Padding(
                      padding: const EdgeInsets.only(top: 16.0),
                      child: Card(
                        elevation: elev,
                        color: disable[0] == 1
                            ? Colors.green
                            : disable[0] == -1 ? Colors.red : null,
                        child: InkWell(
                          onTap: () {
                            if (!isDisable) {
                              setState(() {
                                controller.stop();
                                isDisable = true;
                                isTrue(question, question.gozine1, 0);
                                Future.delayed(
                                    const Duration(milliseconds: 1000), () {
                                  nextQuest();
                                });
                              });
                            } else {}
                          },
                          child: Center(
                              child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Text(
                              (question.gozine1.length > 0)
                                  ? question.gozine1
                                  : " ",
                              style: _textStyle,
                            ),
                          )),
                        ),
                      ),
                    ),
                    Card(
                      elevation: elev,
                      color: disable[1] == 1
                          ? Colors.green
                          : disable[1] == -1 ? Colors.red : null,
                      child: InkWell(
                        onTap: () {
                          if (!isDisable) {
                            setState(() {
                              controller.stop();
                              isDisable = true;

                              isTrue(question, question.gozine2, 1);
                              Future.delayed(const Duration(milliseconds: 1000),
                                  () {
                                nextQuest();
                              });
                            });
                          } else {}
                        },
                        child: Center(
                            child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Text(
                            (question.gozine2.length > 0)
                                ? question.gozine2
                                : " ",
                            style: _textStyle,
                          ),
                        )),
                      ),
                    ),
                    Card(
                      elevation: elev,
                      color: disable[2] == 1
                          ? Colors.green
                          : disable[2] == -1 ? Colors.red : null,
                      child: InkWell(
                        onTap: () {
                          if (!isDisable) {
                            setState(() {
                              controller.stop();
                              isDisable = true;
                              isTrue(question, question.gozine3, 2);
                              Future.delayed(const Duration(milliseconds: 1000),
                                  () {
                                nextQuest();
                              });
                            });
                          } else {}
                        },
                        child: Center(
                            child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Text(
                            (question.gozine3.length > 0)
                                ? question.gozine3
                                : " ",
                            style: _textStyle,
                          ),
                        )),
                      ),
                    ),
                    Card(
                      elevation: elev,
                      color: disable[3] == 1
                          ? Colors.green
                          : disable[3] == -1 ? Colors.red : null,
                      child: InkWell(
                        onTap: () {
                          if (!isDisable) {
                            setState(() {
                              controller.stop();
                              isDisable = true;
                              isTrue(question, question.gozine4, 3);
                              Future.delayed(const Duration(milliseconds: 1000),
                                  () {
                                nextQuest();
                              });
                            });
                          } else {}
                        },
                        child: Center(
                            child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Text(
                            (question.gozine4.length > 0)
                                ? question.gozine4
                                : " ",
                            style: _textStyle,
                          ),
                        )),
                      ),
                    ),
                  ],
                ),
              ),
            );
          } else
            return CircularProgressIndicator();
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.arrow_forward),
        onPressed: () {
          if (!isDisable)
            setState(() {
              nazade();
              nextQuest();
            });
          else {}
        },
      ),
    );
  }

  void nazade() {
    ResultModel resultMode = new ResultModel(
        question: question.question,
        trueAnswer: question.javab,
        yourAnswer: "no answer!");

    resultModes.add(resultMode);
  }
}
