class Question{
  int id;
  String question;
  String gozine1;
  String gozine2;
  String gozine3;
  String gozine4;
  String javab;

  Question({this.question, this.gozine1,
  this.gozine2,this.gozine3,this.gozine4,
  this.javab
  });

  factory Question.fromMap(Map<String, dynamic> json) => new Question(
    question: json["question"],
    gozine1: json["gozine1"],
    gozine2: json["gozine2"],
    gozine3: json["gozine3"],
    gozine4: json["gozine4"],
    javab: json["javab"],

  );
}