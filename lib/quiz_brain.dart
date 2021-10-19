import 'question.dart';

class QuizBrain {
  int _questionNumber = 0;

  final List<Question> _questionBank = [
    Question('1. The Big Apple is a nickname given to Washington D.C in 1971.',
        false),
    Question('2. Peanuts are not nuts!', true),
    Question('3. The longest river in the world is the Amazon River. ', false),
    Question('4. Walt Disney has the record for most Academy Awards.', true),
    Question('5. The moon is wider than Australia.', false),
    Question('6. Seahorses don\'t have stomachs.', true),
    Question('7. You are a human', false),
    Question('8. Yor are an animal', true),
    Question('Yor are done with Quiz\nClick on any button', true),
  ];

  void nextQuestion() {
    if (_questionNumber < _questionBank.length - 1) {
      _questionNumber++;
    }
  }

  String getQuestionText() {
    return _questionBank[_questionNumber].questionText;
  }

  bool getQuestionAnswer() {
    return _questionBank[_questionNumber].questionAnswer;
  }

  bool isFinished() {
    if (_questionNumber >= _questionBank.length - 1) {
      return true;
    } else {
      return false;
    }
  }

  void reset() {
    _questionNumber = 0;
  }
}
