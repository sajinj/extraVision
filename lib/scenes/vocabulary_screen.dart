import 'dart:ui' as prefix0;

import 'package:extra_vision/model/vocab_model.dart';
import 'package:extra_vision/scenes/level_screen.dart';
import 'package:extra_vision/scenes/vocab_last_screen.dart';
import 'package:extra_vision/util.dart';
import 'package:flutter/material.dart';

class VocabScreen extends StatefulWidget {
  @override
  _VocabScreenState createState() => _VocabScreenState();

  List<Color> bgColors1 = [const Color(0xff11998e), const Color(0xff38ef7d)];
  List<Color> bgColors2 = [
    const Color(0xfffc4a1a),
    const Color(0xfff7b733),
  ];
  List<Color> bgColors3 = [const Color(0xff654ea3), const Color(0xffeaafc8)];
  List<Color> bgColors4 = [const Color(0xff009FFF), const Color(0xffec2F4B)];
}

class _VocabScreenState extends State<VocabScreen> {
  double width;
  double height;
  double xpos;
  double ypos;
  List<IconData> starIcons;
  PageController pg;
  List<Vocab> vocabs;
  @override
  void initState() {
    super.initState();

    width = Data.data.screenWidth;
    height = Data.data.screenHeight;

    xpos = width / 2 - 100;
    ypos = height;

    pg = PageController();
    pg.addListener(listener);

    starIcons = [
      Icons.star_border,
      Icons.star_border,
      Icons.star_border,
      Icons.star_border,
      Icons.star_border,
      Icons.star_border,
      Icons.star_border,
      Icons.star_border,
      Icons.star_border,
      Icons.star_border,
    ];
  }

  void listener() {
    ypos = height;
  }

  void setStars() async {
    for (int i = 0; i < Data.data.vocabInLevel; i++) {
      Vocab vb = Vocab();
      vb = vocabs[i + (Data.data.vocabInLevel * Data.data.level)];
      if (await DatabaseProvider.dbProvider.isInBookMark(vb.english)) {
        starIcons[i] = Icons.star;
      } else {
        starIcons[i] = Icons.star_border;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
          future: DatabaseProvider.dbProvider.getVocabs(Data.data.getPath()),
          builder: (BuildContext context, AsyncSnapshot<List<Vocab>> snapshot) {
            if (snapshot.hasData) {
              vocabs = snapshot.data;
              setStars();

              return SafeArea(
                child: PageView.builder(
                    controller: pg,
                    onPageChanged: (i) {
                      setState(() {
                        ypos = height;
                      });
                    },
                    itemCount: Data.data.vocabInLevel + 1,
                    itemBuilder: (con, index) {
                      if (index == Data.data.vocabInLevel) {
                        
                        return VocabLast();
                      } else
                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              ypos = height / 2 - 100;
                            });
                          },
                          child: Container(
                            // color: index % 2 == 0 ? Colors.cyanAccent : Colors.pink[300],
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                  colors: index % 4 == 0
                                      ? widget.bgColors1
                                      : index % 4 == 1
                                          ? widget.bgColors2
                                          : index % 4 == 2
                                              ? widget.bgColors3
                                              : widget.bgColors4,
                                  begin: Alignment.bottomCenter,
                                  end: Alignment.topCenter),
                            ),
                            child: Stack(
                              children: <Widget>[
                                Column(
                                  children: <Widget>[
                                    Container(
                                        alignment: Alignment.centerRight,
                                        child: GestureDetector(
                                          onTap: () {
                                            setState(() {
                                              if (starIcons[index] ==
                                                  Icons.star_border) {
                                                starIcons[index] = Icons.star;
                                                Vocab vb = Vocab();
                                                vb.english = vocabs[index +
                                                        (Data.data
                                                                .vocabInLevel *
                                                            Data.data.level)]
                                                    .english;
                                                vb.persian = vocabs[index +
                                                        (Data.data
                                                                .vocabInLevel *
                                                            Data.data.level)]
                                                    .persian;
                                                DatabaseProvider.dbProvider
                                                    .addToBookmark(vb);
                                              } else {
                                                starIcons[index] =
                                                    Icons.star_border;
                                                DatabaseProvider.dbProvider
                                                    .deleteVocabWithId(vocabs[
                                                            index +
                                                                (Data.data
                                                                        .vocabInLevel *
                                                                    Data.data
                                                                        .level)]
                                                        .english);
                                              }
                                            });
                                          },
                                          child: Padding(
                                            padding: const EdgeInsets.all(16),
                                            child: Icon(
                                              starIcons[index],
                                              color: Colors.white,
                                              size: 32,
                                            ),
                                          ),
                                        )),
                                    Container(
                                        alignment: Alignment.topCenter,
                                        // padding: EdgeInsets.only(top: 4),
                                        child: Text(
                                          Data.data.engToPers
                                              ? vocabs[index +
                                                      (Data.data.vocabInLevel *
                                                          Data.data.level)]
                                                  .english
                                              : vocabs[index +
                                                      (Data.data.vocabInLevel *
                                                          Data.data.level)]
                                                  .persian,
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 36,
                                              shadows: [
                                                Shadow(
                                                    blurRadius: 0.5,
                                                    color: Colors.black45,
                                                    offset: Offset(1, 1))
                                              ]),
                                        )),
                                  ],
                                ),
                                AnimatedContainer(
                                  transform:
                                      Matrix4.translationValues(xpos, ypos, 0),
                                  duration: Duration(seconds: 2),
                                  curve: Curves.elasticOut,
                                  child: SizedBox(
                                      width: 200,
                                      height: 200,
                                      child: Container(
                                          color: Colors.transparent,
                                          alignment: Alignment.center,
                                          child: Text(
                                            Data.data.engToPers
                                                ? vocabs[index +
                                                        (Data.data
                                                                .vocabInLevel *
                                                            Data.data.level)]
                                                    .persian
                                                : vocabs[index +
                                                        (Data.data
                                                                .vocabInLevel *
                                                            Data.data.level)]
                                                    .english,
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                fontSize: 36,
                                                color: Colors.grey[200]),
                                          ))),
                                )
                              ],
                            ),
                          ),
                        );
                    }),
              );
            } else
              return Center(
                child: Text("there is no data !"),
              );
          }),
    );
  }
}
