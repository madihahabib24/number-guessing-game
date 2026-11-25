class Guess {
  final int? id;
  final int number;
  final String result;

  Guess({this.id, required this.number, required this.result});

  Map<String, dynamic> toMap() {
    return {'id': id, 'guess': number, 'result': result};
  }

  factory Guess.fromMap(Map<String, dynamic> map) {
    return Guess(id: map['id'], number: map['guess'], result: map['result']);
  }
}
