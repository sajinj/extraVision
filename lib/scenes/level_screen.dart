import 'package:extra_vision/model/question_model.dart';
import 'package:extra_vision/model/vocab_model.dart';
import 'package:extra_vision/scenes/question_screen.dart';
import 'package:extra_vision/scenes/vocabulary_screen.dart';
import 'package:extra_vision/util.dart';
import 'package:extra_vision/widgets/level_select.dart';
import 'package:flutter/material.dart';

class LevelScreen extends StatefulWidget {
  @override
  _LevelScreenState createState() => _LevelScreenState();
}

class _LevelScreenState extends State<LevelScreen> {
  List<String> langs = ["English to Persian", "Persian to English"];
  int i;
  @override
  void initState() {
    super.initState();
    i = 0;
  }

  @override
  Widget build(BuildContext context) {
    if (Data.data.isTest) {
      return Scaffold(
        appBar: AppBar(
          title: Text("ExtraVison"),
        ),
        body: FutureBuilder(
            future:
                DatabaseProvider.dbProvider.getQuestions(Data.data.getPath()),
            builder:
                (BuildContext context, AsyncSnapshot<List<Question>> snapshot) {
              var question = snapshot.data;
              int tedad = (question.length / Data.data.questionInLevel).toInt();

              print(question.length.toString());
              return Padding(
                padding: const EdgeInsets.only(top: 4.0),
                child: ListView.builder(
                    itemCount: tedad,
                    itemBuilder: (con, index) {
                      return LevelSelect(
                        text: "Level " + (index + 1).toString(),
                        bgAddress: "assets/images/test.jpg",
                        onClick: () {
                          Data.data.level = index;
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (con) => QuestionScreen()));
                        },
                      );
                    }),
              );
            }),
      );
    } else {
      return Scaffold(
        appBar: AppBar(
          title: Text("ExtraVison"),
          actions: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: GestureDetector(
                child: Icon(
                  Icons.restore_page,
                ),
                onTap: () {
                  setState(() {
                    i == 0 ? i = 1 : i = 0;
                  });
                },
              ),
            )
          ],
        ),
        body: FutureBuilder(
            future: DatabaseProvider.dbProvider.getVocabs(Data.data.getPath()),
            builder:
                (BuildContext context, AsyncSnapshot<List<Vocab>> snapshot) {
              var vocabs = snapshot.data;
              int tedad = (vocabs.length / Data.data.vocabInLevel).toInt();

              return Padding(
                padding: const EdgeInsets.only(top: 4.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Card(
                      // margin: EdgeInsets.symmetric(horizontal: 8),
                      color: Colors.orange[800],
                      child: Container(
                        alignment: Alignment.center,
                        padding: EdgeInsets.symmetric(vertical: 16),
                        child: Text(
                          langs[i],
                          style: TextStyle(fontSize: 16, color: Colors.white),
                        ),
                      ),
                    ),
                    Expanded(
                      child: ListView.builder(
                          itemCount: tedad,
                          itemBuilder: (con, index) {
                            return LevelSelect(
                              text: "Level " + (index + 1).toString(),
                              bgAddress: "assets/images/vocab.jpg",
                              onClick: () {
                                Data.data.level = index;
                                i == 0
                                    ? Data.data.engToPers = true
                                    : Data.data.engToPers = false;
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (con) => VocabScreen()));
                              },
                            );
                          }),
                    ),
                  ],
                ),
              );
            }),
      );
    }
  }
}
