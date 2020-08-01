class Vocab {
  int id;
  String english;
  String persian;

  Vocab({
    this.english,
    this.persian,
  });

  factory Vocab.fromMap(Map<String, dynamic> json) => new Vocab(
        english: json["english"],
        persian: json["persian"],
      );

  Map<String, dynamic> toMap() => {
        "english": english,
        "persian": persian,
    };
}
