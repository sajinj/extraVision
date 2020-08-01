import 'dart:async';
import 'dart:core' as prefix0;
import 'dart:core';
import 'dart:io';
import 'dart:typed_data';

import 'package:extra_vision/model/question_model.dart';
import 'package:extra_vision/model/vocab_model.dart';
import 'package:flutter/services.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class Data {
  Data._();

  static final Data data = Data._();

  double screenWidth = 500;
  double screenHeight = 200;


  var salPic = [
    "assets/images/dahom.jpg",
    "assets/images/yazdahom.jpg",
    "assets/images/davazdahom.jpg"
  ];


  int vocabInLevel = 10;
  int level = 1;
  int questionInLevel = 15;
  String sal = "10";
  String lesson = "l1";
  String type = "vocab";
  bool isTest = true;

  bool engToPers = true;
  
  String getPath() {
    if(isTest)
      return "$type$sal"+"_test_$lesson";
    else
      return "vocab"+"$sal"+"_$lesson";
    // else
  }

  List<String> lessons(String sal) {
    if (sal == "10")
      return [
        "lesson 1",
        "lesson 2",
        "lesson 3",
        "lesson 4",
      ];
    else
      return [
        "lesson 1",
        "lesson 2",
        "lesson 3",
      ];
  }

  void setType(bool isvocab){
    if(isvocab)
      type = "vocab";
    else
      type = "grammar";
  }

  void setLesson(String s){
    for(int i=1; i<5; i++){
      if(s == "lesson "+i.toString())
      {
        lesson = "l"+i.toString();
      }
      else if(s == "lesson "+i.toString()) 
      {
        lesson = "l"+i.toString();
      }
    
    }
  }
}


class DatabaseProvider {
  DatabaseProvider._();

  static final DatabaseProvider dbProvider = DatabaseProvider._();

  Database _database;

  Future<Database> get database async {
    if (_database != null) return _database;
    _database = await getDatabaseInstance();
    return _database;
  }

  Future<Database> getDatabaseInstance() async {
    var databasesPath = await getDatabasesPath();
    var path = join(databasesPath, "extraDatabase.db");

// Check if the database exists
    var exists = await databaseExists(path);

    if (!exists) {
      // Should happen only the first time you launch your application
      print("Creating new copy from asset");

      // Make sure the parent directory exists
      try {
        await Directory(dirname(path)).create(recursive: true);
      } catch (_) {}

      // Copy from asset
      ByteData data = await rootBundle
          .load(join("assets", "databases", "extraDatabase.db"));
      List<int> bytes =
          data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);

      // Write and flush the bytes written
      await File(path).writeAsBytes(bytes, flush: true);
    } else {
      print("Opening existing database");
    }
// open the database
    var db = await openDatabase(path, version: 1);
    return db;
  }

  // Future<Database> getDatabaseInstance() async {
  //   Directory directory = await getApplicationDocumentsDirectory();
  //   String path = join(directory.path, "extraDatabase.db");
  //   return await openDatabase(path, version: 1,
  //       onCreate: (Database db, int version) async {
  //     await db.execute("CREATE TABLE Person ("
  //         "id integer primary key AUTOINCREMENT,"
  //         "name TEXT,"
  //         "city TEXT"
  //         ")");
  //   });
  // }

  // addPersonToDatabase(Question person) async {
  //   final db = await database;
  //   var raw = await db.insert(
  //     "Person",
  //     person.toMap(),
  //     conflictAlgorithm: ConflictAlgorithm.replace,
  //   );
  //   return raw;
  // }

  // updatePerson(Person person) async {
  //   final db = await database;
  //   var response = await db.update("Person", person.toMap(),
  //       where: "id = ?", whereArgs: [person.id]);
  //   return response;
  // }

  

  Future<List<Question>> getQuestions(String address) async {
    final db = await database;
    var response = await db.query(address);
    List<Question> list = response.map((c) => Question.fromMap(c)).toList();
    return list;
  }

   Future<List<Vocab>> getVocabs(String address) async {
    final db = await database;
    var response = await db.query(address);
    List<Vocab> list = response.map((c) => Vocab.fromMap(c)).toList();
    return list;
  }

  addToBookmark(Vocab newClient) async {
    final db = await database;
    var res = await db.insert("bookmark", newClient.toMap());
    return res;
  }

  deleteVocabWithId(String eng) async {
    final db = await database;
    return db.delete("bookmark", where: "english = ?", whereArgs: [eng]);
  }

  isInBookMark(String eng) async {
    final db = await database;
    var response = await db.query("bookmark", where: "english = ?", whereArgs: [eng]);
    return response.isNotEmpty ? true : false;
  }
  // deleteAllPersons() async {
  //   final db = await database;
  //   db.delete("Person");
  // }
}


class ResultModel{

  String question;
  String yourAnswer;
  String trueAnswer;

  ResultModel({this.question, this.trueAnswer, this.yourAnswer});
  }
