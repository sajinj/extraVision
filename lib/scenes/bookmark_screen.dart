import 'package:extra_vision/model/vocab_model.dart';
import 'package:extra_vision/util.dart';
import 'package:flutter/material.dart';

class BookMarkScreen extends StatefulWidget {
  @override
  _BookMarkScreenState createState() => _BookMarkScreenState();
}

class _BookMarkScreenState extends State<BookMarkScreen> {
  List<Vocab> vocabs;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("favourites"),
      ),
      body: FutureBuilder(
        future: DatabaseProvider.dbProvider.getVocabs("bookmark"),
        builder: (BuildContext con, AsyncSnapshot<List<Vocab>> snapshot) {
          vocabs = snapshot.data;
          if (snapshot.hasData) {
            return ListView.builder(
                itemCount: vocabs.length,
                itemBuilder: (con, index) {
                  final item = vocabs[index];
                  return Dismissible(
                      key: Key(item.english),
                      background: Container(color: Colors.red),
                      onDismissed: (DismissDirection direction) {
                        DatabaseProvider.dbProvider
                            .deleteVocabWithId(item.english);
                      },
                      child: Card(
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: 16, horizontal: 16),
                          child: Row(
                            children: <Widget>[
                              Text(
                                (index + 1).toString() + ". ",
                                style: TextStyle(fontSize: 18, color: Colors.blue[600]),
                              ),
                              Expanded(
                                child: Text(vocabs[index].english,
                                    style: TextStyle(fontSize: 18, color: Colors.black87)),
                              ),
                              Text(vocabs[index].persian,
                                  style: TextStyle(fontSize: 18, color:Colors.blueAccent)),
                            ],
                          ),
                        ),
                      ));
                });
          } else {
            return Center(
              child: Text("there is no word! :("),
            );
          }
        },
      ),
    );
  }
}
