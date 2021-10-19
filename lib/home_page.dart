import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:quiz/quiz_brain.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

QuizBrain quizBrain = QuizBrain();

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Icon> checkList = [];
  int score = 0;

  int getFlexOrientation() {
    if (MediaQuery.of(context).orientation == Orientation.landscape) {
      return 2;
    } else {
      return 1;
    }
  }

  void checkAnswer(bool userPickedAnswer) {
    bool correctAnswer = quizBrain.getQuestionAnswer();
    bool flag = false;
    setState(() {
      if (quizBrain.isFinished() == true) {
        Alert(
            context: context,
            title: "Finished!",
            content: Column(
              children: [
                Text('Your total score is $score'),
              ],
            ),
            buttons: [
              DialogButton(
                onPressed: () => Navigator.pop(context),
                child: const Text(
                  "Go back",
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
              )
            ]).show();

        quizBrain.reset();
        checkList = [];
        score = 0;
        flag = true;
      } else {
        if (correctAnswer == userPickedAnswer) {
          checkList.add(const Icon(Icons.check, color: Colors.green));
          score++;
        } else {
          checkList.add(const Icon(Icons.close, color: Colors.red));
        }
        quizBrain.nextQuestion();
      }
      //
      // if (flag) {
      //   if (correctAnswer == userPickedAnswer) {
      //     checkList.add(const Icon(Icons.check, color: Colors.green));
      //     score++;
      //   } else {
      //     checkList.add(const Icon(Icons.close, color: Colors.red));
      //   }
      //   flag = false;
      // }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Center(
        child: Scaffold(
          backgroundColor: Colors.black87,
          appBar: AppBar(
            title: const Text(
              'QUIZ SHOW',
            ),
            centerTitle: true,
          ),
          body: SizedBox(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: Column(
              // mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  flex: 7,
                  child: Container(
                    alignment: Alignment.center,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        quizBrain.getQuestionText(),
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                            color: Colors.white, fontSize: 20.0),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: getFlexOrientation(),
                  child: InkWell(
                    onTap: () {
                      checkAnswer(true);
                    },
                    child: SizedBox(
                      height: MediaQuery.of(context).size.height * 0.4,
                      width: MediaQuery.of(context).size.width * 0.8,
                      child: Container(
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.green),
                          color: Colors.green,
                        ),
                        child: const Text(
                          'True',
                          style: TextStyle(color: Colors.white, fontSize: 25.0),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 30.0,
                ),
                Expanded(
                  flex: getFlexOrientation(),
                  child: InkWell(
                    onTap: () {
                      checkAnswer(false);
                    },
                    child: SizedBox(
                      height: 100,
                      width: MediaQuery.of(context).size.width * 0.8,
                      child: Container(
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.red),
                            color: Colors.red),
                        child: const Text(
                          'False',
                          style: TextStyle(color: Colors.white, fontSize: 25.0),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 30.0,
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16.0, vertical: 0),
                  child: Row(
                    children: checkList,
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
