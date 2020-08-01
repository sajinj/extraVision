import 'package:extra_vision/scenes/home_screen.dart';
import 'package:extra_vision/scenes/lesson_screen.dart';
import 'package:extra_vision/scenes/level_screen.dart';
import 'package:extra_vision/scenes/main_Screen.dart';
import 'package:extra_vision/scenes/question_screen.dart';
import 'package:extra_vision/scenes/result_screen.dart';
import 'package:extra_vision/scenes/vocabulary_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:path/path.dart';

void main() {
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) {
    runApp(MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Extra Vison",
      theme: ThemeData(
        primarySwatch: Colors.blue,
        textTheme:
            TextTheme(headline: TextStyle(fontSize: 22, color: Colors.black)),
      ),
      initialRoute: '/',
      routes: {
        // When navigating to the "/" route, build the FirstScreen widget.
        '/': (context) => MainScreen(),
        '/vision': (context) => MyHomePage(),
        // When navigating to the "/second" route, build the SecondScreen widget.
        '/lesson': (context) => SelectScreen(),
        '/level': (context) => LevelScreen(),
        '/question': (context) => QuestionScreen(),
        '/result': (context) => ResultScreen(),
        '/vocabulary': (context) => VocabScreen()
      },
    ));
  });
}
