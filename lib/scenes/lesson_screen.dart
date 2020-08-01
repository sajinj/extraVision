import 'package:extra_vision/util.dart';
import 'package:extra_vision/widgets/lesson_card.dart';
import 'package:flutter/material.dart';

class SelectScreen extends StatefulWidget {
  @override
  _SelectScreenState createState() => _SelectScreenState();
}

class _SelectScreenState extends State<SelectScreen>
    with SingleTickerProviderStateMixin {
  bool hasTab;
  bool isVocab;
  TabController tcontroller;
  List<String> lessons;
  @override
  void initState() {
    super.initState();
    hasTab = Data.data.isTest;
    isVocab = true;
    lessons = Data.data.lessons(Data.data.sal);
    tcontroller = TabController(vsync: this, length: 2);
    tcontroller.addListener(onTabChange);
  }
  void onTabChange() {
    if (tcontroller.index == 0)
      setState(() {
        isVocab = true;
      });
    else
      setState(() {
        isVocab = false;
      });
  }
  @override
  Widget build(BuildContext context) {
    if (!hasTab)
      return Scaffold(
        appBar: AppBar(title: Text("ExtraVision")),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: GridView.count(
            crossAxisCount: 3,
            childAspectRatio: 0.6,
            mainAxisSpacing: 4,
            children: List.generate(lessons.length, (indext) {
              return LessonCard(
                lesson: lessons[indext],
                onLessonClick: () {
                  Data.data.setLesson(lessons[indext]);
                  Navigator.pushNamed(context, "/level");
                },
              );
            }),
          ),
        ),
      );
    else
      return Scaffold(
        appBar: AppBar(
          title: Text("ExtraVision"),
          bottom: TabBar(
            controller: tcontroller,
            tabs: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "vocabulary",
                  style: TextStyle(fontSize: 16),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "grammar",
                  style: TextStyle(fontSize: 16),
                ),
              )
            ],
          ),
        ),
        body: TabBarView(
          controller: tcontroller,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: GridView.count(
                crossAxisCount: 3,
                childAspectRatio: 0.6,
                mainAxisSpacing: 4,
                children: List.generate(lessons.length, (indext) {
                  return LessonCard(
                    lesson: lessons[indext],
                    onLessonClick: () {
                      Data.data.setLesson(lessons[indext]);
                      Data.data.setType(isVocab);
                      Navigator.pushNamed(context, "/level");
                    },
                  );
                }),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: GridView.count(
                crossAxisCount: 3,
                childAspectRatio: 0.6,
                mainAxisSpacing: 4,
                children: List.generate(lessons.length, (indext) {
                  return LessonCard(
                    lesson: lessons[indext],
                    onLessonClick: () {
                      Data.data.setLesson(lessons[indext]);
                      Data.data.setType(isVocab);
                      Navigator.pushNamed(context, "/level");
                    },
                  );
                }),
              ),
            ),
          ],
        ),
      );
  }
}
