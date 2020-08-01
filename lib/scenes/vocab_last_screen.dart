import 'package:extra_vision/model/vocab_model.dart';
import 'package:extra_vision/scenes/vocabulary_screen.dart';
import 'package:extra_vision/util.dart';
import 'package:flutter/material.dart';

class VocabLast extends StatelessWidget {
  List<Vocab> vocabs;

  @override
  Widget build(BuildContext context) {
     
    return FutureBuilder(
        future: DatabaseProvider.dbProvider.getVocabs(Data.data.getPath()),
        builder: (BuildContext context, AsyncSnapshot<List<Vocab>> snapshot) {
          if (snapshot.hasData) {
            vocabs = snapshot.data;
              return Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                      colors: [Colors.blue, Colors.cyan],
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter),
                ),
                child: Column(
                  children: <Widget>[
                    Expanded(
                      child: Container(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Text(
                                "!این بخش تموم شد",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: 24, color: Colors.white),
                              ),
                            ),
                            Text(
                              "بریم بخش بعدی ؟",
                              textAlign: TextAlign.center,
                              style:
                                  TextStyle(fontSize: 24, color: Colors.white),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Row(
                      children: <Widget>[
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            child: GestureDetector(
                              onTap: () {
                                Navigator.of(context).pop();
                              },
                              child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    color: Colors.orange[700],
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 16),
                                    child: Text(
                                      "!نه",
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 22),
                                      textAlign: TextAlign.center,
                                    ),
                                  )),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            child: GestureDetector(
                              onTap: () {
                                if (vocabs[(Data.data.vocabInLevel *
                                        (Data.data.level + 1))]
                                    .english
                                    .isNotEmpty) {
                                  Data.data.level++;
                                  Navigator.of(context).pushReplacement(
                                      MaterialPageRoute(
                                          builder: (con) => VocabScreen()));
                                } else {
                                  
                                }
                              },
                              child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    color: Colors.green[700],
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 16),
                                    child: Text(
                                      "!بریم",
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 22),
                                      textAlign: TextAlign.center,
                                    ),
                                  )),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 24,
                    )
                  ],
                ),
              );
      
          } else {
            return Center(
              child: Text("مشکلی رخ داده!"),
            );
          }
        });
  }
}
