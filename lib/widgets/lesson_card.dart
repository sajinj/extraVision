import 'package:extra_vision/scenes/level_screen.dart';
import 'package:flutter/material.dart';

import '../util.dart';

class LessonCard extends StatelessWidget {
  final String lesson;
  final VoidCallback onLessonClick;

  LessonCard({Key key, this.lesson,this.onLessonClick}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 2),
      child: Stack(
        children: <Widget>[
          Image.asset("assets/images/orange.jpg",
              fit: BoxFit.fill, height: double.infinity),
          Material(
            color: Colors.transparent,
            child: InkWell(
                onTap: () {
                  // Data.data.setLesson(lesson);
                  onLessonClick();
                },
                child: Align(
                  alignment: Alignment.center,
                  child: Text(lesson,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      )),
                )),
          )
        ],
      ),
    );
  }
}
