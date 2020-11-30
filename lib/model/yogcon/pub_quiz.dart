import 'package:flutter/widgets.dart';

class Question {
  int pos;
  String type;
  String question;
  List<String> answers;
  String imageUrl;

  Question({
    @required this.pos,
    @required this.type,
    @required this.question,
    @required this.answers,
    this.imageUrl,
  });
}

class Game {
  List<Question> questions;
}
