import 'package:flutter/material.dart';

class ResultItem extends StatelessWidget {
  String question;
  String yourAns;
  String trueAns;

  ResultItem({this.question, this.trueAns, this.yourAns});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Card(
        elevation: 2,
        child:Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(bottom: 16.0),
                  child: Text(question, style: TextStyle(fontSize: 16),),
                ),
                Text("True Answer : "+trueAns, style: TextStyle(color: Colors.green[700],fontSize: 16),),

                Text("Your Answer : "+yourAns, style: TextStyle(color: Colors.red[800],fontSize: 16),),

              ],
            ),
          ),
        )
      ),
    );
  }
}